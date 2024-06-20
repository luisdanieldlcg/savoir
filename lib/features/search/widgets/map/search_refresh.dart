import 'package:flutter/material.dart';
import 'package:savoir/common/theme.dart';

class SearchRefresh extends StatelessWidget {
  final VoidCallback onRefresh;
  const SearchRefresh({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 55,
      right: 120,
      child: SizedBox(
        width: 150,
        height: 42,
        child: FloatingActionButton(
          onPressed: onRefresh,
          backgroundColor: AppTheme.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              Text(
                'Buscar por aquí',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
