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

              // 🔙 BACK BUTTON
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),

              // MAIN CARD
              Center(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

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
                          description:
                              "Python is like talking to your computer in simple English. "
                              "You give instructions, and it follows like a loyal assistant "
                              "But make one mistake, and it’s like: I have no idea what you mean  "
                              "It’s used for apps, games, and AI  "
                              "Learning Python = confusion + frustration + OMG I DID IT ",
                          image: "assets/python.png",
                        ),

                        LanguageTile(
                          name: "C",
                          description:
                              "C is that strict teacher who doesn’t care about your feelings. "
                              "You forgot a semicolon? Boom  error. "
                              "You want memory? Manage it yourself. "
                              "But once you master C… you unlock programming boss level.",
                          image: "assets/c.png",
                        ),

                        LanguageTile(
                          name: "C++",
                          description:
                              "C++ is C… but went to the gym and learned extra skills. "
                              "Why be simple when you can be powerful AND confusing? "
                              "Classes, objects, pointers — everything in one place. "
                              "Hard mode programming with premium weapons.",
                          image: "assets/cpp.png",
                        ),

                        LanguageTile(
                          name: "Java",
                          description:
                              "Java is that overprotective parent. "
                              "Don’t worry, I’ll handle memory for you. "
                              "Be structured and proper. Write once, run anywhere  "
                              "Clean and professional programming language.",
                          image: "assets/java.png",
                        ),
                      ],
                    ),
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

  // 🔥 ONLY FIRST SENTENCE PREVIEW
  String getPreview(String text) {
    int index = text.indexOf('.');
    if (index != -1) {
      return text.substring(0, index + 1);
    }
    return text;
  }

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
          border: Border.all(color: Colors.grey.shade300),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                const Icon(Icons.code),
                const SizedBox(width: 10),
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // 🔥 ONLY 1 LINE PREVIEW
            Text(
              getPreview(description),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}