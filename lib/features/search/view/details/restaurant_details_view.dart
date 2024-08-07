import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/constants.dart';
import 'package:savoir/common/database_repository.dart';
import 'package:savoir/common/logger.dart';

import 'package:savoir/common/theme.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/common/widgets/three_dot_progress_indicator.dart';
import 'package:savoir/features/auth/model/favorite_model.dart';
import 'package:savoir/features/search/model/restaurant_details.dart';
import 'package:savoir/features/search/view/details/tabs/restaurant_details_info_tab.dart';
import 'package:savoir/features/search/view/details/tabs/restaurant_menu_tab.dart';
import 'package:savoir/features/search/view/details/tabs/restaurant_reviews_tab.dart';
import 'package:savoir/features/search/widgets/details/restaurant_details_appbar.dart';
import 'package:savoir/features/search/widgets/details/restaurant_details_summary.dart';

class RestaurantDetailsView extends ConsumerStatefulWidget {
  // final Restaurant restaurant;

  final RestaurantSummary summary;
  const RestaurantDetailsView({
    super.key,
    required this.summary,
  });

  @override
  ConsumerState<RestaurantDetailsView> createState() => _RestaurantDetailsViewState();
}

final _logger = AppLogger.getLogger(RestaurantDetailsView);

final restaurantDetailsProvider = FutureProvider.family<RestaurantDetails, String>((ref, id) async {
  final req =
      "https://maps.googleapis.com/maps/api/place/details/json?place_id=$id&language=es&key=$kGoogleApiTestKey";
  _logger.i('Restaurant Details API Http Request: $req');
  final details = await Dio().get(req);
  _logger.i('Restaurant Details API Response: ${details.data}');
  final restaurant = RestaurantDetails.fromMap(details.data['result']);

  final reviewsOnDatabase = (await ref.read(databaseRepositoryProvider).readComments(id)).map(
    (reviewModel) {
      String relativeTimeDescription;
      if (DateTime.now().difference(reviewModel.date).inDays > 7) {
        relativeTimeDescription =
            "Hace ${DateTime.now().difference(reviewModel.date).inDays ~/ 7} semanas";
      } else {
        relativeTimeDescription = "Hace ${DateTime.now().difference(reviewModel.date).inDays} días";
      }
      if (DateTime.now().difference(reviewModel.date).inDays > 30) {
        relativeTimeDescription =
            "Hace ${DateTime.now().difference(reviewModel.date).inDays ~/ 30} meses";
      }

      if (DateTime.now().difference(reviewModel.date).inDays > 365) {
        relativeTimeDescription =
            "Hace ${DateTime.now().difference(reviewModel.date).inDays ~/ 365} años";
      }

      if (relativeTimeDescription == "Hace 0 días") {
        relativeTimeDescription = "Hoy";
      }
      return RestaurantComment(
        text: reviewModel.review,
        time: reviewModel.date.millisecondsSinceEpoch,
        rating: reviewModel.rating.toDouble(),
        authorName: reviewModel.authorName,
        profilePhotoUrl: reviewModel.profileImage,
        relativeTimeDescription: relativeTimeDescription,
      );
    },
  );

  final reviewsOnApi = restaurant.reviews;
  final allReviews = List<RestaurantComment>.from(reviewsOnDatabase)..addAll(reviewsOnApi);
  // sort reviews by date
  allReviews.sort((a, b) => b.time.compareTo(a.time));

  return restaurant.copyWith(reviews: allReviews);
});

class _RestaurantDetailsViewState extends ConsumerState<RestaurantDetailsView> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final details = ref.watch(restaurantDetailsProvider(widget.summary.placeId));
    return Scaffold(
      appBar: RestaurantDetailsAppBar(
        summary: widget.summary,
      ),

      body: ListView(
        children: [
          const SizedBox(height: 16),
          RestaurantDetailsSummary(restaurant: widget.summary),
          const SizedBox(height: 16),
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
                          height: 420,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                RestaurantMenuTab(
                                  restaurant: widget.summary,
                                  details: restaurantDetails,
                                ),
                                RestaurantDetailsInfoTab(
                                  restaurant: widget.summary,
                                  details: restaurantDetails,
                                ),
                                RestaurantReviewsTab(
                                  details: restaurantDetails,
                                  placeId: widget.summary.placeId,
                                ),
                              ],
                            ),
                          ),
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
              loading: () => ThreeDotProgressIndicator(
                loadingText: "Espere un momento...",
              ),
            ),
          ),
        ],
      ),
      // loading indicator on bottom
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
