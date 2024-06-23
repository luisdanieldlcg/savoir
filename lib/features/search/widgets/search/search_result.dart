import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/features/search/model/place.dart';

class SearchResult extends ConsumerWidget {
  final List<Restaurant> restaurants;
  const SearchResult({
    super.key,
    required this.restaurants,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: restaurants.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      restaurant.photos.isEmpty
                          ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png"
                          : photoFromReferenceGoogleAPI(restaurant.photos[0].photoReference),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 200,
              ),
              ListTile(
                title: Text(
                  restaurant.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: [
                    Icon(Icons.location_on, color: AppTheme.primaryColor),
                    Expanded(
                      child: Text(
                        restaurant.vicinity,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
                trailing: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        color: index < restaurant.rating ? AppTheme.primaryColor : Colors.grey,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
