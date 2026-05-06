import 'package:flutter/material.dart';
import 'course_page.dart';

class LearningPage extends StatefulWidget {
  final String? recommendedLanguage;

  const LearningPage({super.key, this.recommendedLanguage});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB7D46D), Color(0xFF2B2200)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
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

                        // Pass the recommendation status to each tile
                        _buildTile("Python"),
                        _buildTile("C"),
                        _buildTile("C++"),
                        _buildTile("Java"),
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

  // Helper to build tiles and check for recommendation
  Widget _buildTile(String name) {
    final bool isRecommended = widget.recommendedLanguage == name;

    // Data Mapping for descriptions/images
    final Map<String, dynamic> data = {
      "Python": {
        "desc":
            "Python is like talking to your computer in simple English. It’s used for apps, games, and AI.",
        "img": "assets/python.png",
      },
      "C": {
        "desc":
            "C is that strict teacher who doesn’t care about your feelings. Unlock programming boss level.",
        "img": "assets/c.png",
      },
      "C++": {
        "desc":
            "C++ is C… but went to the gym. Hard mode programming with premium weapons.",
        "img": "assets/cpp.png",
      },
      "Java": {
        "desc":
            "Java is that overprotective parent. Clean and professional programming language.",
        "img": "assets/java.png",
      },
    };

    return LanguageTile(
      name: name,
      description: data[name]["desc"],
      image: data[name]["img"],
      isRecommended: isRecommended, // New parameter
    );
  }
}

class LanguageTile extends StatelessWidget {
  final String name;
  final String description;
  final String image;
  final bool isRecommended;

  const LanguageTile({
    super.key,
    required this.name,
    required this.description,
    required this.image,
    this.isRecommended = false,
  });

  String getPreview(String text) {
    int index = text.indexOf('.');
    return index != -1 ? text.substring(0, index + 1) : text;
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
          // Highlight border if recommended
          border: Border.all(
            color: isRecommended
                ? const Color(0xFFB7D46D)
                : Colors.grey.shade300,
            width: isRecommended ? 2 : 1,
          ),
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
                const Spacer(),
                if (isRecommended)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB7D46D),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Recommended",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              getPreview(description),
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
