import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/widgets/shimmers.dart';
import 'package:savoir/features/auth/model/favorite_model.dart';
import 'package:savoir/features/search/controller/restaurant_map_controller.dart';
import 'package:savoir/features/search/widgets/search/search_appbar.dart';
import 'package:savoir/features/search/widgets/search/search_result.dart';
import 'package:savoir/router.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final map = ref.watch(restaurantMapProvider);

    return Scaffold(
      appBar: SearchAppBar(),
      body: map.loading
          ? ShimmerList(itemCount: 5)
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ListView(
                children: [
                  if (map.searchResults.isEmpty)
                    ListView(
                      shrinkWrap: true,
                      children: [
                        const SizedBox(height: 50),
                        Text(
                          "No se encontraron resultados",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  else ...{
                    SearchResult(
                      restaurants: map.searchResults,
                      onTap: (restaurant) {
                        return Navigator.pushNamed(
                          context,
                          AppRouter.restaurantDetails,
                          arguments: RestaurantSummary.fromRestaurant(restaurant),
                        );
                      },
                    ),
                  }
                ],
              ),
            ),
    );
  }
}
