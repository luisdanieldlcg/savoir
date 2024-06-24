import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/features/auth/model/favorite_model.dart';
import 'package:savoir/features/search/model/controller/restaurant_map_controller.dart';
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
                    onTap: (restaurant) {
                      final restaurantImage = restaurant.photos.isEmpty
                          ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png"
                          : photoFromReferenceGoogleAPI(restaurant.photos[0].photoReference);
                      return Navigator.pushNamed(
                        context,
                        AppRouter.restaurantDetails,
                        arguments: RestaurantSummary(
                          name: restaurant.name,
                          vicinity: restaurant.vicinity,
                          photo: restaurantImage,
                          placeId: restaurant.placeId,
                          rating: restaurant.rating,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
