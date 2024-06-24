import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/providers.dart';
import 'package:savoir/features/auth/model/favorite_model.dart';
import 'package:savoir/features/auth/model/user_model.dart';

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
