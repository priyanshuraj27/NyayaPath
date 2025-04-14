import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/AIresponse/common/common_functions.dart';
import 'package:frontend/AIresponse/data/questions_data.dart';
import 'package:frontend/AIresponse/routes/kroutes.dart';
import 'package:frontend/AIresponse/screens/generate_ai.dart';
import 'package:frontend/components/home_screen.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int page = 0;
  late LiquidController liquidController;
  int pageAnimationDuration = 600;

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(0.0, 1.0 - ((page) - index).abs()),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return SizedBox(
      width: 25.0,
      child: Center(
        child: Container(
          width: 8.0 * zoom,
          height: 8.0 * zoom,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101336),
      body: Stack(
        children: <Widget>[
          LiquidSwipe.builder(
            itemCount: questionsData.length,
            disableUserGesture: true,
            itemBuilder: (context, index) {
              final currentQuestion = questionsData[index];
              return AnimatedMeshGradient(
                colors: currentQuestion.bg,
                options: AnimatedMeshGradientOptions(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  width: double.infinity,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C3A8C).withOpacity(0.85),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            currentQuestion.question,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CommonFunctions.getQuestionOptions(
                            context: context,
                            questionData: currentQuestion,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            positionSlideIcon: 0.8,
            slideIconWidget: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPageChangeCallback: (int lpage) {
              setState(() => page = lpage);
            },
            waveType: WaveType.liquidReveal,
            liquidController: liquidController,
            fullTransitionValue: 880,
            enableSideReveal: true,
            ignoreUserGestureWhileAnimating: true,
          ),

          /// Back to Home Icon Button
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ),

          /// Tracker Dots
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(questionsData.length, _buildDot),
            ),
          ),

          /// Previous Button
          if (liquidController.currentPage > 0)
            Positioned(
              bottom: 30,
              left: 25,
              child: ElevatedButton(
                onPressed: () {
                  liquidController.animateToPage(
                    page: liquidController.currentPage - 1,
                    duration: pageAnimationDuration,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C3A8C),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Previous"),
              ),
            ),

          /// Next Button
          Positioned(
            bottom: 30,
            right: 25,
            child: ElevatedButton(
              onPressed: () {
                if (liquidController.currentPage + 1 >= questionsData.length) {
                  KRoute.push(context: context, page: const GenerateAI());
                } else {
                  liquidController.animateToPage(
                    page: liquidController.currentPage + 1,
                    duration: pageAnimationDuration,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00B9F1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Next"),
            ),
          ),
        ],
      ),
    );
  }
}
