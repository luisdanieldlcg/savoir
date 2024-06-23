import 'package:flutter/material.dart';
import 'package:savoir/common/theme.dart';

class RestaurantDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String restaurantImage;
  const RestaurantDetailsAppBar({
    super.key,
    required this.restaurantImage,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 106,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(AppTheme.primaryColor),
          backgroundColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          image: DecorationImage(
            image: NetworkImage(restaurantImage),
            fit: BoxFit.cover,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: IconButton(
            icon: Icon(Icons.favorite_border),
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(AppTheme.primaryColor),
              backgroundColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(144);
}
