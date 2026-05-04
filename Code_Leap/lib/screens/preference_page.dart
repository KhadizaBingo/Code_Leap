import 'package:flutter/material.dart';
import 'learning_page.dart';

class PreferencePage extends StatefulWidget {
  const PreferencePage({super.key});

  @override
  State<PreferencePage> createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  String? selected;
  String? suggestion;
  bool showRecommendation = false;

  String getSuggestion(String answer) {
    switch (answer) {
      case "I'm new":
        return "Python";
      case "Python":
        return "C++";
      case "C":
        return "C++";
      case "C++":
        return "Java";
      case "Java":
        return "Advanced Java";
      default:
        return "Python";
    }
  }

  Widget option(String text) {
    bool isSelected = selected == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          selected = text;
          showRecommendation = false;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFB7D46D) : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? const Color(0xFFB7D46D) : Colors.grey,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

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

              // 🔙 BACK BUTTON (TOP LEFT)
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

              // 🔥 MAIN CONTENT (FIXED START POSITION)
              Padding(
                padding: const EdgeInsets.only(top: 60), // 👈 IMPORTANT FIX
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(25),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // 🔥 NOW THIS STARTS PROPERLY UNDER BACK BUTTON
                          const Text(
                            "Quick Question",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            "Which programming languages are you already familiar with?",
                            style: TextStyle(color: Colors.grey),
                          ),

                          const SizedBox(height: 20),

                          option("I'm new"),
                          option("Python"),
                          option("C"),
                          option("C++"),
                          option("Java"),

                          const SizedBox(height: 20),

                          if (selected != null && !showRecommendation)
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    suggestion = getSuggestion(selected!);
                                    showRecommendation = true;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFB7D46D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "Continue",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),

                          if (showRecommendation)
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 20),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFB7D46D).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  const Text(
                                    "Nice choice 👏",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    "We recommend: $suggestion",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 15),

                                  SizedBox(
                                    width: double.infinity,
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LearningPage(),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFB7D46D),
                                      ),
                                      child: const Text(
                                        "Start Learning",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
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