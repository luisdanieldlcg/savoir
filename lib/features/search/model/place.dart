// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Place {
  final List<dynamic> htmlAttributions;
  final List<Restaurant> restaurants;
  final String status;

  const Place({
    required this.htmlAttributions,
    required this.restaurants,
    required this.status,
  });

  Place copyWith({
    List<dynamic>? htmlAttributions,
    List<Restaurant>? results,
    String? status,
  }) {
    return Place(
      htmlAttributions: htmlAttributions ?? this.htmlAttributions,
      restaurants: results ?? this.restaurants,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'htmlAttributions': htmlAttributions,
      'results': restaurants.map((x) => x.toMap()).toList(),
      'status': status,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      htmlAttributions: map['htmlAttributions'] != null
          ? List<dynamic>.from((map['htmlAttributions'] as List<dynamic>))
          : [],
      restaurants: map["results"] != null
          ? List<Restaurant>.from(
              (map['results'] as List<dynamic>).map<Restaurant>(
                (x) => Restaurant.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) =>
      Place.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Place(htmlAttributions: $htmlAttributions, results: $restaurants, status: $status)';

  @override
  bool operator ==(covariant Place other) {
    if (identical(this, other)) return true;

    return listEquals(other.htmlAttributions, htmlAttributions) &&
        listEquals(other.restaurants, restaurants) &&
        other.status == status;
  }

  @override
  int get hashCode => htmlAttributions.hashCode ^ restaurants.hashCode ^ status.hashCode;
}

class Restaurant {
  final String businessStatus;
  final Geometry geometry;
  final String icon;
  final String iconBackgroundColor;
  final String iconMaskBaseUri;
  final String name;
  final OpeningHours? openingHours;
  final List<Photo> photos;
  final String placeId;
  final PlusCode plusCode;
  final double rating;
  final String reference;
  final String scope;
  final List<String> types;
  final int userRatingsTotal;
  final String vicinity;
  final int? priceLevel;

  const Restaurant({
    required this.businessStatus,
    required this.geometry,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.name,
    required this.openingHours,
    required this.photos,
    required this.placeId,
    required this.plusCode,
    required this.rating,
    required this.reference,
    required this.scope,
    required this.types,
    required this.userRatingsTotal,
    required this.vicinity,
    this.priceLevel,
  });

  Restaurant copyWith({
    String? businessStatus,
    Geometry? geometry,
    String? icon,
    String? iconBackgroundColor,
    String? iconMaskBaseUri,
    String? name,
    OpeningHours? openingHours,
    List<Photo>? photos,
    String? placeId,
    PlusCode? plusCode,
    double? rating,
    String? reference,
    String? scope,
    List<String>? types,
    int? userRatingsTotal,
    String? vicinity,
    int? priceLevel,
  }) {
    return Restaurant(
      businessStatus: businessStatus ?? this.businessStatus,
      geometry: geometry ?? this.geometry,
      icon: icon ?? this.icon,
      iconBackgroundColor: iconBackgroundColor ?? this.iconBackgroundColor,
      iconMaskBaseUri: iconMaskBaseUri ?? this.iconMaskBaseUri,
      name: name ?? this.name,
      openingHours: openingHours ?? this.openingHours,
      photos: photos ?? this.photos,
      placeId: placeId ?? this.placeId,
      plusCode: plusCode ?? this.plusCode,
      rating: rating ?? this.rating,
      reference: reference ?? this.reference,
      scope: scope ?? this.scope,
      types: types ?? this.types,
      userRatingsTotal: userRatingsTotal ?? this.userRatingsTotal,
      vicinity: vicinity ?? this.vicinity,
      priceLevel: priceLevel ?? this.priceLevel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'businessStatus': businessStatus,
      'geometry': geometry.toMap(),
      'icon': icon,
      'iconBackgroundColor': iconBackgroundColor,
      'iconMaskBaseUri': iconMaskBaseUri,
      'name': name,
      'openingHours': openingHours?.toMap(),
      'photos': photos.map((x) => x.toMap()).toList(),
      'place_id': placeId,
      'plusCode': plusCode.toMap(),
      'rating': rating,
      'reference': reference,
      'scope': scope,
      'types': types,
      'userRatingsTotal': userRatingsTotal,
      'vicinity': vicinity,
      'priceLevel': priceLevel,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Result(businessStatus: $businessStatus, geometry: $geometry, icon: $icon, iconBackgroundColor: $iconBackgroundColor, iconMaskBaseUri: $iconMaskBaseUri, name: $name, openingHours: $openingHours, photos: $photos, placeId: $placeId, plusCode: $plusCode, rating: $rating, reference: $reference, scope: $scope, types: $types, userRatingsTotal: $userRatingsTotal, vicinity: $vicinity, priceLevel: $priceLevel)';
  }

  @override
  bool operator ==(covariant Restaurant other) {
    if (identical(this, other)) return true;

    return other.businessStatus == businessStatus &&
        other.geometry == geometry &&
        other.icon == icon &&
        other.iconBackgroundColor == iconBackgroundColor &&
        other.iconMaskBaseUri == iconMaskBaseUri &&
        other.name == name &&
        other.openingHours == openingHours &&
        listEquals(other.photos, photos) &&
        other.placeId == placeId &&
        other.plusCode == plusCode &&
        other.rating == rating &&
        other.reference == reference &&
        other.scope == scope &&
        listEquals(other.types, types) &&
        other.userRatingsTotal == userRatingsTotal &&
        other.vicinity == vicinity &&
        other.priceLevel == priceLevel;
  }

  @override
  int get hashCode {
    return businessStatus.hashCode ^
        geometry.hashCode ^
        icon.hashCode ^
        iconBackgroundColor.hashCode ^
        iconMaskBaseUri.hashCode ^
        name.hashCode ^
        openingHours.hashCode ^
        photos.hashCode ^
        placeId.hashCode ^
        plusCode.hashCode ^
        rating.hashCode ^
        reference.hashCode ^
        scope.hashCode ^
        types.hashCode ^
        userRatingsTotal.hashCode ^
        vicinity.hashCode ^
        priceLevel.hashCode;
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      businessStatus: map['businessStatus'] != null ? map['businessStatus'] as String : '',
      geometry: Geometry.fromMap(map['geometry'] as Map<String, dynamic>),
      icon: map['icon'] != null ? map['icon'] as String : '',
      iconBackgroundColor:
          map['iconBackgroundColor'] != null ? map['iconBackgroundColor'] as String : '',
      iconMaskBaseUri: map['iconMaskBaseUri'] != null ? map['iconMaskBaseUri'] as String : '',
      name: map['name'] as String,
      openingHours: map['openingHours'] != null
          ? OpeningHours.fromMap(map['openingHours'] as Map<String, dynamic>)
          : null,
      photos: map["photos"] == null
          ? []
          : List<Photo>.from((map['photos'] as List<dynamic>)
              .map<Photo>((x) => Photo.fromMap(x as Map<String, dynamic>))),
      placeId: map['place_id'] != null ? map['place_id'] as String : '',
      plusCode: map['plusCode'] != null
          ? PlusCode.fromMap(map['plusCode'] as Map<String, dynamic>)
          : PlusCode(compoundCode: '', globalCode: ''),
      rating: map['rating'] != null ? double.parse(map['rating'].toString()) : 0.0,
      reference: map['reference'] != null ? map['reference'] as String : '',
      scope: map['scope'] as String,
      types: map["types"] != null
          ? List<String>.from((map['types'] as List<dynamic>).map<String>((x) => x as String))
          : [],
      userRatingsTotal: map['userRatingsTotal'] != null ? map['userRatingsTotal'] as int : 0,
      vicinity: map['vicinity'] != null ? map['vicinity'] as String : '',
      priceLevel: map['priceLevel'] != null ? map['priceLevel'] as int : null,
    );
  }
}

class Geometry {
  final Location location;
  final Viewport viewport;

  const Geometry({
    required this.location,
    required this.viewport,
  });

  Geometry copyWith({
    Location? location,
    Viewport? viewport,
  }) {
    return Geometry(
      location: location ?? this.location,
      viewport: viewport ?? this.viewport,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location.toMap(),
      'viewport': viewport.toMap(),
    };
  }

  factory Geometry.fromMap(Map<String, dynamic> map) {
    return Geometry(
      location: Location.fromMap(map['location'] as Map<String, dynamic>),
      viewport: Viewport.fromMap(map['viewport'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Geometry.fromJson(String source) =>
      Geometry.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Geometry(location: $location, viewport: $viewport)';

  @override
  bool operator ==(covariant Geometry other) {
    if (identical(this, other)) return true;

    return other.location == location && other.viewport == viewport;
  }

  @override
  int get hashCode => location.hashCode ^ viewport.hashCode;
}

class Location {
  final double lat;
  final double lng;

  const Location({
    required this.lat,
    required this.lng,
  });

  Location copyWith({
    double? lat,
    double? lng,
  }) {
    return Location(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lng': lng,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      lat: double.parse(map['lat'].toString()),
      lng: double.parse(map['lng'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Location(lat: $lat, lng: $lng)';

  @override
  bool operator ==(covariant Location other) {
    if (identical(this, other)) return true;

    return other.lat == lat && other.lng == lng;
  }

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;
}

class Viewport {
  final Location northeast;
  final Location southwest;

  const Viewport({
    required this.northeast,
    required this.southwest,
  });

  Viewport copyWith({
    Location? northeast,
    Location? southwest,
  }) {
    return Viewport(
      northeast: northeast ?? this.northeast,
      southwest: southwest ?? this.southwest,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'northeast': northeast.toMap(),
      'southwest': southwest.toMap(),
    };
  }

  factory Viewport.fromMap(Map<String, dynamic> map) {
    return Viewport(
      northeast: Location.fromMap(map['northeast'] as Map<String, dynamic>),
      southwest: Location.fromMap(map['southwest'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Viewport.fromJson(String source) =>
      Viewport.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Viewport(northeast: $northeast, southwest: $southwest)';

  @override
  bool operator ==(covariant Viewport other) {
    if (identical(this, other)) return true;

    return other.northeast == northeast && other.southwest == southwest;
  }

  @override
  int get hashCode => northeast.hashCode ^ southwest.hashCode;
}

class OpeningHours {
  final bool openNow;

  const OpeningHours({
    required this.openNow,
  });

  OpeningHours copyWith({
    bool? openNow,
  }) {
    return OpeningHours(
      openNow: openNow ?? this.openNow,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'openNow': openNow,
    };
  }

  factory OpeningHours.fromMap(Map<String, dynamic> map) {
    return OpeningHours(
      openNow: map['openNow'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory OpeningHours.fromJson(String source) =>
      OpeningHours.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OpeningHours(openNow: $openNow)';

  @override
  bool operator ==(covariant OpeningHours other) {
    if (identical(this, other)) return true;

    return other.openNow == openNow;
  }

  @override
  int get hashCode => openNow.hashCode;
}

class Photo {
  final int height;
  final List<String> htmlAttributions;
  final String photoReference;
  final int width;

  const Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  Photo copyWith({
    int? height,
    List<String>? htmlAttributions,
    String? photoReference,
    int? width,
  }) {
    return Photo(
      height: height ?? this.height,
      htmlAttributions: htmlAttributions ?? this.htmlAttributions,
      photoReference: photoReference ?? this.photoReference,
      width: width ?? this.width,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'height': height,
      'htmlAttributions': htmlAttributions,
      'photoReference': photoReference,
      'width': width,
    };
  }

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      height: map['height'] as int,
      htmlAttributions: map['htmlAttributions'] != null
          ? List<String>.from((map['htmlAttributions'] as List<String>))
          : [],
      photoReference: map['photo_reference'] != null
          ? map['photo_reference'] as String
          : 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png',
      width: map['width'] != null ? map['width'] as int : 0,
    );
  }

  @override
  String toString() {
    return 'Photo(height: $height, htmlAttributions: $htmlAttributions, photoReference: $photoReference, width: $width)';
  }

  @override
  bool operator ==(covariant Photo other) {
    if (identical(this, other)) return true;

    return other.height == height &&
        listEquals(other.htmlAttributions, htmlAttributions) &&
        other.photoReference == photoReference &&
        other.width == width;
  }

  @override
  int get hashCode {
    return height.hashCode ^ htmlAttributions.hashCode ^ photoReference.hashCode ^ width.hashCode;
  }
}

class PlusCode {
  final String compoundCode;
  final String globalCode;

  const PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });

  PlusCode copyWith({
    String? compoundCode,
    String? globalCode,
  }) {
    return PlusCode(
      compoundCode: compoundCode ?? this.compoundCode,
      globalCode: globalCode ?? this.globalCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'compoundCode': compoundCode,
      'globalCode': globalCode,
    };
  }

  factory PlusCode.fromMap(Map<String, dynamic> map) {
    return PlusCode(
      compoundCode: map['compoundCode'] as String,
      globalCode: map['globalCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlusCode.fromJson(String source) =>
      PlusCode.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PlusCode(compoundCode: $compoundCode, globalCode: $globalCode)';

  @override
  bool operator ==(covariant PlusCode other) {
    if (identical(this, other)) return true;

    return other.compoundCode == compoundCode && other.globalCode == globalCode;
  }

  @override
  int get hashCode => compoundCode.hashCode ^ globalCode.hashCode;
}
