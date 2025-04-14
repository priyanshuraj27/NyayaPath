import 'package:dio/dio.dart';

class AuthService {
  final String baseUrl = 'http://10.0.2.2:8000';
  final Dio _dio = Dio();

  // Signup function
  Future<Map<String, dynamic>> signup(
    String username,
    String password,
    String email,
  ) async {
    // Debug print: input data
    // print("📤 Signup Initiated");
    // print("🧑 Username: $username");
    // print("📧 Email: $email");
    // print("🔒 Password: $password");

    try {
      final response = await _dio.post(
        '$baseUrl/signup/',
        data: {'username': username, 'password': password, 'email': email},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      // Debug print: server response
      // print("✅ Signup Successful: ${response.data}");
      return response.data;
    } catch (e) {
      // Debug print: error
      // print("❌ Signup Failed: $e");
      throw Exception('Failed to sign up: $e');
    }
  }

  // Login function with debugging statements
  Future<Map<String, dynamic>> login(String username, String password) async {
    // Debug print: input data
    // print("📤 Login Initiated");
    // print("📧 Email: $username");
    // print("🔒 Password: $password");

    try {
      final response = await _dio.post(
        '$baseUrl/login/', // Assuming JWT token endpoint is '/token/'
        data: {
          'username': username,
          'password': password,
        }, // Passing login credentials
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      // Debug print: server response
      // print("✅ Login Successful: ${response.data}");

      return response.data; // Return the response from the server (JWT token or user data)
    } catch (e) {
      // Debug print: error
      // print("❌ Login Failed: $e");
      throw Exception('Failed to log in: $e');
    }
  }
  /// tHIS IS FOR LOGOUT
  Future<void> logout() async {
  try {
    final response = await _dio.post(
      '$baseUrl/logout/',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          // Include token if needed:
          // 'Authorization': 'Bearer $token',
        },
      ),
    );

    // Optionally, print or handle the response
    // print("✅ Logout successful: ${response.data}");
  } catch (e) {
    // print("❌ Logout failed: $e");
    throw Exception('Failed to log out: $e');
  }
}

}
