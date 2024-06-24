import 'package:flutter/material.dart';
import 'package:savoir/common/theme.dart';
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
          isThreeLine: true,
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(restaurant.photo),
          ),
          title: Text(restaurant.name),
          subtitle: Text(
            restaurant.vicinity,
            maxLines: 2,
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: AppTheme.primaryColor),
            onPressed: () => onRemove(restaurant),
          ),
          onTap: () => onTap(restaurant),
        );
      },
    );
  }
}
