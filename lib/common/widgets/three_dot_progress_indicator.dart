import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:savoir/common/theme.dart';

class ThreeDotProgressIndicator extends StatelessWidget {
  const ThreeDotProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      size: 50,
      itemBuilder: (context, index) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
          gradient: LinearGradient(
            colors: const [
              AppTheme.primaryColor,
              AppTheme.secondaryColor,
            ],
          ),
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
      ),
    );
  }
}
