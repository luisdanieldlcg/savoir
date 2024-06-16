import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:savoir/common/logger.dart';
import 'package:savoir/common/providers.dart';

final storageRepositoryProvider = Provider((ref) {
  return StorageRepository(
    firebaseStorage: ref.read(storageProvider),
  );
});

class StorageRepository {
  static final Logger _logger = AppLogger.getLogger(StorageRepository);
  final FirebaseStorage _firebaseStorage;

  const StorageRepository({
    required FirebaseStorage firebaseStorage,
  }) : _firebaseStorage = firebaseStorage;

  Future<String?> storeFile({
    required String path,
    required String id,
    required File? file,
  }) async {
    try {
      _logger.i("Storing file at path: $path with id: $id");
      final ref = _firebaseStorage.ref().child(path).child(id);
      final uploadTask = ref.putFile(file!);
      final snapshot = await uploadTask;
      final link = await snapshot.ref.getDownloadURL();
      _logger.i("File stored successfully: $link");
      return link;
    } catch (e) {
      _logger.e("Error storing file: $e");
      return null;
    }
  }
}
