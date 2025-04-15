import 'package:flutter/material.dart';
import '../models/user.dart';
import 'profilepage.dart';

class DemoProfileLauncher extends StatelessWidget {
  final User demoUser = User(
    name: 'Priyanshu Raj',
    email: 'priyanshu125@gmail.com',
    avatarUrl: 'https://i.pravatar.cc/300',
    role: 'Advocate',
  );

  DemoProfileLauncher({super.key});

  @override
  Widget build(BuildContext context) {
    // Immediately push to profile page
    Future.microtask(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ProfilePage(user: demoUser),
        ),
      );
    });

    // Return an empty scaffold while redirecting
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.shrink(), // Empty view
    );
  }
}
