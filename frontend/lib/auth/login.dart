import 'package:flutter/material.dart';
import 'package:frontend/components/home_screen.dart';
import 'package:frontend/components/welcome.dart';
import 'signup.dart';
import 'package:frontend/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool rememberMe = false;
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  void _login() async {
  setState(() {
    _isLoading = true;
  });

  try {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    if (username == 'priyanshutest' && password == '123456') {
      // print("credentials matched. Redirecting to HomeScreen.");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      return;
    }

    // print("Attempting to login with username: $username and password: $password");

    // Proceed with normal login
    final response = await _authService.login(username, password);

    if (response.containsKey('access')) {
      print("Login Success: $response");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // print("Login failed: No access token received");
      throw Exception('Login failed');
    }
  } catch (e) {
    print("Login Error: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Login failed: $e')),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101336),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 260,
              decoration: const BoxDecoration(
                color: Color(0xFF2C3A8C),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Center(
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, size: 40, color: Color(0xFF101336)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Username Field
                  TextField(
                    controller: _usernameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Username(priyanshutest)",
                      labelStyle: const TextStyle(color: Color(0xFFC3C6D1)),
                      filled: true,
                      fillColor: const Color(0xFF2C3A8C),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password Field
                  TextField(
                    controller: _passwordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Password(123456)",
                      labelStyle: const TextStyle(color: Color(0xFFC3C6D1)),
                      filled: true,
                      fillColor: const Color(0xFF2C3A8C),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  // Remember Me & Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (bool? value) {
                              setState(() {
                                rememberMe = value ?? false;
                              });
                            },
                            activeColor: const Color(0xFF00B9F1),
                          ),
                          const Text(
                            "Remember Me",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Color(0xFF00B9F1)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00B9F1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Login",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreen()),
                        );
                      },
                      child: const Text(
                        "Don’t have an account? Sign Up",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),
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
