import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:savoir/common/logger.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/common/widgets/rating.dart';
import 'package:savoir/features/search/model/place.dart';
import 'package:savoir/features/search/widgets/search/restaurant_search_result_labels.dart';
import 'package:shimmer/shimmer.dart';

class SearchResult extends StatelessWidget {
  final List<Restaurant> restaurants;
  final Function(Restaurant) onTap;
  const SearchResult({
    super.key,
    required this.restaurants,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurants.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];
        final imageUrl = restaurant.photos.isEmpty
            ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png"
            : photoFromReferenceGoogleAPI(restaurant.photos[0].name);

        AppLogger.getLogger(SearchResult).i('Image URL: $imageUrl');
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: GestureDetector(
            onTap: () => onTap(restaurant),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 185,
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 240,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.error, color: Colors.red),
                              SizedBox(width: 8),
                              Text("Error cargando la imagen"),
                            ],
                          ),
                        ),
                      ),
                      placeholder: (context, url) => SizedBox(
                        height: 240,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          // color: restaurant.isOpen ? Colors.green : AppTheme.primaryColor,
                          // use a different green color
                          color: restaurant.isOpen ? Colors.green.shade600 : AppTheme.primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          restaurant.isOpen ? "Abierto" : "Cerrado",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                ListTile(
                  title: Text(
                    restaurant.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  subtitle: Row(
                    children: [
                      Icon(Icons.location_on, color: AppTheme.primaryColor),
                      Expanded(
                        child: Text(
                          restaurant.formattedAddress,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  trailing: Rating(
                    rating: restaurant.rating,
                  ),
                ),

                // add restaurant type labels
                RestaurantSearchResultLabels(
                  restaurant: restaurant,
                ),
                const SizedBox(height: 8),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                  height: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
