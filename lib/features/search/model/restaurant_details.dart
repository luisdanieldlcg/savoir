import 'package:savoir/common/constants.dart';

class RestaurantDetails {
  final EditorialSummary? editorialSummary;
  final String internationalPhoneNumber;
  final String? website;
  final OpeningHours? openingHours;
  final List<Review> reviews;
  const RestaurantDetails({
    required this.editorialSummary,
    required this.internationalPhoneNumber,
    required this.website,
    required this.openingHours,
    required this.reviews,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'editorial_summary': editorialSummary?.toMap(),
      'international_phone_number': editorialSummary?.toMap(),
      'website': website,
      'opening_hours': openingHours?.toMap(),
      'reviews': reviews.map((e) => e.toMap()).toList(),
    };
  }

  factory RestaurantDetails.fromMap(Map<String, dynamic> map) {
    return RestaurantDetails(
      editorialSummary: map['editorial_summary'] != null
          ? EditorialSummary.fromMap(map['editorial_summary'] as Map<String, dynamic>)
          : null,
      internationalPhoneNumber: map['international_phone_number'] ?? 'Número no disponible',
      website: map['website'] ?? 'Sitio web no disponible',
      openingHours: map['opening_hours'] != null
          ? OpeningHours.fromMap(map['opening_hours'] as Map<String, dynamic>)
          : null,
      reviews: map['reviews'] == null || map['reviews'].isEmpty
          ? <Review>[]
          : List<Review>.from((map['reviews'] as List<dynamic>)
              .map((e) => Review.fromMap(e as Map<String, dynamic>))),
    );
  }
}

class EditorialSummary {
  final String language;
  final String overview;

  const EditorialSummary({
    required this.language,
    required this.overview,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'language': language,
      'overview': overview,
    };
  }

  factory EditorialSummary.fromMap(Map<String, dynamic> map) {
    return EditorialSummary(
      language: map['language'] as String,
      overview: map['overview'] as String,
    );
  }
}

class OpeningHours {
  final bool openNow;
  final List<String> weekdayText;

  const OpeningHours({
    required this.openNow,
    required this.weekdayText,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'open_now': openNow,
      'weekday_text': weekdayText,
    };
  }

  factory OpeningHours.fromMap(Map<String, dynamic> map) {
    return OpeningHours(
      openNow: map['open_now'] as bool,
      weekdayText: map['weekday_text'] == null
          ? <String>[]
          : List<String>.from(map['weekday_text'] as List<dynamic>),
    );
  }
}

class Review {
  final String authorName;
  final String profilePhotoUrl;
  final double rating;
  final String relativeTimeDescription;
  final String text;
  final int time;

  const Review({
    required this.authorName,
    required this.profilePhotoUrl,
    required this.rating,
    required this.relativeTimeDescription,
    required this.text,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'author_name': authorName,
      'profile_photo_url': profilePhotoUrl,
      'rating': rating,
      'relative_time_description': relativeTimeDescription,
      'text': text,
      'time': time,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      authorName: map['author_name'] as String,
      profilePhotoUrl: map['profile_photo_url'] == null
          ? kDefaultAvatarImage
          : map['profile_photo_url'] as String,
      rating: double.parse(map['rating'].toString()),
      relativeTimeDescription: map['relative_time_description'] as String,
      text: map['text'] as String,
      time: map['time'] as int,
    );
  }
}
