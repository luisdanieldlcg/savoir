import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/features/search/controller/restaurant_map_controller.dart';
import 'package:savoir/features/search/widgets/search/search_appbar.dart';
import 'package:savoir/features/search/widgets/search/search_result.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  static final exampleRestaurants = [
    {
      "name": "La Cassina",
      "image":
          "https://cdn.sortiraparis.com/images/80/100789/834071-too-restaurant-too-hotel-paris-photos-menu-entrees.jpg",
      "location": "Av. Winston Churchill",
      "stars": 4
    },
    {
      "name": "Pizzeria Ristorante",
      "image": "https://www.glint-berlin.de/wp-content/uploads/2019/04/Berlin-Mitte-Restaurant.jpg",
      "location": "Av. Gustavo Mejía Ricart, Piantini",
      "stars": 5
    },
    {
      "name": "Café Barista",
      "image": "https://cdn.vox-cdn.com/uploads/chorus_image/image/62582192/IMG_2025.280.jpg",
      "location": "C. 14 de Junio",
      "stars": 3
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = getUserOrLogOut(ref, context);
    final map = ref.watch(restaurantMapProvider);

    return Scaffold(
      appBar: SearchAppBar(),
      body: map.loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Restaurantes cerca de ti",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "¡Déjà vu!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SearchResult(
                    restaurants: map.place.restaurants,
                  ),
                ],
              ),
            ),
    );
  }
}
