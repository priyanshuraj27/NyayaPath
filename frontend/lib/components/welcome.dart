import 'package:flutter/material.dart';
import 'package:frontend/auth/login.dart';

void main() {
  runApp(
    MaterialApp(home: OnboardingScreen(), debugShowCheckedModeBanner: false),
  );
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> imagePaths = [
    'assets/images/UnderstandYourRights.jpeg',
    'assets/images/TrackYourCase.jpeg',
    'assets/images/FindLegalAid.jpeg',
  ];

  final List<String> titles = [
    "Know Your Rights",
    "Track Public Cases",
    "Find Legal Help",
  ];

  final List<String> subtitles = [
    "Understand your legal rights in simple terms.",
    "Follow real-time updates of ongoing public cases.",
    "Get connected to verified legal aid providers near you.",
  ];

  void _nextPage() {
    if (_currentIndex < imagePaths.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = Color(0xFF101336); // Nyayapath dark blue
    final accentColor = Color(0xFF00B9F1); // Nyayapath cyan

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      ),
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: imagePaths.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      // Image (full width banner style)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 20,
                        ),
                        child: Image.asset(
                          imagePaths[index],
                          width: double.infinity,
                          height: 500,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Title
                      Text(
                        titles[index],
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: bgColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Subtitle
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          subtitles[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
            // Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                imagePaths.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 14 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? bgColor : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Next/Login button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bgColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    _currentIndex == imagePaths.length - 1 ? 'Login' : 'Next',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
