import 'package:flutter/material.dart';
import 'register.dart'; // 👈 make sure this file exists

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        // Background gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB7D46D), Color(0xFF2B2200)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(
                          "assets/logo.png",
                          height: 60,
                          width: 60,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 12),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: "Code",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: "Leap",
                              style: TextStyle(color: Color(0xFFB7D46D)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "CodeLeap",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Welcome back! Sign in to continue",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),

                  const SizedBox(height: 25),

                  // Username field
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Username",
                      prefixIcon: const Icon(Icons.person_outline),
                      filled: true,
                      fillColor: const Color(0xFFF3F3F3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Password field
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: const Icon(Icons.visibility_off_outlined),
                      filled: true,
                      fillColor: const Color(0xFFF3F3F3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.black87, fontSize: 13),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Login button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF02021A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Register text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(fontSize: 14),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
