import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/providers.dart';
import 'package:savoir/features/auth/model/favorite_model.dart';
import 'package:savoir/features/auth/model/user_model.dart';
import 'package:savoir/features/search/controller/restaurant_reservation_controller.dart';
import 'package:savoir/features/search/model/reservation.dart';
import 'package:savoir/features/search/model/review.dart';

final databaseRepositoryProvider = Provider((ref) {
  return DatabaseRepository(
    database: ref.read(databaseProvider),
  );
});

class DatabaseRepository {
  final FirebaseFirestore _database;

  const DatabaseRepository({
    required FirebaseFirestore database,
  }) : _database = database;

  Future<void> addReservation(ReservationForm reservation, String userId) {
    return reservations().doc(userId).get().then((snapshot) {
      final reservationModel = snapshot.data();
      if (reservationModel == null) {
        return reservations().doc(userId).set(
              ReservationModel(userId: userId, reservations: [reservation]),
            );
      }
      return reservations().doc(userId).set(
            reservationModel.copyWith(
              reservations: [...reservationModel.reservations, reservation],
            ),
          );
    });
  }

  Future<List<ReservationForm>> readReservations(String userId) {
    return reservations().doc(userId).get().then((snapshot) {
      if (snapshot.data() == null) {
        return <ReservationForm>[];
      }
      return snapshot.data()!.reservations;
    });
  }

  Future<UserModel?> readUser(String uid) {
    return user(uid).get().then((snapshot) => snapshot.data());
  }

  Future<void> updateUser(UserModel model) {
    return user(model.uid).set(model);
  }

  Future<void> updateFavorite(FavoriteModel model) {
    return favorite(model.userId).set(model);
  }

  Future<FavoriteModel?> readFavorite(String userId) {
    return favorite(userId).get().then((snapshot) => snapshot.data());
  }

  Future<int> userCommentsCount(String authorName) {
    return reviews().get().then((snapshot) {
      return snapshot.docs.fold<int>(
        0,
        (previousValue, element) {
          final review = element.data();
          return previousValue +
              review.comments.where((comment) => comment.authorName == authorName).length;
        },
      );
    });
  }

  Future<List<Comment>> readComments(String placeId) {
    return reviews().doc(placeId).get().then((snapshot) {
      if (snapshot.data() == null) {
        return <Comment>[];
      }
      return snapshot.data()!.comments;
    });
  }

  Future<void> addComment({
    required String placeId,
    required Comment comment,
  }) async {
    final review = await reviews().doc(placeId).get();
    final reviewModel = review.data();
    if (reviewModel == null) {
      return reviews().doc(placeId).set(ReviewModel(comments: [comment], placeId: placeId));
    }
    return reviews().doc(placeId).set(
          reviewModel.copyWith(
            comments: [...reviewModel.comments, comment],
          ),
        );
  }

  CollectionReference<ReviewModel> reviews() {
    return _database.collection('reviews').withConverter<ReviewModel>(
          fromFirestore: (snapshot, _) => ReviewModel.fromMap(snapshot.data()!),
          toFirestore: (review, _) => review.toMap(),
        );
  }

  CollectionReference<ReservationModel> reservations() {
    return _database.collection('reservations').withConverter<ReservationModel>(
          fromFirestore: (snapshot, _) => ReservationModel.fromMap(snapshot.data()!),
          toFirestore: (reservation, _) => reservation.toMap(),
        );
  }

  DocumentReference<UserModel> user(String uid) {
    return _database.collection('users').doc(uid).withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromMap(snapshot.data()!),
          toFirestore: (user, _) => user.toMap(),
        );
  }

  DocumentReference<FavoriteModel> favorite(String userId) {
    return _database.collection('favorites').doc(userId).withConverter<FavoriteModel>(
          fromFirestore: (snapshot, _) => FavoriteModel.fromMap(snapshot.data()!),
          toFirestore: (favorite, _) => favorite.toMap(),
        );
  }
}
