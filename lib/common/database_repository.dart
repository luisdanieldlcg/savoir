import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/providers.dart';
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

  DocumentReference<UserModel> user(String uid) {
    return _database.collection('users').doc(uid).withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromMap(snapshot.data()!),
          toFirestore: (user, _) => user.toMap(),
        );
  }

  Future<UserModel?> readUser(String uid) {
    return user(uid).get().then((snapshot) => snapshot.data());
  }

  Future<void> updateUser(UserModel model) {
    return user(model.uid).set(model);
  }
}
