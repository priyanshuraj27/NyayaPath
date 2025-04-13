import 'package:flutter/material.dart';
import 'package:frontend/auth/login.dart';

void main() {
  runApp(
    MaterialApp(home: OnboardingScreen(), debugShowCheckedModeBanner: false),
  );
}

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int _currentIndex = 0;

  // List of image paths
  final List<String> imagePaths = [
    'assets/images/knowyourrights.jpg',
    'assets/images/knowyourrights.jpg',
    'assets/images/knowyourrights.jpg',
  ];

  final List<String> titles = [
    "Know Your Rights",
    "Track Public Cases",
    "Find Legal Help",
  ];

  void _nextPage() {
    if (_currentIndex < imagePaths.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Login action here
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 60),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: imagePaths.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Center(
                    child: Container(
                      height: 400,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [Colors.grey.shade200, Colors.grey.shade400],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            blurRadius: 8,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset(
                                imagePaths[index],
                                fit: BoxFit.contain,
                                height: 200,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 15,
                            child: Text(
                              titles[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: _nextPage,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.black),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    child: Text(
                      _currentIndex == imagePaths.length - 1 ? 'Login' : 'Next',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo[900],
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    child: Text('Skip', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
