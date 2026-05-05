import 'package:flutter/material.dart';

class SectionsPage extends StatelessWidget {
  final String level;
  final List<String>? sections;

  const SectionsPage({
    super.key,
    required this.level,
    this.sections,
  });

  // 🎯 DEFAULT 5 SECTIONS (EDIT HERE ANYTIME)
  List<String> get defaultSections => [
        "Introduction",
        "Basics",
        "Input & Output",
        "Variables",
        "Operators",
      ];

  @override
  Widget build(BuildContext context) {
    final data = sections ?? defaultSections;

    return Scaffold(
      body: Container(
        width: double.infinity,

        // 🌿 SAME THEME
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

                // 🔙 TOP BAR
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),

                    Text(
                      level,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                const Text(
                  "Sections inside this level",
                  style: TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 20),

                // 📚 SECTIONS LIST
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(14),

                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.25),
                          ),
                        ),

                        child: Row(
                          children: [
                            const Icon(Icons.book, color: Colors.white),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Text(
                                "Section ${index + 1}: ${data[index]}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            const Icon(Icons.arrow_forward, color: Colors.white70),
                          ],
                        ),
                      );
                    },
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