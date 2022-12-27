import 'package:flutter/material.dart';

import '../Start_screen/start_view.dart';
import '../calender_screen/calender_view.dart';
import '../home_screen/home_view.dart';
import '../profile_screen/profile_view.dart';
import '../splash_screen/splash_view.dart';
import 'app_strings.dart';

class Routes {
  static const String splashRoute = '/';
  static const String startPageRoute = '/getStart';
  static const String homeRoute = '/home';
  static const String profileRoute = '/profile';
  static const String calenderRoute = '/calender';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.startPageRoute:
        return MaterialPageRoute(builder: (_) => const StartView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.calenderRoute:
        return MaterialPageRoute(builder: (_) => const CalenderView());
      case Routes.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileView());
      default:
        return unDefinedPage();
    }
  }

  static Route<dynamic> unDefinedPage() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
                body: Center(
              child: Text(
                AppStrings.notFound,
              ),
            )));
  }
}
