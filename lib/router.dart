import 'package:flutter/material.dart';
import 'package:savoir/features/auth/view/login_view.dart';
import 'package:savoir/features/auth/view/password_reset_view.dart';
import 'package:savoir/features/auth/view/signup_view.dart';

class AppRouter {
  static const login = "/login";
  static const signup = "/signup";
  static const passwordReset = "/password-reset";

  static Route<Widget> generateRoutes(RouteSettings settings) {
    final name = settings.name;
    switch (name) {
      case login:
        return _createRoute(const LoginView());
      case signup:
        return _createRoute(const SignupView());
      case passwordReset:
        return _createRoute(const PasswordResetView());
      default:
        return _createRoute(UnknownRouteScreen(targetRoute: name));
    }
  }

  static Route<Widget> _createRoute(Widget child) {
    return MaterialPageRoute<Widget>(
      builder: (_) => child,
    );
  }
}

class UnknownRouteScreen extends StatelessWidget {
  final String? targetRoute;
  const UnknownRouteScreen({
    super.key,
    required this.targetRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "The route '$targetRoute' was not found.",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
