import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/common/widgets/rounded_text_input.dart';
import 'package:savoir/features/search/controller/restaurant_map_controller.dart';
import 'package:savoir/features/search/widgets/search/restaurant_search_filters.dart';
import 'package:savoir/router.dart';

class SearchAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  static const double toolbarHeight = 295;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final map = ref.watch(restaurantMapProvider);
    return AppBar(
      scrolledUnderElevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: title('Búsqueda'),
      ),
      toolbarHeight: 66,
      titleSpacing: 18,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: RoundedTextInput(
                    hintText: 'Buscar restaurantes',
                    leftIcon: Icon(Icons.search),
                    onChanged: (value) {
                      ref.read(restaurantMapProvider.notifier).filterByName(value);
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
            const SizedBox(height: 12),
            Text(
              "Restaurantes cerca de ti",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "¡Déjà vu!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: RestaurantSearchFilters(),
            ),
            const SizedBox(height: 7),
            Text(
              // "${map.searchResults.length} resultados",
              map.loading
                  ? "Buscando restaurantes cercanos..."
                  : "${map.searchResults.length} resultados",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
            // result count
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(toolbarHeight);
}
