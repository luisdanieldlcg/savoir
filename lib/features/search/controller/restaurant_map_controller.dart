// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:savoir/common/constants.dart';
import 'package:savoir/common/logger.dart';
import 'package:savoir/common/providers.dart';
import 'package:savoir/features/search/model/place.dart';

final _logger = AppLogger.getLogger(RestaurantMapController);

final userLocationProvider = FutureProvider<LocationData?>((ref) async {
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
  final nearbySearch = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
      "?location=${coords.$1},${coords.$2}"
      "&radius=1500"
      "&type=restaurant"
      "&key=$kGoogleApiTestKey";
  _logger.i('Places API Http Request: $nearbySearch');
  final response = await dio.get(nearbySearch);
  final place = Place.fromMap(response.data);
  _logger.i('Places API Response: ${place.restaurants}');
  return place;
});

@immutable
class MapState {
  final Place place;
  final List<Restaurant> searchResults;
  final LocationData? userLocation;
  final LatLng initialCameraPosition;
  final Restaurant? focusedRestaurant;
  final bool loading;
  final bool showRefreshButton;

  const MapState({
    required this.place,
    this.userLocation,
    required this.initialCameraPosition,
    this.focusedRestaurant,
    required this.loading,
    this.showRefreshButton = false,
    this.searchResults = const [],
  });

  const MapState.loading(this.loading)
      : place = const Place(htmlAttributions: [], restaurants: [], status: ''),
        userLocation = null,
        initialCameraPosition = const LatLng(0, 0),
        showRefreshButton = false,
        focusedRestaurant = null,
        searchResults = const [];

  MapState copyWith({
    Place? place,
    LocationData? userLocation,
    LatLng? initialCameraPosition,
    Restaurant? focusedRestaurant,
    bool? loading,
    bool? showRefreshButton,
    List<Restaurant>? searchResults,
  }) {
    return MapState(
      place: place ?? this.place,
      userLocation: userLocation ?? this.userLocation,
      initialCameraPosition: initialCameraPosition ?? this.initialCameraPosition,
      focusedRestaurant: focusedRestaurant ?? this.focusedRestaurant,
      loading: loading ?? this.loading,
      showRefreshButton: showRefreshButton ?? this.showRefreshButton,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}

final restaurantMapProvider = StateNotifierProvider<RestaurantMapController, MapState>((ref) {
  final userLocation = ref.watch(userLocationProvider);
  final state = userLocation.when(
    data: (LocationData? locationData) {
      if (locationData == null) {
        return const MapState.loading(false);
      }
      final place = ref.watch(nearbyRestaurants((locationData.latitude!, locationData.longitude!)));
      return place.when(
        data: (p) {
          return MapState(
            place: p,
            initialCameraPosition: LatLng(locationData.latitude!, locationData.longitude!),
            userLocation: locationData,
            loading: false,
            searchResults: p.restaurants,
          );
        },
        loading: () => const MapState.loading(true),
        error: (e, _) {
          _logger.e('Error getting nearby restaurants: $e');
          return const MapState.loading(false);
        },
      );
    },
    loading: () => const MapState.loading(true),
    error: (e, _) {
      _logger.e('Error getting user location: $e');
      return const MapState.loading(false);
    },
  );
  return RestaurantMapController(ref, state);
});

class RestaurantMapController extends StateNotifier<MapState> {
  final MapState data;
  final Ref ref;
  final controller = Completer<GoogleMapController>();

  RestaurantMapController(this.ref, this.data) : super(data);

  void markRefresh() {
    state = state.copyWith(showRefreshButton: true);
  }

  void filterResults(String query) {
    final results = state.place.restaurants.where((r) => r.name.toLowerCase().contains(query));
    state = state.copyWith(searchResults: results.toList());
  }

  void completeController(GoogleMapController controller) {
    if (!this.controller.isCompleted) {
      this.controller.complete(controller);
    }
  }

  void moveCamera(LatLng position) async {
    final controller = await this.controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(position));
  }

  void setInitialCameraPosition(LatLng position) {
    state = state.copyWith(initialCameraPosition: position);
  }

  void setFocus(Restaurant? restaurant) => state = state.copyWith(focusedRestaurant: restaurant);

  void refresh(LatLng cameraPos) async {
    final place =
        await ref.refresh(nearbyRestaurants((cameraPos.latitude, cameraPos.longitude)).future);

    state = state.copyWith(
      place: place,
      loading: false,
      showRefreshButton: false,
      focusedRestaurant: null,
    );
  }
}
