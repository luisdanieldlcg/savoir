import 'package:flutter/material.dart';
import 'package:savoir/features/auth/model/favorite_model.dart';

class FavoriteRestaurantsTab extends StatelessWidget {
  final List<RestaurantSummary> favorites;
  final Function(RestaurantSummary) onRemove;
  final Function(RestaurantSummary) onTap;
  const FavoriteRestaurantsTab({
    super.key,
    required this.favorites,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return const Center(
        child: Text('No hay restaurantes favoritos'),
      );
    }
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final restaurant = favorites[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(restaurant.photo),
          ),
          title: Text(restaurant.name),
          subtitle: Text(restaurant.vicinity),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => onRemove(restaurant),
          ),
          onTap: () => onTap(restaurant),
        );
      },
    );
  }
}
