import 'dart:async';

import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:savoir/common/constants.dart';
import 'package:savoir/common/logger.dart';
import 'package:savoir/common/providers.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/common/widgets/user_avatar.dart';
import 'package:savoir/features/search/model/place.dart';
import 'package:savoir/features/search/widgets/map/search_modal.dart';
import 'package:savoir/features/search/widgets/map/search_popup.dart';
import 'package:savoir/features/search/widgets/map/search_result_count.dart';

class RestaurantMapView extends ConsumerStatefulWidget {
  const RestaurantMapView({super.key});

  @override
  ConsumerState<RestaurantMapView> createState() => _RestaurantMapViewState();
}

final _logger = AppLogger.getLogger(RestaurantMapView);

final initLocation = FutureProvider<LocationData?>((ref) async {
  try {
    final location = ref.watch(locationProvider);
    _logger.i('Getting location');
    bool enabled = await location.serviceEnabled();
    if (!enabled) {
      enabled = await location.requestService();
      if (!enabled) {
        _logger.e('Location service not enabled');
        return null;
      }
    }
    _logger.i('Checking location permission');
    final permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      _logger.i('Requesting location permission');
      final newPermission = await location.requestPermission();
      if (newPermission != PermissionStatus.granted) {
        _logger.e('Location permission not granted');
        return null;
      }
    }
    _logger.i('Location permission granted');
    return location.getLocation();
  } catch (e) {
    _logger.e('Error getting location: $e');
    return null;
  }
});

final nearbyRestaurants = FutureProvider.family<Place, (double, double)>((ref, coords) async {
  final dio = Dio();
  final url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
      "?location=${coords.$1},${coords.$2}"
      "&radius=1500"
      "&type=restaurant"
      "&key=$kGoogleApiTestKey";
  _logger.i('Places API Http Request: $url');
  final response = await dio.get(url);
  final p = Place.fromMap(response.data);
  _logger.i('Places API Response: ${p.restaurants}');
  return p;
});

class _RestaurantMapViewState extends ConsumerState<RestaurantMapView> {
  final _mapController = Completer<GoogleMapController>();

  Restaurant? _selectedRestaurant;

  @override
  Widget build(BuildContext context) {
    final user = getUserOrLogOut(ref, context);
    final loc = ref.watch(initLocation);
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurantes Cercanos'),
      ),
      body: loc.when(
        data: (LocationData? locationData) {
          if (locationData == null) {
            return const Center(child: Text('Location not available'));
          }
          final restaurants = ref.watch(
            nearbyRestaurants((locationData.latitude!, locationData.longitude!)),
          );
          return restaurants.when(
            data: (place) {
              final popups = place.restaurants.map((restaurant) {
                return MarkerData(
                  marker: Marker(
                    consumeTapEvents: true,
                    onTap: () => setState(() => _selectedRestaurant = restaurant),
                    markerId: MarkerId(restaurant.name),
                    position:
                        LatLng(restaurant.geometry.location.lat, restaurant.geometry.location.lng),
                  ),
                  child: SearchPopup(
                    isSelected: _selectedRestaurant == restaurant,
                    title: restaurant.rating.toString(),
                  ),
                );
              });
              return Stack(
                children: [
                  CustomGoogleMapMarkerBuilder(
                    builder: (context, markers) {
                      return GoogleMap(
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            locationData.latitude!,
                            locationData.longitude!,
                          ),
                          zoom: 14,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          if (!_mapController.isCompleted) {
                            _mapController.complete(controller);
                          }
                        },
                        markers: markers ?? <Marker>{},
                      );
                    },
                    customMarkers: [
                      MarkerData(
                        marker: Marker(
                          markerId: MarkerId('user'),
                          position: LatLng(locationData.latitude!, locationData.longitude!),
                          infoWindow: InfoWindow(
                            title: 'You are here',
                          ),
                        ),
                        child: UserAvatar(
                          imageSrc: user!.profilePicture,
                          radius: 24,
                          withBorder: false,
                        ),
                      ),
                      ...popups,
                    ],
                  ),
                  _selectedRestaurant == null
                      ? const SizedBox.shrink()
                      : SearchModal(restaurant: _selectedRestaurant!),
                  SearchResultCount(count: place.restaurants.length),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) {
              return ErrorScreen(error: error.toString(), stackTrace: stackTrace.toString());
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => ErrorScreen(
          error: error.toString(),
          stackTrace: stackTrace.toString(),
        ),
      ),
    );
  }
}
