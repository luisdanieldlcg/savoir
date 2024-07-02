import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/parser.dart';

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

final menuScrapper = FutureProvider.family<String, String>((ref, website) async {
  // scrap google search
  final dio = Dio();
  final url = "https://www.google.com/search?q=$website+menu&tbm=isch";
  _logger.i("Scraping: $url");
  final response = await dio.get(url);
  final document = parse(response.data);
  final elements = document.querySelectorAll("a");
  final menu = elements.map((e) {
    final href = e.attributes["href"];
    if (href != null && href.contains("imgurl=")) {
      final start = href.indexOf("imgurl=") + 7;
      final end = href.indexOf("&", start);
      return href.substring(start, end);
    }
    return "";
  }).toList();
  _logger.i("Menu: ${menu[0]}");
  return menu[0];
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
                : ListView.builder(
                    itemCount: menu.length,
                    itemBuilder: (context, index) {
                      final dish = menu[index];
                      return Column(
                        children: [
                          // ListTile(
                          //   leading: const Icon(Icons.restaurant_menu),
                          //   title: Text(dish.name),
                          //   trailing: Text(
                          //     '\$${dish.price.toStringAsFixed(2)}',
                          //     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          //   ),
                          // ),
                          // ListTileDivider(),

                          Image.network(menu[index]),
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
