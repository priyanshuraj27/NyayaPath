import 'package:flutter/material.dart';
import '../models/user.dart';
import 'profilepage.dart';

class DemoProfileLauncher extends StatelessWidget {
  final User demoUser = User(
    name: 'Priya Sharma',
    email: 'priya@example.com',
    avatarUrl: 'https://i.pravatar.cc/300',
    role: 'Advocate',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Demo Launcher")),
      body: Center(
        child: ElevatedButton(
          child: Text("Go to Profile"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(user: demoUser),
              ),
            );
          },
        ),
      ),
    );
  }
}
