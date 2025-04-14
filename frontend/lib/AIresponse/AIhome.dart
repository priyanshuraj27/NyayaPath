// lib/AIresponse/gemini_app.dart

import 'package:frontend/AIresponse/providers/q_a_provider.dart';
import 'package:frontend/AIresponse/screens/app.dart';
import 'package:frontend/AIresponse/widgets/no_api_key_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> geminiNavigatorKey = GlobalKey<NavigatorState>();

class GeminiInitializer {
  static Future<Widget> initialize() async {
    await dotenv.load(fileName: ".env");
    String? geminiAPIKey = dotenv.env['GEMINI_API_KEY'];

    if (geminiAPIKey != null) {
      Gemini.init(apiKey: geminiAPIKey);

      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => QAProvider()),
        ],
        child: const GemApp(),
      );
    } else {
      return const NoApiKeyFoundScreen();
    }
  }
}

class GemApp extends StatelessWidget {
  const GemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: geminiNavigatorKey,
      home: const App(),
    );
  }
}
