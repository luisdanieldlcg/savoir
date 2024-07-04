import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:savoir/common/widgets/buttons.dart';
import 'package:savoir/common/widgets/shimmers.dart';
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

  void deleteAll() {}

  void orderByName() {}

  void orderByDate() {}

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return const Center(
        child: Text('No hay restaurantes favoritos'),
      );
    }
    return ListView(
      children: [
        const SizedBox(height: 20),
        // TODO: add filters
        // Divider(
        //   color: Colors.black.withOpacity(0.1),
        //   height: 10,
        //   thickness: 1,
        //   indent: 20,
        //   endIndent: 20,
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     // Delete all icon
        //     IconButton(
        //       icon: const Icon(
        //         Icons.delete_forever,
        //         color: AppTheme.primaryColor,
        //       ),
        //       onPressed: () => deleteAll(),
        //     ),
        //     // Sort by name icon
        //     IconButton(
        //       icon: const Icon(
        //         Icons.sort_by_alpha,
        //         color: AppTheme.primaryColor,
        //       ),
        //       onPressed: () {},
        //     ),
        //     // Sort by date icon
        //     IconButton(
        //       icon: const Icon(
        //         Icons.date_range,
        //         color: AppTheme.primaryColor,
        //       ),
        //       onPressed: () {},
        //     ),
        //   ],
        // ),
        // Divider(
        //   color: Colors.black.withOpacity(0.1),
        //   height: 10,
        //   thickness: 1,
        //   indent: 20,
        //   endIndent: 20,
        // ),
        SizedBox(
          height: 550,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final restaurant = favorites[index];
              return CachedNetworkImage(
                imageUrl: restaurant.photo,
                imageBuilder: (context, imageProvider) {
                  return Column(
                    children: [
                      ListTile(
                        isThreeLine: true,
                        leading: Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(restaurant.name),
                        subtitle: Text(
                          restaurant.addr,
                          maxLines: 1,
                          style: const TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.black.withOpacity(0.5)),
                          onPressed: () => openConfirmModal(context, restaurant),
                        ),
                        onTap: () => onTap(restaurant),
                      ),
                      Divider(
                        color: Colors.black.withOpacity(0.1),
                        height: 10,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                    ],
                  );
                },
                placeholder: (context, url) => ShimmerCompact(index: index),
                errorWidget: (context, url, error) {
                  return ListTile(
                    isThreeLine: true,
                    leading: const Icon(Icons.error),
                    title: const Text('Error al cargar la imagen'),
                    subtitle: const Text('Error al cargar la imagen'),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void openConfirmModal(BuildContext context, RestaurantSummary summary) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar favorito'),
          content: Text(
            '¿Estás seguro de que quieres eliminar "${summary.name}" de tus favoritos?',
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            SizedBox(
              width: 125,
              child: SecondaryButton(
                onPressed: () => Navigator.pop(context),
                text: 'Cancelar',
              ),
            ),
            SizedBox(
              width: 125,
              child: PrimaryButton(
                onPressed: () {
                  onRemove(summary);
                  Navigator.pop(context);
                },
                text: 'Eliminar',
              ),
            ),
          ],
        );
      },
    );
  }
}
