import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  static const String apiUrl = 'http://127.0.0.1:8000/chat/ask-gemini/';

  static Future<String> askGemini(String message) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'] ?? 'No response';
      } else {
        return 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
