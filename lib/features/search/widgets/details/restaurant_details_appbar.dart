// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:savoir/common/providers.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/features/auth/model/favorite_model.dart';
import 'package:savoir/features/favorites/controller/favorites_controller.dart';
import 'package:savoir/features/search/widgets/details/restaurant_favorite_button.dart';

class RestaurantDetailsAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final RestaurantSummary summary;
  const RestaurantDetailsAppBar({
    super.key,
    required this.summary,
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
      flexibleSpace: CachedNetworkImage(
        imageUrl: summary.photo,
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => Container(
          color: AppTheme.primaryColor,
        ),
      ),
      actions: [
        RestaurantFavoriteButton(
          isFavorite:
              favoriteState.restaurants.any((element) => element.placeId == summary.placeId),
          onPressed: () {
            ref.read(favoritesControllerProvider.notifier).toggleFavorite(
                  placeId: summary.placeId,
                  name: summary.name,
                  photo: summary.photo,
                  vicinity: summary.vicinity,
                  rating: summary.rating,
                );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(144);
}
