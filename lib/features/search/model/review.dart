// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReviewModel {
  final List<Comment> comments;
  final String placeId;
  const ReviewModel({
    required this.comments,
    required this.placeId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comments': comments.map((x) => x.toMap()).toList(),
      'placeId': placeId,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      comments: map["comments"] == null
          ? []
          : List<Comment>.from(
              map["comments"].map((x) => Comment.fromMap(x)),
            ),
      placeId: map['placeId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ReviewModel copyWith({
    List<Comment>? comments,
    String? placeId,
  }) {
    return ReviewModel(
      comments: comments ?? this.comments,
      placeId: placeId ?? this.placeId,
    );
  }
}

class Comment {
  final String review;
  final DateTime date;
  final int rating;
  final String authorName;
  final String profileImage;

  const Comment({
    required this.review,
    required this.date,
    required this.rating,
    required this.authorName,
    required this.profileImage,
  });

  Comment copyWith({
    String? review,
    DateTime? date,
    int? rating,
    String? authorName,
    String? profileImage,
  }) {
    return Comment(
      review: review ?? this.review,
      date: date ?? this.date,
      rating: rating ?? this.rating,
      authorName: authorName ?? this.authorName,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'review': review,
      'date': date.millisecondsSinceEpoch,
      'rating': rating,
      'authorName': authorName,
      'profileImage': profileImage,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      review: map['review'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      rating: map['rating'] as int,
      authorName: map['authorName'] as String,
      profileImage: map['profileImage'] as String,
    );
  }
}
