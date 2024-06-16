import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:savoir/common/database_repository.dart';
import 'package:savoir/common/logger.dart';
import 'package:savoir/common/providers.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/features/auth/model/user_model.dart';
import 'package:savoir/features/auth/repository/auth_repository.dart';
import 'package:savoir/features/home.dart';
import 'package:savoir/features/onboarding/onboarding.dart';

final startUpProvider = FutureProvider.family<UserModel?, String>((ref, uid) async {
  final database = ref.watch(databaseRepositoryProvider);
  final user = await database.readUser(uid);
  ref.watch(userProvider.notifier).state = user;
  return user;
});

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

        final init = ref.watch(startUpProvider(user.uid));
        return init.when(
          data: (user) {
            if (user == null) {
              _logger.w("The user was authenticated but not found in the database.");
              _logger.w("This might be a deleted user. Redirecting to onboarding screen.");
              return const Onboarding();
            }
            _logger.i("The user is authenticated. Redirecting to home screen.");
            _logger.i("User: ${user.toMap()}");
            return const Home();
          },
          loading: () {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          error: (error, _) => ErrorScreen(error: error.toString()),
        );
      },
      loading: () {
        _logger.i("Checking the authentication state");
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      error: (error, _) => ErrorScreen(error: error.toString()),
    );
  }
}