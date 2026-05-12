import 'package:flutter/material.dart';
import 'lesson_page.dart';

class LessonsPage extends StatelessWidget {
  final String sectionTitle;
  final List<dynamic>? lessons;

  const LessonsPage({
    super.key,
    required this.sectionTitle,
    this.lessons,
  });

  @override
  Widget build(BuildContext context) {
    final data = lessons ?? [];

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

                // BACK BUTTON + TITLE
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),

                    Expanded(
                      child: Text(
                        sectionTitle,
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

                // LESSON LIST
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final lesson = data[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LessonPage(
                                title: lesson["title"],
                                content: lesson["content"],
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

                              const Icon(Icons.menu_book, color: Colors.white),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Text(
                                  "Lesson ${index + 1}: ${lesson["title"]}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white70,
                              ),
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