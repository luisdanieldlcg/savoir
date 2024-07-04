import 'package:flutter/material.dart';

import 'package:savoir/features/search/model/place.dart';

class Label {
  final dynamic iconOrEmoji;
  Label({
    required this.iconOrEmoji,
  });
}

class RestaurantSearchResultLabels extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantSearchResultLabels({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    final labels = [];
    if (restaurant.servesVegetarianFood) {
      labels.add("🥦");
    }
    if (restaurant.delivery) {
      labels.add("🚚");
    }
    if (restaurant.servesCoffee) {
      labels.add("☕");
    }
    if (restaurant.servesBeer) {
      labels.add("🍺");
    }
    if (restaurant.servesWine) {
      labels.add("🍷");
    }
    if (restaurant.reservable) {
      labels.add("📝");
    }
    if (labels.isEmpty) return SizedBox.shrink();
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        itemBuilder: (context, index) {
          final label = labels[index];
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4, bottom: 4),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(label, style: TextStyle(fontSize: 20)),
            ),
          );
        },
      ),
    );
  }
}
