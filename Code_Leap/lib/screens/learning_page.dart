import 'package:flutter/material.dart';
import 'course_page.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

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
          child: Stack(
            children: [

              // 🔙 BACK BUTTON (OUTSIDE BOX - TOP LEFT)
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),

              // CENTER CARD
              Center(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(height: 10),

                      const Text(
                        "Start Learning",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        "Choose a language to begin your journey",
                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 15),

                      LanguageTile(
                        name: "Python",
                        description: "Beginner friendly language for AI & web",
                        image: "assets/python.png",
                      ),

                      LanguageTile(
                        name: "C",
                        description: "Low level system programming language",
                        image: "assets/c.png",
                      ),

                      LanguageTile(
                        name: "C++",
                        description: "Used for games & object-oriented programming",
                        image: "assets/cpp.png",
                      ),

                      LanguageTile(
                        name: "Java",
                        description: "Used for apps & enterprise systems",
                        image: "assets/java.png",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageTile extends StatelessWidget {
  final String name;
  final String description;
  final String image;

  const LanguageTile({
    super.key,
    required this.name,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CoursePage(
              language: name,
              description: description,
              imagePath: image,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
        ),

        child: Row(
          children: [
            const Icon(Icons.code, color: Colors.black),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
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