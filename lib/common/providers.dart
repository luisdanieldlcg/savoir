import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/features/auth/model/user_model.dart';

final authProvider = Provider((ref) => FirebaseAuth.instance);
final databaseProvider = Provider((ref) => FirebaseFirestore.instance);
final userProvider = StateProvider<UserModel?>((ref) => null);
