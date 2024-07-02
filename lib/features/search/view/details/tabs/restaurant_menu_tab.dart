import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  return "https://marketplace.canva.com/EAFwRADHMsM/1/0/1035w/canva-orange-and-black-bold-geometric-restaurant-menu-AX4bhelWqNA.jpg";
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
                // : Image.network(menu, fit: BoxFit.cover),

                // the image is not fitting the screen
                // : Container(
                //     decoration: BoxDecoration(
                //       image: DecorationImage(
                //         image: NetworkImage(menu),
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                // allow to scroll the image
                : SingleChildScrollView(
                    child: Image.network(menu, fit: BoxFit.cover),
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
