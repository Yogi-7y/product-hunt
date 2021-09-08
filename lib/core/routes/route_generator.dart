import 'package:flutter/material.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/home/models/post_model.dart';
import '../../screens/home/post_detail_screen.dart';
import '../../screens/splash/splash_screen.dart';

class RouteGenerator {
  RouteGenerator._();
  static final RouteGenerator _instance = RouteGenerator._();
  static RouteGenerator get instance => _instance;

  Route? generateRoute(RouteSettings routeSettings) {
    final routeName = routeSettings.name;
    final arguments = routeSettings.arguments;

    switch (routeName) {
      case SplashScreen.id:
        return MaterialPageRoute<SplashScreen>(
          builder: (context) => const SplashScreen(),
        );

      case HomeScreen.id:
        return MaterialPageRoute<HomeScreen>(
          builder: (context) => const HomeScreen(),
        );

      case PostDetailScreen.id:
        if (arguments is PostModel) {
          return MaterialPageRoute<PostDetailScreen>(
            builder: (context) => PostDetailScreen(
              postModel: arguments,
            ),
          );
        }
        return null;

      default:
        return null;
    }
  }
}
