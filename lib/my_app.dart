import 'package:flutter/material.dart';
import 'package:product_hunt/core/configs/size_config.dart';

import 'core/routes/route_generator.dart';
import 'screens/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig.instance.initialize(constraints, orientation);
          return MaterialApp(
            title: 'Haptik Assignment',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.instance.generateRoute,
            initialRoute: SplashScreen.id,
          );
        },
      ),
    );
  }
}
