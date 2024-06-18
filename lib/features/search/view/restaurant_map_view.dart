import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:savoir/common/logger.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/common/widgets/user_avatar.dart';

class RestaurantMapView extends ConsumerStatefulWidget {
  const RestaurantMapView({super.key});

  @override
  ConsumerState<RestaurantMapView> createState() => _RestaurantMapViewState();
}

final _logger = AppLogger.getLogger(RestaurantMapView);

final locationProvider = FutureProvider<LocationData?>((ref) async {
  try {
    final location = Location();
    // return Location().getLocation();
    _logger.i('Getting location');
    bool enabled = await location.serviceEnabled();
    if (!enabled) {
      enabled = await location.requestService();
      if (!enabled) {
        _logger.e('Location service not enabled');
        return null;
      }
    }
    _logger.i('Location service enabled');
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

class _RestaurantMapViewState extends ConsumerState<RestaurantMapView> {
  final _mapController = Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    final user = getUserOrLogOut(ref, context);
    final loc = ref.watch(locationProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Map View'),
      ),
      body: loc.when(
        data: (LocationData? locationData) {
          if (locationData == null) {
            return const Center(child: Text('Location not available'));
          }
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: const LatLng(37.42796133580664, -122.085749655962),
                  zoom: 14,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _mapController.complete(controller);
                },
              ),
              Positioned(
                child: UserAvatar(
                  imageSrc: user!.profilePicture,
                ),
              )
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
