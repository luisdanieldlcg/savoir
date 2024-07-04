// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Place {
  final List<dynamic> htmlAttributions;
  final List<Restaurant> restaurants;

  const Place({
    required this.htmlAttributions,
    required this.restaurants,
  });

  Place copyWith({
    List<dynamic>? htmlAttributions,
    List<Restaurant>? places,
    String? status,
  }) {
    return Place(
      htmlAttributions: htmlAttributions ?? this.htmlAttributions,
      restaurants: places ?? this.restaurants,
    );
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      htmlAttributions: map['htmlAttributions'] != null
          ? List<dynamic>.from((map['htmlAttributions'] as List<dynamic>))
          : [],
      restaurants: map["places"] != null
          ? List<Restaurant>.from(
              (map['places'] as List<dynamic>).map<Restaurant>(
                (x) => Restaurant.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }
}

class Restaurant {
  final String businessStatus;
  final Location location;
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
  final List<String> types;
  final int userRatingsTotal;
  final String formattedAddress;
  final String priceLevel;
  final bool servesVegetarianFood;
  final bool delivery;
  final bool servesCoffee;
  final bool servesWine;
  final bool servesBeer;
  final bool reservable;
  const Restaurant({
    required this.businessStatus,
    required this.location,
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
    required this.types,
    required this.userRatingsTotal,
    required this.priceLevel,
    required this.formattedAddress,
    required this.servesVegetarianFood,
    required this.delivery,
    required this.servesCoffee,
    required this.servesWine,
    required this.servesBeer,
    required this.reservable,
  });

  bool get isOpen => openingHours?.openNow ?? false;

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      businessStatus: map['businessStatus'] != null ? map['businessStatus'] as String : '',
      location: Location.fromMap(map['location'] as Map<String, dynamic>),
      icon: map['icon'] != null ? map['icon'] as String : '',
      iconBackgroundColor:
          map['iconBackgroundColor'] != null ? map['iconBackgroundColor'] as String : '',
      iconMaskBaseUri: map['iconMaskBaseUri'] != null ? map['iconMaskBaseUri'] as String : '',
      name: map['displayName']["text"] as String,
      openingHours: map['regularOpeningHours'] != null
          ? OpeningHours.fromMap(map['regularOpeningHours'] as Map<String, dynamic>)
          : null,
      photos: map["photos"] == null
          ? []
          : List<Photo>.from((map['photos'] as List<dynamic>)
              .map<Photo>((x) => Photo.fromMap(x as Map<String, dynamic>))),
      placeId: map['id'] != null ? map['id'] as String : '',
      plusCode: map['plusCode'] != null
          ? PlusCode.fromMap(map['plusCode'] as Map<String, dynamic>)
          : PlusCode(compoundCode: '', globalCode: ''),
      rating: map['rating'] != null ? double.parse(map['rating'].toString()) : 0.0,
      reference: map['reference'] != null ? map['reference'] as String : '',
      types: map["types"] != null
          ? List<String>.from((map['types'] as List<dynamic>).map<String>((x) => x as String))
          : [],
      userRatingsTotal: map['userRatingsTotal'] != null ? map['userRatingsTotal'] as int : 0,
      priceLevel: map['priceLevel'] != null ? map['priceLevel'].toString() : '',
      formattedAddress: map['formattedAddress'] != null ? map['formattedAddress'] as String : '',
      servesVegetarianFood:
          map['servesVegetarianFood'] != null ? map['servesVegetarianFood'] as bool : false,
      delivery: map['delivery'] != null ? map['delivery'] as bool : false,
      // servesCoffee: map['servesCoffee'] != null ? map['servesCoffee'] as bool : false,
      servesCoffee: map['servesCoffee'] == null ? false : map['servesCoffee'] as bool,
      servesWine: map["servesWine"] == null ? false : map["servesWine"] as bool,
      servesBeer: map["servesBeer"] == null ? false : map["servesBeer"] as bool,
      reservable: map["reservable"] == null ? false : map["reservable"] as bool,
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
      'latitude': lat,
      'longitude': lng,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      lat: double.parse(map['latitude'].toString()),
      lng: double.parse(map['longitude'].toString()),
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

  factory OpeningHours.fromMap(Map<String, dynamic> map) {
    return OpeningHours(
      openNow: map['openNow'] as bool,
    );
  }

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
  final int heightPx;
  final String name;
  final int widthPx;

  const Photo({
    required this.heightPx,
    required this.name,
    required this.widthPx,
  });

  Photo copyWith({
    int? height,
    List<String>? htmlAttributions,
    String? photoReference,
    int? width,
  }) {
    return Photo(
      heightPx: height ?? this.heightPx,
      name: photoReference ?? this.name,
      widthPx: width ?? this.widthPx,
    );
  }

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      heightPx: map['heightPx'] != null ? map['heightPx'] as int : 0,
      widthPx: map['widthPx'] != null ? map['widthPx'] as int : 0,
      name: map['name'] != null ? map['name'] as String : '',
    );
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
