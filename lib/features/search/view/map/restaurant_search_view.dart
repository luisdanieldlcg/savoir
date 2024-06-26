import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:savoir/common/constants.dart';
import 'package:savoir/common/logger.dart';
import 'package:savoir/common/widgets/pulse_progress_indicator.dart';
import 'package:savoir/common/widgets/rounded_text_input.dart';
import 'package:savoir/features/search/controller/restaurant_map_controller.dart';
import 'package:savoir/features/search/controller/restaurant_search_controller.dart';
import 'package:savoir/features/search/model/place.dart';

class RestaurantSearchView extends ConsumerStatefulWidget {
  const RestaurantSearchView({super.key});

  @override
  ConsumerState<RestaurantSearchView> createState() => _RestaurantSearchViewState();
}

class _RestaurantSearchViewState extends ConsumerState<RestaurantSearchView> {
  static final _logger = AppLogger.getLogger(RestaurantSearchView);
  @override
  Widget build(BuildContext context) {
    final searchController = ref.watch(restaurantSearchProvider);
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 36,
          child: RoundedTextInput(
            hintText: 'Buscar restaurantes',
            leftIcon: Icon(Icons.search),
            onTap: () {},
            onChanged: ref.read(restaurantSearchProvider.notifier).update,
          ),
        ),
      ),
      body: searchController.loading
          ? PulseProgressIndicator()
          : searchController.autocomplete == null
              ? const Center(child: Text('No results found'))
              : ListView.builder(
                  itemCount: searchController.autocomplete!.predictions.length,
                  itemBuilder: (context, index) {
                    final prediction = searchController.autocomplete!.predictions[index];
                    return ListTile(
                      onTap: () async {
                        final nav = Navigator.of(context);
                        final req = "https://maps.googleapis.com/maps/api/place/details/json"
                            "?place_id=${prediction.placeId}"
                            "&reference=${prediction.reference}"
                            "&fields=geometry"
                            "&key=$kGoogleApiTestKey";
                        _logger.i('Request: $req');
                        final response = await Dio().get(req);
                        final geometry = Geometry.fromMap(response.data["result"]["geometry"]);
                        _logger.i('Response: $geometry');

                        final map = ref.read(restaurantMapProvider.notifier);
                        map.moveCamera(LatLng(geometry.location.lat, geometry.location.lng));
                        map.refresh(LatLng(geometry.location.lat, geometry.location.lng));
                        nav.pop();
                      },
                      title: Text(prediction.description),
                      leading: Icon(Icons.location_on),
                    );
                  },
                ),
    );
  }
}
