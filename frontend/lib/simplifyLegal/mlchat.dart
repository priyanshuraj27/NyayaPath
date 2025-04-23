import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _summaries = [];
  bool _isLoading = false;

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    // Optional delay to simulate processing
    await Future.delayed(const Duration(seconds: 1));

    const hardcodedSummary =
        "A non-profit organization filed a Public Interest Litigation (PIL) under Article 32 of the Indian Constitution challenging the eviction of slum dwellers in Mumbai without proper rehabilitation. "
        "The petitioner argued that the eviction violated Article 21, which guarantees the right to life and livelihood, citing the Olga Tellis judgment. "
        "The municipal authorities and state government defended the eviction as necessary for city development and claimed due process was followed with relocation plans underway. "
        "The Supreme Court appointed an amicus curiae to assess the situation and report back.";

    setState(() {
      _summaries.add(hardcodedSummary);
      _isLoading = false;
      _messageController.clear();
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101336),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C3A8C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'NyayaBandhu',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _summaries.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00B9F1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _summaries[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: const Color(0xFF2C3A8C),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.mic, color: Colors.white),
                  onPressed: () {
                    // Speech-to-text logic (to be implemented)
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.white),
                  onPressed: () {
                    // File picker logic (to be implemented)
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.white),
                  onPressed: () {
                    // Camera logic (to be implemented)
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter Document Data",
                      hintStyle: const TextStyle(color: Color(0xFFC3C6D1)),
                      filled: true,
                      fillColor: const Color(0xFF101336),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFF00B9F1)),
                        ),
                      )
                    : IconButton(
                        icon: const Icon(Icons.send, color: Color(0xFF00B9F1)),
                        onPressed: _sendMessage,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
