import 'package:flutter/material.dart';

class LessonPage extends StatelessWidget {
  final String title;
  final String content;

  const LessonPage({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFB7D46D),
              Color(0xFF2B2200),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // BACK + TITLE
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white),
                    ),

                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 📚 CONTENT (BOX STYLE SPLIT)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: content
                          .split("\n")
                          .map((line) => line.trim())
                          .where((line) => line.isNotEmpty)
                          .map((line) {
                        return Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),

                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.25),
                            ),
                          ),

                          child: Text(
                            line,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}