import 'package:flutter/material.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/common/widgets/rating.dart';
import 'package:savoir/features/search/model/place.dart';

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
