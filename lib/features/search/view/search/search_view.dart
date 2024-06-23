import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/features/search/controller/restaurant_map_controller.dart';
import 'package:savoir/features/search/widgets/search/search_appbar.dart';
import 'package:savoir/features/search/widgets/search/search_result.dart';
import 'package:savoir/router.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    onTap: (restaurant) => Navigator.pushNamed(
                      context,
                      AppRouter.restaurantDetails,
                      arguments: restaurant,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
