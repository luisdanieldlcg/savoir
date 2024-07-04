// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:savoir/common/database_repository.dart';
import 'package:savoir/common/logger.dart';
import 'package:savoir/common/providers.dart';
import 'package:savoir/features/auth/model/favorite_model.dart';

final favoritesControllerProvider = StateNotifierProvider<FavoritesController, bool>((ref) {
  final favorite = ref.read(favoriteProvider);
  if (favorite == null) {
    throw Exception('User is not authenticated');
  }
  return FavoritesController(
    repository: ref.read(databaseRepositoryProvider),
    ref: ref,
  );
});

class FavoritesController extends StateNotifier<bool> {
  final DatabaseRepository _repository;
  final Ref _ref;

  static final _logger = AppLogger.getLogger(FavoritesController);
  FavoritesController({
    required DatabaseRepository repository,
    required Ref ref,
  })  : _repository = repository,
        _ref = ref,
        super(false);

  Future<void> toggleFavorite({
    required String placeId,
    required String name,
    required String photo,
    required String vicinity,
    required double rating,
  }) async {
    _logger.i("Updating favorite place: $placeId");

    state = true;
    try {
      final favoriteModel = _ref.read(favoriteProvider)!;
      final isCurrentlyFavorite =
          favoriteModel.restaurants.any((element) => element.placeId == placeId);

      final updatedModel = favoriteModel.copyWith(
        restaurants: isCurrentlyFavorite
            ? favoriteModel.restaurants.where((element) => element.placeId != placeId).toList()
            : [
                ...favoriteModel.restaurants,
                RestaurantSummary(
                  name: name,
                  addr: vicinity,
                  photo: photo,
                  placeId: placeId,
                  rating: rating,
                ),
              ],
      );

      await _repository.updateFavorite(updatedModel);
      state = false;
      _ref.read(favoriteProvider.notifier).state = updatedModel;
      _logger.i(
        "Favorite place $placeId, now is ${isCurrentlyFavorite ? 'not favorite' : 'favorite'}",
      );
    } catch (e) {
      state = false;
      _logger.e("Error updating favorite place: $e");
    }
  }
}
