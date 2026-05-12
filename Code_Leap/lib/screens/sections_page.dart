import 'package:flutter/material.dart';
import 'lessons_page.dart';

class SectionsPage extends StatelessWidget {
  final String level;
  final List<dynamic>? sections;

  const SectionsPage({
    super.key,
    required this.level,
    this.sections,
  });

  @override
  Widget build(BuildContext context) {
    final data = sections ?? [];

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

                // TOP BAR
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

                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {

                      final section = data[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LessonsPage(
                                sectionTitle: section["title"],
                                lessons: section["lessons"],
                              ),
                            ),
                          );
                        },

                        child: Container(
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
                                  "Section ${index + 1}: ${section["title"]}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              const Icon(Icons.arrow_forward,
                                  color: Colors.white70),
                            ],
                          ),
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