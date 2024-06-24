// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final String vicinity;
  final String photo;
  final String placeId;
  final double rating;
  RestaurantSummary({
    required this.name,
    required this.vicinity,
    required this.photo,
    required this.placeId,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'vicinity': vicinity,
      'photo': photo,
      'placeId': placeId,
      'rating': rating,
    };
  }

  factory RestaurantSummary.fromMap(Map<String, dynamic> map) {
    return RestaurantSummary(
      name: map['name'] as String,
      vicinity: map['vicinity'] as String,
      photo: map['photo'] as String,
      placeId: map['placeId'] as String,
      rating: map['rating'] as double,
    );
  }
}
