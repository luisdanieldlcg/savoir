import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:savoir/common/logger.dart';
import 'package:savoir/common/providers.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(auth: ref.read(authProvider));
});

class AuthRepository {
  final FirebaseAuth _auth;

  static final Logger _logger = AppLogger.getLogger(AuthRepository);

  const AuthRepository({
    required FirebaseAuth auth,
  }) : _auth = auth;

  Future<void> register({
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    try {
      _logger.i("Registering user with email: $email");
      final _ = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      onSuccess();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          onError("The email is already in use");
          break;
        case 'weak-password':
          onError("The password is too weak");
          break;
        case 'invalid-email':
          onError("The email does not have a valid format");
          break;
        default:
          onError("Something went wrong. Please try again or contact support");
          break;
      }
      _logger.e("Error registering user: ${e.message}");
    } catch (e) {
      onError("Something went wrong. Please try again or contact support");
      _logger.e("Error registering user: $e");
    }
  }

  Future<void> logIn({
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    try {
      _logger.i("Registering user with email: $email");
      final _ = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      onSuccess();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
          onError("Either the email or password is incorrect");
          break;
        case 'invalid-email':
          onError("The email does not have a valid format");
          break;
        case 'user-disabled':
          onError("The user account has been disabled. Contact support");
          break;
        default:
          onError("Something went wrong. Please try again or contact support");
          break;
      }
      _logger.e("Error registering user: ${e.message}. Code: ${e.code}");
    } catch (e) {
      onError("Something went wrong. Please try again or contact support");
      _logger.e("Error registering user: $e");
    }
  }
}
