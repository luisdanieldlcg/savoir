import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:savoir/common/logger.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/common/widgets/pulse_progress_indicator.dart';
import 'package:savoir/common/widgets/rounded_text_input.dart';
import 'package:savoir/common/widgets/user_avatar.dart';
import 'package:savoir/features/search/model/controller/restaurant_map_controller.dart';
import 'package:savoir/features/search/widgets/map/map_modal.dart';
import 'package:savoir/features/search/widgets/map/map_popup.dart';
import 'package:savoir/features/search/widgets/map/map_refresh.dart';
import 'package:savoir/features/search/widgets/map/map_result_count.dart';
import 'package:savoir/router.dart';

class RestaurantMapView extends ConsumerStatefulWidget {
  const RestaurantMapView({super.key});

  @override
  ConsumerState<RestaurantMapView> createState() => _RestaurantMapViewState();
}

final _logger = AppLogger.getLogger(RestaurantMapView);

class _RestaurantMapViewState extends ConsumerState<RestaurantMapView> {
  CameraPosition? cameraPosition;

  @override
  Widget build(BuildContext context) {
    final user = getUserOrLogOut(ref, context);
    final map = ref.watch(restaurantMapProvider);

    final popups = map.place.restaurants.map((restaurant) {
      return MarkerData(
        marker: Marker(
          consumeTapEvents: true,
          onTap: () => ref.read(restaurantMapProvider.notifier).setFocus(restaurant),
          markerId: MarkerId(restaurant.name),
          position: LatLng(restaurant.geometry.location.lat, restaurant.geometry.location.lng),
        ),
        child: MapPopup(
          isSelected: map.focusedRestaurant?.name == restaurant.name,
          title: restaurant.rating.toString(),
        ),
      );
    });

    _logger.i('Camera position: $cameraPosition');
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 36,
          child: RoundedTextInput(
            hintText: 'Search for restaurants',
            leftIcon: Icon(Icons.search),
            onTap: () => Navigator.pushNamed(context, AppRouter.restaurantSearch),
            readonly: true,
          ),
        ),
      ),
      body: map.loading
          ? const PulseProgressIndicator()
          : Stack(
              children: [
                CustomGoogleMapMarkerBuilder(
                  builder: (context, markers) {
                    return GoogleMap(
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: map.initialCameraPosition,
                        zoom: 14,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        ref.read(restaurantMapProvider.notifier).completeController(controller);
                      },
                      onCameraMove: (CameraPosition position) {
                        cameraPosition = position;
                      },
                      onCameraIdle: () {
                        if (!map.showRefreshButton) {
                          _logger.i('The refresh button is hidden');
                          ref.read(restaurantMapProvider.notifier).markRefresh();
                        }
                      },
                      markers: markers ?? <Marker>{},
                    );
                  },
                  customMarkers: [
                    MarkerData(
                      marker: Marker(
                        markerId: MarkerId('user'),
                        position: LatLng(map.userLocation!.latitude!, map.userLocation!.longitude!),
                        infoWindow: InfoWindow(
                          title: 'You are here',
                        ),
                      ),
                      child: UserAvatar(
                        withBorder: true,
                        radius: 20,
                        imageSrc: user!.profilePicture,
                      ),
                    ),
                    ...popups,
                  ],
                ),
                if (map.focusedRestaurant != null) MapModal(restaurant: map.focusedRestaurant!),
                MapResultCount(count: map.place.restaurants.length),
                if (map.showRefreshButton)
                  MapRefresh(
                      onRefresh: () =>
                          ref.read(restaurantMapProvider.notifier).refresh(cameraPosition!.target)),
              ],
            ),
    );
  }
}
