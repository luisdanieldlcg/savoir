// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:savoir/common/util.dart';
import 'package:savoir/features/search/model/place.dart';

class FavoriteModel {
  final List<RestaurantSummary> restaurants;
  final String userId;
  const FavoriteModel({
    required this.userId,
    required this.restaurants,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'restaurants': restaurants.map((x) => x.toMap()).toList(),
      'userId': userId,
    };
  }

  @override
  String toString() => 'FavoriteModel(restaurants: $restaurants)';

  FavoriteModel copyWith({
    List<RestaurantSummary>? restaurants,
    String? userId,
  }) {
    return FavoriteModel(
      restaurants: restaurants ?? this.restaurants,
      userId: userId ?? this.userId,
    );
  }

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      restaurants: map['restaurants'] == null
          ? []
          : List<RestaurantSummary>.from(
              (map['restaurants'] as List).map(
                (x) => RestaurantSummary.fromMap(x as Map<String, dynamic>),
              ),
            ),
      userId: map['userId'] as String,
    );
  }
}

class RestaurantSummary {
  final String name;
  final String addr;
  final String photo;
  final String placeId;
  final double rating;
  const RestaurantSummary({
    required this.name,
    required this.addr,
    required this.photo,
    required this.placeId,
    required this.rating,
  });

  RestaurantSummary.fromRestaurant(Restaurant restaurant)
      : this(
          name: restaurant.name,
          addr: restaurant.formattedAddress,
          photo: restaurant.photos.isEmpty
              ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png'
              : photoFromReferenceGoogleAPI(restaurant.photos[0].name),
          placeId: restaurant.placeId,
          rating: restaurant.rating,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'vicinity': addr,
      'photo': photo,
      'placeId': placeId,
      'rating': rating,
    };
  }

  factory RestaurantSummary.fromMap(Map<String, dynamic> map) {
    return RestaurantSummary(
      name: map['name'] as String,
      addr: map['vicinity'] as String,
      photo: map['photo'] as String,
      placeId: map['placeId'] as String,
      rating: map['rating'] as double,
    );
  }
}
