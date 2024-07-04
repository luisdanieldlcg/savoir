import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/parser.dart';
import 'package:savoir/common/constants.dart';

import 'package:savoir/common/logger.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/features/search/model/restaurant_details.dart';
import 'package:shimmer/shimmer.dart';

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
          floatingActionButton: Column(
            children: [
              const Spacer(),
              FloatingActionButton.extended(
                onPressed: () {},
                label: const Text("Reservar mesa"),
                icon: const Icon(Icons.calendar_today),
                backgroundColor: AppTheme.primaryColor,
              ),
            ],
          ),
          // the floating action button should be on the bottom right
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: GestureDetector(
            onTap: () {
              // zoom the image, effect
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: InteractiveViewer(
                      child: Image.network(menu),
                    ),
                  );
                },
              );
            },
            child: CachedNetworkImage(
              imageUrl: menu,
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),  
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.white,
                  ),
                );
              },
              errorWidget: (context, url, error) => const Icon(Icons.error),
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
