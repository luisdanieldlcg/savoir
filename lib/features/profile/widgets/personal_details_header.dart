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
          child: Center(
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
