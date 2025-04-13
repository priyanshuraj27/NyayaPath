import 'package:flutter/material.dart';
import 'package:frontend/aichat/aichatscreen.dart';
import 'package:frontend/components/splash.dart';
import 'package:frontend/profile/demoprofile.dart';
// import 'package:frontend/components/home_screen.dart';
// import 'package:frontend/track_cases/trackCases.dart';

// import 'components/splash.dart';
// import 'components/welcome.dart';
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
      // home : SplashScreen(), // Start with SplashScreen
      home : DemoProfileLauncher()
    );
  }
}
