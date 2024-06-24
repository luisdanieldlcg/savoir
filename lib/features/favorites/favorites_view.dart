import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/providers.dart';
import 'package:savoir/features/favorites/controller/favorites_controller.dart';
import 'package:savoir/features/favorites/tabs/favorite_restaurants_tab.dart';
import 'package:savoir/router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoriteProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              dividerHeight: 0,
              tabs: const [
                Tab(text: 'Restaurantes'),
                Tab(text: 'Platos'),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                children: [
                  FavoriteRestaurantsTab(
                    favorites: favorites.restaurants,
                    onTap: (restaurant) {
                      Navigator.pushNamed(
                        context,
                        AppRouter.restaurantDetails,
                        arguments: restaurant,
                      );
                    },
                    onRemove: (restaurant) =>
                        ref.read(favoritesControllerProvider.notifier).toggleFavorite(
                              placeId: restaurant.placeId,
                              name: restaurant.name,
                              photo: restaurant.photo,
                              vicinity: restaurant.vicinity,
                              rating: restaurant.rating,
                            ),
                  ),
                  Text("Platos favoritos"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
