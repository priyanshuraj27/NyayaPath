import 'package:flutter/material.dart';
// import 'package:frontend/components/language_select.dart';
// import 'components/splash.dart';
import 'components/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Place the print statement inside the build method
    //dfdf
    return MaterialApp(
      title: 'My Splash App',
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen
      (), // Start with SplashScreen
    );
  }
}
