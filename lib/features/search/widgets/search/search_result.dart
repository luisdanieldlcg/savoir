import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/common/widgets/rating.dart';
import 'package:savoir/features/search/model/place.dart';
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
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: GestureDetector(
            onTap: () => onTap(restaurant),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // rotated label that indicates whether the restaurant is open or closed
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: restaurant.photos.isEmpty
                          ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png"
                          : photoFromReferenceGoogleAPI(restaurant.photos[0].photoReference),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 240,
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
                  trailing: Rating(
                    rating: restaurant.rating,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
