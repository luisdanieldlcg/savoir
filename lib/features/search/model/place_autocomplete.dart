import 'dart:convert';

import 'package:flutter/foundation.dart';

class PlaceAutoComplete {
  final List<Prediction> predictions;
  final String status;

  PlaceAutoComplete({
    required this.predictions,
    required this.status,
  });

  PlaceAutoComplete copyWith({
    List<Prediction>? predictions,
    String? status,
  }) {
    return PlaceAutoComplete(
      predictions: predictions ?? this.predictions,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'predictions': predictions.map((x) => x.toMap()).toList(),
      'status': status,
    };
  }

  factory PlaceAutoComplete.fromMap(Map<String, dynamic> map) {
    return PlaceAutoComplete(
      predictions: List<Prediction>.from(
        (map['predictions'] as List<dynamic>).map<Prediction>(
          (x) => Prediction.fromMap(x as Map<String, dynamic>),
        ),
      ),
      status: map['status'] as String,
    );
  }

  @override
  String toString() => 'PlaceAutoComplete(predictions: $predictions, status: $status)';

  @override
  bool operator ==(covariant PlaceAutoComplete other) {
    if (identical(this, other)) return true;

    return listEquals(other.predictions, predictions) && other.status == status;
  }

  @override
  int get hashCode => predictions.hashCode ^ status.hashCode;
}

class Prediction {
  final String description;
  final List<MatchedSubstring> matchedSubstrings;
  final String placeId;
  final String reference;
  final StructuredFormatting structuredFormatting;
  final List<Term> terms;
  final List<String> types;

  Prediction({
    required this.description,
    required this.matchedSubstrings,
    required this.placeId,
    required this.reference,
    required this.structuredFormatting,
    required this.terms,
    required this.types,
  });

  Prediction copyWith({
    String? description,
    List<MatchedSubstring>? matchedSubstrings,
    String? placeId,
    String? reference,
    StructuredFormatting? structuredFormatting,
    List<Term>? terms,
    List<String>? types,
  }) {
    return Prediction(
      description: description ?? this.description,
      matchedSubstrings: matchedSubstrings ?? this.matchedSubstrings,
      placeId: placeId ?? this.placeId,
      reference: reference ?? this.reference,
      structuredFormatting: structuredFormatting ?? this.structuredFormatting,
      terms: terms ?? this.terms,
      types: types ?? this.types,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'matchedSubstrings': matchedSubstrings.map((x) => x.toMap()).toList(),
      'placeId': placeId,
      'reference': reference,
      'structuredFormatting': structuredFormatting.toMap(),
      'terms': terms.map((x) => x.toMap()).toList(),
      'types': types,
    };
  }

  factory Prediction.fromMap(Map<String, dynamic> map) {
    return Prediction(
      description: map['description'] as String,
      matchedSubstrings: List<MatchedSubstring>.from(
        (map["matchedSubstrings"] == null)
            ? []
            : List<MatchedSubstring>.from(
                (map["matchedSubstrings"] as List<dynamic>).map(
                  (x) => MatchedSubstring.fromMap(x as Map<String, dynamic>),
                ),
              ),
      ),
      placeId: map['placeId'] == null ? "" : map['placeId'] as String,
      reference: map['reference'] == null ? "" : map['reference'] as String,
      structuredFormatting: StructuredFormatting.fromMap(map['structuredFormatting'] == null
          ? {}
          : map['structuredFormatting'] as Map<String, dynamic>),
      terms: List<Term>.from(
        (map["terms"] == null
            ? []
            : List<Term>.from((map["terms"] as List<dynamic>)
                .map((x) => Term.fromMap(x as Map<String, dynamic>)))),
      ),
      types: List<String>.from(
        (map['types']),
      ),
    );
  }

  @override
  String toString() {
    return 'Prediction(description: $description, matchedSubstrings: $matchedSubstrings, placeId: $placeId, reference: $reference, structuredFormatting: $structuredFormatting, terms: $terms, types: $types)';
  }

  @override
  bool operator ==(covariant Prediction other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        listEquals(other.matchedSubstrings, matchedSubstrings) &&
        other.placeId == placeId &&
        other.reference == reference &&
        other.structuredFormatting == structuredFormatting &&
        listEquals(other.terms, terms) &&
        listEquals(other.types, types);
  }

  @override
  int get hashCode {
    return description.hashCode ^
        matchedSubstrings.hashCode ^
        placeId.hashCode ^
        reference.hashCode ^
        structuredFormatting.hashCode ^
        terms.hashCode ^
        types.hashCode;
  }
}

class MatchedSubstring {
  final int length;
  final int offset;

  MatchedSubstring({
    required this.length,
    required this.offset,
  });

  MatchedSubstring copyWith({
    int? length,
    int? offset,
  }) {
    return MatchedSubstring(
      length: length ?? this.length,
      offset: offset ?? this.offset,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'length': length,
      'offset': offset,
    };
  }

  factory MatchedSubstring.fromMap(Map<String, dynamic> map) {
    return MatchedSubstring(
      length: map['length'] as int,
      offset: map['offset'] as int,
    );
  }

  @override
  String toString() => 'MatchedSubstring(length: $length, offset: $offset)';

  @override
  bool operator ==(covariant MatchedSubstring other) {
    if (identical(this, other)) return true;

    return other.length == length && other.offset == offset;
  }

  @override
  int get hashCode => length.hashCode ^ offset.hashCode;
}

class StructuredFormatting {
  final String mainText;
  final List<MatchedSubstring> mainTextMatchedSubstrings;
  final String secondaryText;

  StructuredFormatting({
    required this.mainText,
    required this.mainTextMatchedSubstrings,
    required this.secondaryText,
  });

  StructuredFormatting copyWith({
    String? mainText,
    List<MatchedSubstring>? mainTextMatchedSubstrings,
    String? secondaryText,
  }) {
    return StructuredFormatting(
      mainText: mainText ?? this.mainText,
      mainTextMatchedSubstrings: mainTextMatchedSubstrings ?? this.mainTextMatchedSubstrings,
      secondaryText: secondaryText ?? this.secondaryText,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mainText': mainText,
      'mainTextMatchedSubstrings': mainTextMatchedSubstrings.map((x) => x.toMap()).toList(),
      'secondaryText': secondaryText,
    };
  }

  factory StructuredFormatting.fromMap(Map<String, dynamic> map) {
    return StructuredFormatting(
      mainText: map['mainText'] == null ? "" : map['mainText'] as String,
      mainTextMatchedSubstrings: (map["mainTextMatchedSubstrings"] == null)
          ? []
          : List<MatchedSubstring>.from(
              (map["mainTextMatchedSubstrings"] as List<dynamic>).map(
                (x) => MatchedSubstring.fromMap(x as Map<String, dynamic>),
              ),
            ),
      secondaryText: map['secondaryText'] == null ? "" : map['secondaryText'] as String,
    );
  }

  @override
  String toString() =>
      'StructuredFormatting(mainText: $mainText, mainTextMatchedSubstrings: $mainTextMatchedSubstrings, secondaryText: $secondaryText)';

  @override
  bool operator ==(covariant StructuredFormatting other) {
    if (identical(this, other)) return true;

    return other.mainText == mainText &&
        listEquals(other.mainTextMatchedSubstrings, mainTextMatchedSubstrings) &&
        other.secondaryText == secondaryText;
  }

  @override
  int get hashCode =>
      mainText.hashCode ^ mainTextMatchedSubstrings.hashCode ^ secondaryText.hashCode;
}

class Term {
  final int offset;
  final String value;

  Term({
    required this.offset,
    required this.value,
  });

  Term copyWith({
    int? offset,
    String? value,
  }) {
    return Term(
      offset: offset ?? this.offset,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'offset': offset,
      'value': value,
    };
  }

  factory Term.fromMap(Map<String, dynamic> map) {
    return Term(
      offset: map['offset'] as int,
      value: map['value'] as String,
    );
  }

  @override
  String toString() => 'Term(offset: $offset, value: $value)';

  @override
  bool operator ==(covariant Term other) {
    if (identical(this, other)) return true;

    return other.offset == offset && other.value == value;
  }

  @override
  int get hashCode => offset.hashCode ^ value.hashCode;
}
