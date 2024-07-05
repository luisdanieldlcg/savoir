import 'package:flutter/material.dart';
import 'package:savoir/features/auth/model/favorite_model.dart';
import 'package:savoir/features/auth/view/login_view.dart';
import 'package:savoir/features/auth/view/password_reset_view.dart';
import 'package:savoir/features/auth/view/signup_view.dart';
import 'package:savoir/features/auth/view/welcome_view.dart';
import 'package:savoir/features/search/view/reservation/table_reservation_view.dart';
import 'package:savoir/features/home.dart';
import 'package:savoir/features/profile/view/account_statistics_view.dart';
import 'package:savoir/features/profile/view/personal_details_view.dart';
import 'package:savoir/features/profile/view/settings_view.dart';
import 'package:savoir/features/search/model/place.dart';
import 'package:savoir/features/search/view/details/restaurant_details_view.dart';
import 'package:savoir/features/search/view/map/restaurant_map_view.dart';
import 'package:savoir/features/search/view/map/restaurant_search_view.dart';
import 'package:savoir/startup.dart';

class AppRouter {
  static const login = "/login";
  static const signup = "/signup";
  static const passwordReset = "/password-reset";
  static const welcome = "/welcome";
  static const home = "/home";
  static const personalDetails = "/personal-details";
  static const accountStatistics = "/account-statistics";
  static const appSettings = "/app-settings";
  static const restaurantsMap = "/restaurants-map";
  static const restaurantSearch = "/restaurant-search";
  static const restaurantDetails = "/restaurant-details";
  static const tableReservation = "/table-reservation";

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
        return _createRoute(const PersonalDetailsView(firstTime: false));
      case accountStatistics:
        return _createRoute(const AccountStatisticsView());
      case appSettings:
        return _createRoute(const SettingsView());
      case restaurantsMap:
        return _createRoute(const RestaurantMapView());
      case restaurantSearch:
        return _createRoute(const RestaurantSearchView());
      case restaurantDetails:
        final args = settings.arguments;
        if (args is RestaurantSummary) {
          return _createRoute(RestaurantDetailsView(summary: args));
        }
        return _createRoute(UnknownRouteScreen(targetRoute: name));
      case tableReservation:
        final args = settings.arguments;
        if (args is RestaurantSummary) {
          return _createRoute(TableReservationView(summary: args));
        }
        return _createRoute(UnknownRouteScreen(targetRoute: name));
      default:
        return _createRoute(UnknownRouteScreen(targetRoute: name));
    }
  }

  static Route<Widget> _createRoute(Widget child) {
    return MaterialPageRoute<Widget>(
      builder: (_) => child,
    );
  }

  static Route<Widget> startUp() {
    return MaterialPageRoute<Widget>(
      builder: (_) => const StartUp(),
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
