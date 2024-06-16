import 'package:flutter/material.dart';
import 'package:savoir/features/auth/view/login_view.dart';
import 'package:savoir/features/auth/view/password_reset_view.dart';
import 'package:savoir/features/auth/view/signup_view.dart';
import 'package:savoir/features/auth/view/welcome_view.dart';
import 'package:savoir/features/home.dart';
import 'package:savoir/features/profile/view/personal_details_page.dart';

class AppRouter {
  static const login = "/login";
  static const signup = "/signup";
  static const passwordReset = "/password-reset";
  static const welcome = "/welcome";
  static const home = "/home";
  static const personalDetails = "/personal-details";

  static Route<Widget> generateRoutes(RouteSettings settings) {
    final name = settings.name;
    switch (name) {
      case login:
        return _createRoute(const LoginView());
      case signup:
        return _createRoute(const SignupView());
      case passwordReset:
        return _createRoute(const PasswordResetView());
      case welcome:
        return _createRoute(const WelcomeView());
      case home:
        return _createRoute(const Home());
      case personalDetails:
        return _createRoute(const PersonalDetailsView());
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
