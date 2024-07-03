import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/parser.dart';
import 'package:savoir/common/constants.dart';

import 'package:savoir/common/logger.dart';
import 'package:savoir/common/theme.dart';
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

final menuScrapper = FutureProvider.family<String, String>((ref, restaurantName) async {
  const cseId = "f332eac292a7f486f";

  final url =
      'https://www.googleapis.com/customsearch/v1?q=${restaurantName.replaceAll(' ', '+')}+menu&cx=$cseId&searchType=image&key=$kGoogleApiTestKey';
  _logger.i("Scrapping menu: $url");
  final response = await Dio().get(url);
  final items = response.data['items'] as List;
  if (items.isEmpty) {
    return "";
  }
  final firstItem = items.first;
  final link = firstItem['link'] as String;
  return link;
});

class RestaurantMenuTab extends ConsumerWidget {
  final RestaurantDetails details;
  final String restaurantName;
  const RestaurantMenuTab({
    super.key,
    required this.details,
    required this.restaurantName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (details.website == null || details.website!.isEmpty) {
      return Center(child: Text("No hay menú disponible"));
    }
    final scrapper = ref.watch(menuScrapper(restaurantName));
    return scrapper.when(
      data: (menu) {
        _logger.i("Displaying image from: $menu");
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
            child: menu.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.restaurant_menu, size: 100),
                        Text("El menú no está disponible"),
                      ],
                    ),
                  )
                : GestureDetector(
                    // zoom
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: InteractiveViewer(child: Image.network(menu)),
                          );
                        },
                      );
                    },
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(menu),
                      ),
                    ),
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
