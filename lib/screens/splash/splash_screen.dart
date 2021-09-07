import 'package:flutter/material.dart';
import 'package:product_hunt/core/app_startup.dart';
import 'package:product_hunt/screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await AppStartupLogic.initialize();
    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .pushNamedAndRemoveUntil(HomeScreen.id, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Product Hunt',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            letterSpacing: .6,
          ),
        ),
      ),
    );
  }
}
