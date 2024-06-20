import 'dart:async';

import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:savoir/common/constants.dart';
import 'package:savoir/common/logger.dart';
import 'package:savoir/common/providers.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/common/widgets/user_avatar.dart';
import 'package:savoir/features/search/model/place.dart';

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
  _logger.i('Places API Response: ${p.results}');
  return p;
});

class _RestaurantMapViewState extends ConsumerState<RestaurantMapView> {
  final _mapController = Completer<GoogleMapController>();
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
              final markers = place.results
                  .where((result) => result.types[0] == "restaurant" && result.types.length == 1)
                  .map(
                (r) {
                  _logger.i('Types of this marker: ${r.types}, name: ${r.name}');
                  return Marker(
                    markerId: MarkerId(r.name),
                    position: LatLng(r.geometry.location.lat, r.geometry.location.lng),
                    infoWindow: InfoWindow(
                      title: r.name,
                    ),
                    onTap: () async {},
                  );
                },
              ).toList();
              markers.add(
                Marker(
                  markerId: MarkerId('user'),
                  position: LatLng(locationData.latitude!, locationData.longitude!),
                  infoWindow: InfoWindow(
                    title: 'You are here',
                  ),
                ),
              );
              return Stack(
                children: [
                  CustomGoogleMapMarkerBuilder(
                    builder: (context, markers) {
                      return GoogleMap(
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
                        // markers: markers!,
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
                      for (final r in place.results)
                        MarkerData(
                          marker: Marker(
                            markerId: MarkerId(r.name),
                            position: LatLng(r.geometry.location.lat, r.geometry.location.lng),
                            infoWindow: InfoWindow(
                              title: r.name,
                            ),
                          ),
                          child: SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                // circle indicator
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),

                  // bottom sheet with restaurant details on tap
                  DraggableScrollableSheet(
                    initialChildSize: 0.1,
                    minChildSize: 0.1,
                    maxChildSize: 0.5,
                    builder: (context, scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: place.results.length,
                          itemBuilder: (context, index) {
                            final r = place.results[index];
                            final photos = r.photos;
                            return ListTile(
                              title: Text(r.name),
                              subtitle: Text(r.vicinity),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                // show restaurant details
                              },
                              // leading: photos.isNotEmpty && photos[0].photoReference != ''
                              //     ? Image.network(getPhotoUrl(photos[0].photoReference!))
                              //     : null,

                              leading: CircleAvatar(
                                backgroundImage:
                                    photos.isNotEmpty && photos[0].photoReference != null
                                        ? NetworkImage(getPhotoUrl(photos[0].photoReference!))
                                        : null,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
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

  String getPhotoUrl(String photoReference) {
    final url =
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=$photoReference&key=$kGoogleApiTestKey";
    _logger.i('Photo URL: $url');
    return url;
  }
}
