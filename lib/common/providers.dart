import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:savoir/features/auth/model/favorite_model.dart';
import 'package:savoir/features/auth/model/user_model.dart';

final authProvider = Provider((ref) => FirebaseAuth.instance);
final databaseProvider = Provider((ref) => FirebaseFirestore.instance);
final storageProvider = Provider((ref) => FirebaseStorage.instance);
final userProvider = StateProvider<UserModel?>((ref) => null);
final favoriteProvider = StateProvider<FavoriteModel?>((ref) => null);
final locationProvider = Provider((ref) => Location());
