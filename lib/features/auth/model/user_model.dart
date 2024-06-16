// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String uid;
  final String email;
  final String username;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String profilePicture;
  final DateTime birthDate;
  final String genre;
  final bool profileComplete;

  const UserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
    required this.birthDate,
    required this.genre,
    required this.profileComplete,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? profilePicture,
    DateTime? birthDate,
    String? genre,
    bool? profileComplete,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePicture: profilePicture ?? this.profilePicture,
      birthDate: birthDate ?? this.birthDate,
      genre: genre ?? this.genre,
      profileComplete: profileComplete ?? this.profileComplete,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'profilePicture': profilePicture,
      'birthDate': birthDate.millisecondsSinceEpoch,
      'genre': genre,
      'profileComplete': profileComplete,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      phoneNumber: map['phoneNumber'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      profilePicture: map['profilePicture'] as String,
      birthDate: DateTime.fromMillisecondsSinceEpoch(map['birthDate'] as int),
      genre: map['genre'] as String,
      profileComplete: map['profileComplete'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, username: $username, phoneNumber: $phoneNumber, firstName: $firstName, lastName: $lastName, profilePicture: $profilePicture, birthDate: $birthDate, genre: $genre, profileComplete: $profileComplete)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.username == username &&
        other.phoneNumber == phoneNumber &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.profilePicture == profilePicture &&
        other.birthDate == birthDate &&
        other.genre == genre &&
        other.profileComplete == profileComplete;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        username.hashCode ^
        phoneNumber.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        profilePicture.hashCode ^
        birthDate.hashCode ^
        genre.hashCode ^
        profileComplete.hashCode;
  }
}
