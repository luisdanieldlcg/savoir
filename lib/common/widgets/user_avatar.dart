import 'package:flutter/material.dart';
import 'package:savoir/common/theme.dart';

class UserAvatar extends StatelessWidget {
  final String imageSrc;
  final double radius;
  final bool withBorder;
  final bool zoomOnTap;
  const UserAvatar({
    super.key,
    required this.imageSrc,
    this.radius = 62,
    this.withBorder = true,
    this.zoomOnTap = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            barrierDismissible: true,
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Hero(
                  tag: imageSrc,
                  child: Material(
                    color: Colors.black.withOpacity(0.9),
                    child: Center(
                      child: Image.network(
                        imageSrc,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      child: CircleAvatar(
        radius: radius,
        backgroundColor: AppTheme.primaryColor,
        child: Hero(
          tag: imageSrc,
          child: ClipOval(
            child: SizedBox.fromSize(
              size: withBorder ? Size.fromRadius(radius - 2) : Size.fromRadius(radius),
              child: Image.network(
                imageSrc,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
