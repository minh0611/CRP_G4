import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/Screens/signin.dart';
import 'package:splash_view/splash_view.dart';

import '../utils/color_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashView(
        logo: const Image(image: AssetImage('assets/images/logo.png')),
        loadingIndicator: const RefreshProgressIndicator(
          backgroundColor: Color.fromARGB(224, 15, 28, 70),
          strokeWidth: 5,
        ),
        done: Done(
          const SignInScreen(),
          animationDuration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutQuad,
        ),
        gradient: LinearGradient(colors: [
          hexStringColor("0F1C46"),
          hexStringColor("0F1C46"),
          hexStringColor("FFFFFF"),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
    );
  }
}
