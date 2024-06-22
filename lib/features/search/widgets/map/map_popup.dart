import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savoir/common/theme.dart';

class MapPopup extends StatelessWidget {
  final bool isSelected;
  final String title;
  const MapPopup({super.key, required this.isSelected, required this.title});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 42,
      child: Column(
        children: [
          Stack(
            children: [
              SvgPicture.asset(
                "assets/images/popup.svg",
                width: 42,
                height: 42,
                colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                fit: BoxFit.cover,
              ),
              SvgPicture.asset(
                "assets/images/popup.svg",
                width: 40,
                height: 40,
                colorFilter: ColorFilter.mode(
                    isSelected ? AppTheme.primaryColor : Colors.white, BlendMode.srcIn),
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      // color: Colors.white,
                      color: isSelected ? Colors.white : Color.fromARGB(255, 68, 68, 68),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
