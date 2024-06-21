// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:savoir/common/constants.dart';
import 'package:savoir/common/logger.dart';
import 'package:savoir/features/search/model/place_autocomplete.dart';

final _logger = AppLogger.getLogger(SearchController);
final autoCompleteProvider = FutureProvider.family((ref, query) async {
  final dio = Dio();
  final url = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
      "?input=$query"
      "&key=$kGoogleApiTestKey";

  _logger.i('Autocomplete Request: $url');
  final response = await dio.get(url);
  final autoComplete = PlaceAutoComplete.fromMap(response.data);
  _logger.i('Autocomplete Request Response: $response');

  return autoComplete;
});

class SearchState {
  final PlaceAutoComplete? autocomplete;
  final bool loading;
  const SearchState({
    required this.autocomplete,
    required this.loading,
  });

  SearchState copyWith({
    PlaceAutoComplete? autocomplete,
    bool? loading,
  }) {
    return SearchState(
      autocomplete: autocomplete ?? this.autocomplete,
      loading: loading ?? this.loading,
    );
  }
}

final restaurantSearchProvider = StateNotifierProvider<SearchController, SearchState>((ref) {
  return SearchController(SearchState(autocomplete: null, loading: false), ref: ref);
});

class SearchController extends StateNotifier<SearchState> {
  final Ref ref;
  SearchController(SearchState state, {required this.ref})
      : super(SearchState(autocomplete: null, loading: false));

  void update(String query) async {
    state = state.copyWith(loading: true);
    final autoComplete = await ref.read(autoCompleteProvider(query).future);
    state = state.copyWith(autocomplete: autoComplete, loading: false);
  }
}
