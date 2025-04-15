import 'package:frontend/AIresponse/const/ktheme.dart';
import 'package:frontend/AIresponse/providers/q_a_provider.dart';
import 'package:frontend/AIresponse/screens/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GenerateAI extends StatefulWidget {
  const GenerateAI({super.key});

  @override
  State<GenerateAI> createState() => _SectionTextInputStreamState();
}

class _SectionTextInputStreamState extends State<GenerateAI> {
  final ImagePicker picker = ImagePicker();
  final gemini = Gemini.instance;
  String? question, _finishReason;

  String? get finishReason => _finishReason;

  set finishReason(String? set) {
    if (set != _finishReason) {
      setState(() => _finishReason = set);
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provid = Provider.of<QAProvider>(context, listen: false);
      question = provid.generateQuestion();

      if (question == null || question!.trim().isEmpty) {
        debugPrint("⚠️ No question generated.");
        return;
      }

      gemini
          .streamGenerateContent(
            question!,
            modelName: 'models/gemini-1.5-flash-latest',
          )
          .handleError((e) {
            if (e is GeminiException) {
              debugPrint("Gemini error: $e");
            }
          })
          .listen((value) {
            if (value.finishReason != 'STOP') {
              finishReason = 'Finish reason is `${value.finishReason}`';
            }
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedMeshGradient(
            colors: Ktheme.nyayapathMeshGrad,
            options: AnimatedMeshGradientOptions(),
            child: const SizedBox(
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const App()),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Reset',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GeminiResponseTypeView(
                    builder: (context, child, response, loading) {
                      if (loading) {
                        return Center(
                          child: Lottie.asset('assets/lottie/ai.json'),
                        );
                      }

                      if (response != null) {
                        return Markdown(
                          onTapLink: (text, href, title) {
                            if (href != null) {
                              launchUrl(Uri.parse(href));
                            }
                          },
                          data: response,
                          selectable: true,
                          styleSheet: MarkdownStyleSheet(
                            p: const TextStyle(color: Colors.white),
                            h1: const TextStyle(color: Colors.white),
                            h2: const TextStyle(color: Colors.white),
                            h3: const TextStyle(color: Colors.white),
                            strong: const TextStyle(color: Colors.white),
                            em: const TextStyle(color: Colors.white),
                            code: const TextStyle(color: Colors.white),
                            blockquote: const TextStyle(color: Colors.white),
                            listBullet: const TextStyle(color: Colors.white),
                            tableBody: const TextStyle(color: Colors.white),
                            tableHead: const TextStyle(color: Colors.white),
                            tableBorder: TableBorder.all(color: Colors.white24),
                            tableColumnWidth: const FixedColumnWidth(120.0),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text(
                            'Search something!',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                    },
                  ),
                ),
                if (finishReason != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      finishReason!,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
