import 'package:flutter/material.dart';

class ListTileDivider extends StatelessWidget {
  const ListTileDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.black.withOpacity(0.1),
      height: 10,
      thickness: 1,
      indent: 20,
      endIndent: 20,
    );
  }
}
