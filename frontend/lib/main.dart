import 'package:flutter/material.dart';
import 'package:frontend/track_cases/trackcase.dart';
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
      // home: HomeScreen() // Start with SplashScreen
      // home : TrackCourtCasesScreen()
      home : CaseStatusApp()
    );
  }
}
