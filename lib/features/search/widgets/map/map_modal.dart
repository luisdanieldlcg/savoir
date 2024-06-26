import 'package:flutter/material.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/features/auth/model/favorite_model.dart';
import 'package:savoir/features/search/model/place.dart';
import 'package:savoir/router.dart';

class MapModal extends StatelessWidget {
  final Restaurant restaurant;
  const MapModal({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 88,
      left: 0,
      right: 0,
      child: Align(
        child: Stack(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pushNamed(
                AppRouter.restaurantDetails,
                arguments: RestaurantSummary.fromRestaurant(restaurant),
              ),
              child: Container(
                width: 330,
                height: 140,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          restaurant.photos.isEmpty
                              ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png"
                              : photoFromReferenceGoogleAPI(restaurant.photos[0].photoReference),
                          width: 100,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                restaurant.name,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                restaurant.vicinity,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.textColor,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 2,
                              ),
                              // add also ratings..
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: AppTheme.primaryColor,
                                    size: 16,
                                  ),
                                  Text(
                                    restaurant.rating.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -1,
              left: 0,
              right: 0,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
