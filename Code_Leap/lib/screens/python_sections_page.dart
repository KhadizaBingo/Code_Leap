import 'package:flutter/material.dart';

class PythonSectionsPage extends StatelessWidget {
  const PythonSectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        // 🔥 GLOBAL APP THEME (KEEP SAME)
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
            padding: const EdgeInsets.only(
              left: 8,
              right: 16,
              top: 16,
              bottom: 16,
            ),

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

                    const Text(
                      "Python Course",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                const Text(
                  "Learn step by step and build your skills",
                  style: TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 20),

                // 🔥 SECTIONS LIST
                Expanded(
                  child: ListView(
                    children: [
                      SectionTile(title: "Section 1: Introduction to Python"),
                      SectionTile(title: "Section 2: Data Types and Variables"),
                      SectionTile(title: "Section 3: Control Flow"),
                      SectionTile(title: "Section 4: Functions and Modules"),
                      SectionTile(title: "Section 5: Object-Oriented Programming"),
                      SectionTile(title: "Section 6: File Handling"),
                    ],
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

class SectionTile extends StatelessWidget {
  final String title;

  const SectionTile({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward, color: Colors.white70),
          onTap: () {},
        ),
      ),
    );
  }
}