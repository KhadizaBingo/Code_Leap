import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Mock data to show you how it looks (In real use, this comes from Django)
  final String question =
      "Which of the following is used to create a constant in Dart?";
  final Map<String, String> options = {
    "a": "var",
    "b": "final",
    "c": "let",
    "d": "dynamic",
  };
  final String correctAnswer = "b";

  String? selectedOption;
  bool isAnswered = false;

  void _checkAnswer() {
    if (selectedOption == null) return;
    setState(() {
      isAnswered = true;
    });

    if (selectedOption == correctAnswer) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Correct! +10 XP"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Wrong answer! Try again."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B2200), // Your dark theme
      appBar: AppBar(
        title: const Text("Daily Quiz"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "QUESTION",
              style: TextStyle(
                color: Color(0xFFB7D46D),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              question,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),

            // Generate options
            ...options.entries
                .map((entry) => _buildOptionCard(entry.key, entry.value))
                .toList(),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB7D46D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: isAnswered
                    ? () => Navigator.pop(context)
                    : _checkAnswer,
                child: Text(
                  isAnswered ? "GO BACK" : "CHECK ANSWER",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(String key, String value) {
    bool isSelected = selectedOption == key;
    return GestureDetector(
      onTap: isAnswered ? null : () => setState(() => selectedOption = key),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFB7D46D).withOpacity(0.2)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? const Color(0xFFB7D46D) : Colors.white10,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: isSelected
                  ? const Color(0xFFB7D46D)
                  : Colors.white24,
              child: Text(
                key.toUpperCase(),
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
            const SizedBox(width: 15),
            Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
