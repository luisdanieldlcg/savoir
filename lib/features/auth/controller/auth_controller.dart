import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:savoir/common/database_repository.dart';
import 'package:savoir/common/logger.dart';
import 'package:savoir/common/providers.dart';
import 'package:savoir/common/storage_repository.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/features/auth/model/favorite_model.dart';
import 'package:savoir/features/auth/model/user_model.dart';
import 'package:savoir/features/auth/repository/auth_repository.dart';
import 'package:savoir/router.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    repository: ref.read(authRepositoryProvider),
    database: ref.read(databaseRepositoryProvider),
    ref: ref,
  );
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository repository;
  final DatabaseRepository database;
  final Ref ref;
  static final Logger _logger = AppLogger.getLogger(AuthController);

  AuthController({
    required this.repository,
    required this.ref,
    required this.database,
  }) : super(false);

  void createUser({
    required BuildContext context,
    required String email,
    required String password,
    required String username,
    required String phone,
  }) async {
    state = true;
    await Future.delayed(const Duration(seconds: 2));
    await repository.register(
      email: email,
      password: password,
      username: username,
      phone: phone,
      onSuccess: () {
        _logger.i("User registered successfully");
        Navigator.pushAndRemoveUntil(
          context,
          AppRouter.startUp(),
          (route) => false,
        );
      },
      onError: (message) {
        _logger.e("Error registering user: $message");
        errorAlert(
          context: context,
          title: 'Registration failed',
          text: message,
        );
      },
    );
    state = false;
  }

  void logInUser({
    required BuildContext context,
    required String email,
    required String password,
    required WidgetRef ref,
  }) async {
    final nav = Navigator.of(context);
    state = true;

    await Future.delayed(const Duration(seconds: 2));
    await repository.logIn(
      email: email,
      password: password,
      onSuccess: (uid) async {
        _logger.i("User logged in successfully");
        final database = ref.watch(databaseRepositoryProvider);
        final user = await database.readUser(uid);
        ref.watch(userProvider.notifier).state = user;

        if (user == null) {
          _logger.w("User authenticated but not found in database");
          _logger.w("This might be a deleted user. Logging out");
          await repository.logOut();
        } else {
          _logger.i("User authenticated. Redirecting to home");
          nav.pushAndRemoveUntil(
            AppRouter.startUp(),
            (route) => false,
          );
        }
      },
      onError: (message) {
        _logger.e("Error registering user: $message");
        errorAlert(
          context: context,
          title: 'Login failed',
          text: message,
        );
      },
    );
    state = false;
  }

  void resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    state = true;
    await Future.delayed(const Duration(seconds: 2));
    await repository.resetPassword(
      email: email,
      onSuccess: () {
        _logger.i("Password reset email sent");
        successAlert(
          context: context,
          title: 'Password reset email sent',
          text: 'Please check your email for further instructions',
        );
      },
      onError: (message) {
        _logger.e("Error sending password reset email: $message");
        errorAlert(
          context: context,
          title: 'Password reset failed',
          text: message,
        );
      },
    );
    state = false;
  }

  void completeProfile({
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required String genre,
    required File? image,
    required Function(UserModel) onSuccess,
    required VoidCallback onError,
    required bool firstTime,
  }) async {
    state = true;
    await Future.delayed(const Duration(seconds: 2));
    final user = ref.watch(userProvider);
    if (user == null) {
      onError();
      state = false;
      return;
    }
    try {
      String? avatarUrl;
      if (image != null) {
        avatarUrl = await ref.watch(storageRepositoryProvider).storeFile(
              file: image,
              id: user.uid,
              path: 'users/profile',
            );
      }

      final UserModel updatedUser = user.copyWith(
        firstName: firstName,
        lastName: lastName,
        birthDate: birthDate,
        genre: genre,
        profilePicture: avatarUrl ?? user.profilePicture,
        profileComplete: true,
      );
      _logger.i("Updating user profile: $updatedUser");
      await ref.watch(databaseRepositoryProvider).updateUser(updatedUser);

      if (firstTime) {
        final FavoriteModel defaultFavorite = FavoriteModel(
          userId: user.uid,
          restaurants: [],
        );
        await ref.watch(databaseRepositoryProvider).updateFavorite(defaultFavorite);
        ref.read(favoriteProvider.notifier).state = defaultFavorite;
      }

      _logger.i("User profile updated successfully");

      state = false;
      onSuccess(updatedUser);
    } catch (e) {
      _logger.e("Error updating user profile: $e");
      state = false;
      onError();
    }
  }
}
