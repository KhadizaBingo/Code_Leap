import 'package:flutter/material.dart';
import 'sections_page.dart'; // Import the sections page
import 'course_data.dart'; // Import the data map we created earlier

class LanguageLevelPage extends StatelessWidget {
  final String languageName;

  const LanguageLevelPage({super.key, required this.languageName});

  @override
  Widget build(BuildContext context) {
    // Retrieve the levels for the selected language (e.g., Python, Dart)
    final List<Map<String, dynamic>> levels =
        CourseData.data[languageName] ?? [];

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BACK BUTTON & TITLE
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    Text(
                      "$languageName Course",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: levels.length,
                  itemBuilder: (context, index) {
                    final level = levels[index];
                    return _buildLevelTile(context, level);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelTile(BuildContext context, Map<String, dynamic> levelData) {
    final String levelName = levelData['name'];
    final List<String> sections = List<String>.from(levelData['sections']);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // CONNECTION LOGIC
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SectionsPage(level: levelName, sections: sections),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white24),
          ),
          child: Row(
            children: [
              const Icon(Icons.psychology, color: Colors.white, size: 30),
              const SizedBox(width: 16),
              Expanded(
                child: Hero(
                  tag: 'level_title_$levelName',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      levelName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white70),
            ],
          ),
        ),
      ),
    );
  }
}
