import 'package:flutter/material.dart';
import 'package:savoir/common/theme.dart';

class MapRefresh extends StatelessWidget {
  final VoidCallback onRefresh;
  const MapRefresh({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 42,
      child: FloatingActionButton(
        heroTag: 'refresh',
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
    );
  }
}
