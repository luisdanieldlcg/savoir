import 'package:flutter/material.dart';
import 'package:savoir/common/theme.dart';

class Rating extends StatelessWidget {
  final double rating;
  final bool removeBackground;

  const Rating({
    super.key,
    required this.rating,
    this.removeBackground = false,
  }) : assert(rating >= 0 && rating <= 5);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        // color: Colors.grey.withOpacity(0.2),
        color: removeBackground ? Colors.transparent : Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          5,
          (index) => Icon(
            Icons.star,
            // color: index < restaurant.rating ? AppTheme.primaryColor : Colors.grey,
            color: index < rating ? AppTheme.primaryColor : Colors.grey,
          ),
        ),
      ),
    );
  }
}
