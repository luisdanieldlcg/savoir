class Place {
  final List<dynamic> htmlAttributions;
  final String nextPageToken;
  final List<Result> results;
  final String status;

  Place({
    required this.htmlAttributions,
    required this.nextPageToken,
    required this.results,
    required this.status,
  });
}

class Result {
  final BusinessStatus businessStatus;
  final Geometry geometry;
  final String icon;
  final IconBackgroundColor iconBackgroundColor;
  final String iconMaskBaseUri;
  final String name;
  final OpeningHours openingHours;
  final List<Photo> photos;
  final String placeId;
  final PlusCode plusCode;
  final double rating;
  final String reference;
  final Scope scope;
  final List<Type> types;
  final int userRatingsTotal;
  final String vicinity;
  final int? priceLevel;

  Result({
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
}

enum BusinessStatus { OPERATIONAL }

class Geometry {
  final Location location;
  final Viewport viewport;

  Geometry({
    required this.location,
    required this.viewport,
  });
}

class Location {
  final double lat;
  final double lng;

  Location({
    required this.lat,
    required this.lng,
  });
}

class Viewport {
  final Location northeast;
  final Location southwest;

  Viewport({
    required this.northeast,
    required this.southwest,
  });
}

enum IconBackgroundColor { THE_7_B9_EB0 }

class OpeningHours {
  final bool openNow;

  OpeningHours({
    required this.openNow,
  });
}

class Photo {
  final int height;
  final List<String> htmlAttributions;
  final String photoReference;
  final int width;

  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });
}

class PlusCode {
  final String compoundCode;
  final String globalCode;

  PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });
}

enum Scope { GOOGLE }

enum Type {
  BAR,
  ESTABLISHMENT,
  FOOD,
  POINT_OF_INTEREST,
  RESTAURANT,
  STORE,
  TOURIST_ATTRACTION,
  TRAVEL_AGENCY
}
