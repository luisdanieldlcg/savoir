// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:savoir/common/providers.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/features/favorites/controller/favorites_controller.dart';
import 'package:savoir/features/search/model/place.dart';
import 'package:savoir/features/search/widgets/details/restaurant_favorite_button.dart';

class RestaurantDetailsAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final Restaurant restaurant;
  final String restaurantImage;

  const RestaurantDetailsAppBar({
    super.key,
    required this.restaurant,
    required this.restaurantImage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteState = ref.watch(favoriteProvider)!;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 106,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(AppTheme.primaryColor),
          backgroundColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          image: DecorationImage(
            image: NetworkImage(restaurantImage),
            fit: BoxFit.cover,
          ),
        ),
      ),
      actions: [
        RestaurantFavoriteButton(
          isFavorite:
              favoriteState.restaurants.any((element) => element.placeId == restaurant.placeId),
          onPressed: () {
            ref.read(favoritesControllerProvider.notifier).toggleFavorite(
                  placeId: restaurant.placeId,
                  name: restaurant.name,
                  photo: restaurantImage,
                  vicinity: restaurant.vicinity,
                );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(144);
}
