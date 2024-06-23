import 'package:flutter/material.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/widgets/rounded_text_input.dart';
import 'package:savoir/router.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: const Text(
          'Explora',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      toolbarHeight: 144,
      titleSpacing: 18,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: RoundedTextInput(
                    hintText: 'Buscar restaurantes',
                    leftIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: Icon(
                    Icons.map,
                    size: 32,
                    color: AppTheme.primaryColor,
                  ),
                  onPressed: () => Navigator.of(context).pushNamed(AppRouter.restaurantsMap),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(144);
}
