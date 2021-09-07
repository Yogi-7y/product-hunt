import 'package:flutter/material.dart';
import 'package:product_hunt/screens/home/home_screen.dart';
import 'package:product_hunt/screens/splash/splash_screen.dart';

class RouteGenerator {
  RouteGenerator._();
  static final RouteGenerator _instance = RouteGenerator._();
  static RouteGenerator get instance => _instance;

  Route? generateRoute(RouteSettings routeSettings) {
    final routeName = routeSettings.name;

    switch (routeName) {
      case SplashScreen.id:
        return MaterialPageRoute<SplashScreen>(
          builder: (context) => const SplashScreen(),
        );

      case HomeScreen.id:
        return MaterialPageRoute<HomeScreen>(
          builder: (context) => const HomeScreen(),
        );

      default:
    }
  }
}
