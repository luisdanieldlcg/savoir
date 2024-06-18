import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/common/widgets/user_avatar.dart';

class RestaurantMapView extends ConsumerStatefulWidget {
  const RestaurantMapView({super.key});

  @override
  ConsumerState<RestaurantMapView> createState() => _RestaurantMapViewState();
}

final locationProvider = FutureProvider<LocationData?>((ref) async {
  final location = Location();
  // return Location().getLocation();
  bool enabled = await location.serviceEnabled();
  if (!enabled) {
    enabled = await location.requestService();
    if (!enabled) {
      return null;
    }
  }

  final permission = await location.hasPermission();
  if (permission == PermissionStatus.denied) {
    final newPermission = await location.requestPermission();
    if (newPermission != PermissionStatus.granted) {
      return null;
    }
  }

  return location.getLocation();
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
