import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:savoir/common/theme.dart';

class ThreeDotProgressIndicator extends StatelessWidget {
  final String loadingText;
  const ThreeDotProgressIndicator({
    super.key,
    this.loadingText = 'Cargando...',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitThreeBounce(
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
        ),
        const SizedBox(height: 20),
        Text(
          loadingText,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
