import 'package:flutter/material.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/widgets/rating.dart';
import 'package:savoir/features/auth/model/favorite_model.dart';

class RestaurantDetailsSummary extends StatelessWidget {
  final RestaurantSummary restaurant;
  const RestaurantDetailsSummary({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          restaurant.name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),

        ListTile(
          leading: Icon(Icons.location_on, color: AppTheme.primaryColor),
          title: Text(
            restaurant.vicinity,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 6),
        // rating
        Center(
          child: Rating(
            rating: restaurant.rating,
            removeBackground: true,
          ),
        ),
      ],
    );
  }
}
