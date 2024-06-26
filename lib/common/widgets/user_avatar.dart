import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:savoir/common/theme.dart';

class UserAvatar extends StatelessWidget {
  final String imageSrc;
  final double size;
  final bool withBorder;
  final bool zoomOnTap;
  const UserAvatar({
    super.key,
    required this.imageSrc,
    this.size = 128,
    this.withBorder = true,
    this.zoomOnTap = false,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageSrc,

      imageBuilder: (context, imageProvider) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            border: Border.all(
              color: withBorder ? AppTheme.secondaryColor : Colors.transparent,
              width: 1,
            ),
          ),
        );
      },

      // circular progress indicator with white red color slim
      placeholder: (context, url) {
        return SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            color: AppTheme.primaryColor,
            strokeWidth: 2,
          ),
        );
      },
    );
  }
}
