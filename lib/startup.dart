import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:savoir/common/logger.dart';
import 'package:savoir/features/auth/repository/auth_repository.dart';
import 'package:savoir/features/home.dart';
import 'package:savoir/features/onboarding/onboarding.dart';

class StartUp extends ConsumerWidget {
  static final Logger _logger = AppLogger.getLogger(StartUp);
  const StartUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authChanges = ref.watch(authStateProvider);
    return authChanges.when(
      data: (user) {
        if (user == null) {
          _logger.i("The user is not authenticated. Redirecting to onboarding screen.");
          return const Onboarding();
        }
        _logger.i("The user is authenticated. Redirecting to home screen.");
        return const Home();
      },
      loading: () {
        _logger.i("Checking the authentication state");
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      error: (error, stackTrace) {
        return Scaffold(
          body: Center(
            child: Text('Error: $error'),
          ),
        );
      },
    );
  }
}
