import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/common/widgets/rounded_text_input.dart';
import 'package:savoir/features/search/controller/restaurant_map_controller.dart';
import 'package:savoir/router.dart';

class SearchAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 64),
        child: title('Búsqueda'),
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
                    onChanged: (value) {
                      ref.read(restaurantMapProvider.notifier).filterResults(value);
                    },
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
