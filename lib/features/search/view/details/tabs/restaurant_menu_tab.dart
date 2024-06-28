import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/parser.dart';

import 'package:savoir/common/logger.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/widgets/list_tile_divider.dart';
import 'package:savoir/features/search/model/restaurant_details.dart';

final _logger = AppLogger.getLogger(RestaurantMenuTab);

class Dish {
  final String name;
  final double price;

  const Dish({
    required this.name,
    required this.price,
  });

  @override
  String toString() => 'Dish(name: $name, price: $price)';
}

final menuScrapper = FutureProvider.family<List<Dish>, String>((ref, website) async {
  _logger.i("Scraping website: $website");
  final response = await Dio().get(website);
  final document = parse(response.data);
  final menu = document.querySelectorAll('a').where((element) {
    final href = element.attributes['href'] ?? '';
    final text = element.text.toLowerCase();
    return href.contains('menu') ||
        text.contains('menu') | text.contains("order") | text.contains("ordenar");
  });
  if (menu.isEmpty) {
    _logger.i("No menu found");
    return const [];
  }

  final menuLink = menu.first.attributes['href'];
  if (menuLink == null) return const [];

  final menuUrl = Uri.parse(website).resolve(menuLink).toString();
  _logger.i("Scrapping Menu link: $menuUrl");

  final menuResponse = await Dio().get(menuUrl);
  final menuDocument = parse(menuResponse.data);

  final menuItems = menuDocument.querySelectorAll('div');
  // for each item, if the next sibling is a price, then it's a dish
  final dishes = <Dish>[];
  for (var i = 0; i < menuItems.length; i++) {
    final item = menuItems[i];
    final itemText = item.text.trim();

    // Match prices in the form $4.00 or similar
    final priceMatch = RegExp(r'\$[\d,]+\.\d{2}').firstMatch(itemText);
    if (priceMatch != null) {
      final priceText = priceMatch.group(0)!;
      final priceValue = double.tryParse(priceText.replaceAll(RegExp(r'[^\d.]'), ''));
      if (priceValue != null && priceValue > 0.0) {
        // Remove the price from the item text to get the dish name
        final itemName = itemText.replaceAll(priceText, '').trim();
        if (itemName.length > 40) {
          _logger.i("Ignoring long dish: $itemName");
          continue;
        }
        if (itemName.isNotEmpty) {
          _logger.i("Found dish: $itemName - $priceValue");
          dishes.add(Dish(name: itemName, price: priceValue));
        }
      }
    }
  }

  return dishes;
});

class RestaurantMenuTab extends ConsumerWidget {
  final RestaurantDetails details;
  const RestaurantMenuTab({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (details.website == null || details.website!.isEmpty) {
      return Center(child: Text("No hay menú disponible"));
    }
    final scrapper = ref.watch(menuScrapper(details.website!));
    return scrapper.when(
      data: (menu) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              // Navigator.pushNamed(context, AppRouter.reservation);
            },
            label: const Text("Reservar mesa"),
            icon: const Icon(Icons.calendar_today),
            backgroundColor: AppTheme.primaryColor,
          ),
          body: SizedBox(
            height: 350,
            child: ListView.builder(
              itemCount: menu.length,
              itemBuilder: (context, index) {
                final dish = menu[index];
                return Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.restaurant_menu),
                      title: Text(dish.name),
                      trailing: Text(
                        '\$${dish.price.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    ListTileDivider(),
                  ],
                );
              },
            ),
          ),
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stack) {
        return Center(child: Text("Error: $error"));
      },
    );
  }
}
