import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/logger.dart';

import 'package:savoir/common/theme.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/common/widgets/three_dot_progress_indicator.dart';
import 'package:savoir/features/favorites/controller/favorites_controller.dart';
import 'package:savoir/features/search/model/place.dart';
import 'package:savoir/features/search/model/restaurant_details.dart';
import 'package:savoir/features/search/view/details/tabs/restaurant_details_info_tab.dart';
import 'package:savoir/features/search/view/details/tabs/restaurant_reviews_tab.dart';
import 'package:savoir/features/search/widgets/details/restaurant_details_appbar.dart';
import 'package:savoir/features/search/widgets/details/restaurant_details_summary.dart';

class RestaurantDetailsView extends ConsumerStatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailsView({
    super.key,
    required this.restaurant,
  });

  @override
  ConsumerState<RestaurantDetailsView> createState() => _RestaurantDetailsViewState();
}

class _RestaurantDetailsViewState extends ConsumerState<RestaurantDetailsView> {
  int _selectedTab = 0;

  static final _logger = AppLogger.getLogger(RestaurantDetailsView);
  final restaurantDetailsProvider =
      FutureProvider.family<RestaurantDetails, String>((ref, id) async {
    final req =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$id&key=AIzaSyCOX4I1w7rkKkYXOytX9jxsixmolpLb5rw";
    _logger.i('Restaurant Details API Http Request: $req');
    final details = await Dio().get(req);
    _logger.i('Restaurant Details API Response: ${details.data}');
    final restaurant = RestaurantDetails.fromMap(details.data['result']);
    return restaurant;
  });

  @override
  Widget build(BuildContext context) {
    final restaurantImage = widget.restaurant.photos.isEmpty
        ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png"
        : photoFromReferenceGoogleAPI(widget.restaurant.photos[0].photoReference);
    _logger.i("Passing placeId: ${widget.restaurant.placeId}");
    final details = ref.watch(restaurantDetailsProvider(widget.restaurant.placeId));
    final updatingFavorite = ref.watch(favoritesControllerProvider);

    return Scaffold(
      appBar: RestaurantDetailsAppBar(
        restaurantImage: restaurantImage,
        restaurant: widget.restaurant,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          RestaurantDetailsSummary(restaurant: widget.restaurant),
          const SizedBox(height: 20),
          DefaultTabController(
            length: 3,
            initialIndex: _selectedTab,
            child: details.when(
              data: (restaurantDetails) {
                return Column(
                  children: [
                    TabBar(
                      dividerHeight: 0,
                      splashFactory: NoSplash.splashFactory,
                      overlayColor: WidgetStatePropertyAll(Color(0x00000000)),
                      indicator: BoxDecoration(),
                      onTap: (idx) => setState(() => _selectedTab = idx),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black.withOpacity(0.8),
                      tabs: [
                        _PrimaryTab(
                          isSelected: _selectedTab == 0,
                          title: "Menú",
                          icon: Icons.restaurant_menu,
                        ),
                        _PrimaryTab(
                          isSelected: _selectedTab == 1,
                          title: "Info",
                          icon: Icons.info,
                        ),
                        _PrimaryTab(
                          isSelected: _selectedTab == 2,
                          title: "Reseñas",
                          icon: Icons.rate_review,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        SizedBox(
                          height: 500,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                Center(child: Text("Menú")),
                                RestaurantDetailsInfoTab(
                                  restaurant: widget.restaurant,
                                  details: restaurantDetails,
                                ),
                                RestaurantReviewsTab(details: restaurantDetails),
                              ],
                            ),
                          ),
                        ),
                        if (updatingFavorite)
                          Positioned(
                            bottom: 0,
                            left: 150,
                            child: ThreeDotProgressIndicator(),
                          ),
                      ],
                    ),
                  ],
                );
              },
              error: (err, stack) => ErrorScreen(
                error: err.toString(),
                stackTrace: stack.toString(),
              ),
              loading: () => Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryTab extends StatelessWidget {
  final bool isSelected;
  final String title;
  final IconData icon;
  const _PrimaryTab({
    super.key,
    required this.isSelected,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.primaryColor : Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 6),
            Text(title),
          ],
        ),
      ),
    );
  }
}
