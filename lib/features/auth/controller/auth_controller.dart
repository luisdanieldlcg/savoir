import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:savoir/common/logger.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/features/auth/repository/auth_repository.dart';
import 'package:savoir/router.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(repository: ref.read(authRepositoryProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _repository;
  static final Logger _logger = AppLogger.getLogger(AuthController);

  AuthController({
    required AuthRepository repository,
  })  : _repository = repository,
        super(false);

  void createUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = true;
    await Future.delayed(const Duration(seconds: 2));
    await _repository.register(
      email: email,
      password: password,
      onSuccess: () {
        _logger.i("User registered successfully");
        Navigator.pushNamedAndRemoveUntil(context, AppRouter.home, (route) => false);
        // successAlert(
        //   context: context,
        //   title: 'R
        //gistration successful',
        //   text: 'You have successfully registered',
        //   onConfirm: () {

        //   },
        // );
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
  }) async {
    state = true;
    await Future.delayed(const Duration(seconds: 2));
    await _repository.logIn(
      email: email,
      password: password,
      onSuccess: () {
        _logger.i("User logged in successfully");
        successAlert(
          context: context,
          title: 'Login successful',
          text: 'You have successfully logged in',
        );
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
    await _repository.resetPassword(
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
}
