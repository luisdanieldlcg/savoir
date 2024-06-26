import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:savoir/common/theme.dart';

class PersonalDetailsHeader extends StatelessWidget {
  final VoidCallback avatarCallback;

  final ImageProvider? avatar;
  const PersonalDetailsHeader({
    super.key,
    required this.avatarCallback,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: ClipOval(
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
              ),
              width: double.infinity,
              height: 170,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
          ),
          width: double.infinity,
          height: 90,
        ),
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          // cached network image using image ImageProvider. no url
          child: CachedNetworkImage(
            imageUrl: 'https://picsum.photos/200',
            imageBuilder: (context, imageProvider) {
              return Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 62,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    backgroundImage: avatar,
                    child: avatar == null
                        ? Icon(
                            Icons.camera_alt_outlined,
                            color: AppTheme.primaryColor,
                            size: 54,
                          )
                        : null,
                  ),
                ),
              );
            },
            placeholder: (context, url) {
              return Center(
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                    strokeWidth: 2,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 24,
          right: 0,
          left: 77,
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: AppTheme.secondaryColor,
              foregroundColor: Colors.white,
              shape: CircleBorder(),
            ),
            icon: Icon(Icons.edit),
            onPressed: avatarCallback,
          ),
        ),
      ],
    );
  }
}
