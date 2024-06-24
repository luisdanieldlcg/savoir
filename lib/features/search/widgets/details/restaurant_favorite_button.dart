import 'package:flutter/material.dart';

import 'package:savoir/common/theme.dart';

class RestaurantFavoriteButton extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback onPressed;

  const RestaurantFavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
  });

  @override
  State<RestaurantFavoriteButton> createState() => _RestaurantFavoriteButtonState();
}

class _RestaurantFavoriteButtonState extends State<RestaurantFavoriteButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 75),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // add cool bounce effect
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: ScaleTransition(
          scale: Tween<double>(begin: 1, end: 1.2).animate(_controller),
          child: IconButton(
            icon: Icon(
              widget.isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(
                widget.isFavorite ? Colors.white : AppTheme.primaryColor,
              ),
              backgroundColor: WidgetStatePropertyAll(
                widget.isFavorite ? AppTheme.primaryColor : Colors.white,
              ),
            ),
            onPressed: () {
              widget.onPressed();
              _controller.forward().then((_) => _controller.reverse());
            },
          ),
        ),
      ),
    );
  }
}
