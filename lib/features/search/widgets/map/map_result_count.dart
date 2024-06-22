import 'package:flutter/material.dart';

class MapResultCount extends StatelessWidget {
  final int count;
  const MapResultCount({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        color: Colors.white,
        child: Text(
          'Se encontraron $count restaurantes',
          style: TextStyle(
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
