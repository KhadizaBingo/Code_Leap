import 'package:flutter/material.dart';
import 'questionpage3.dart';

class Question2Page extends StatefulWidget {
  const Question2Page({super.key});

  @override
  State<Question2Page> createState() => _Question2PageState();
}

class _Question2PageState extends State<Question2Page> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB7D46D), Color(0xFF2B2200)],
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text("Question 2 of 3",
                    style: TextStyle(color: Colors.grey)),

                const SizedBox(height: 10),

                const Text(
                  "What do you want to achieve?",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 25),

                option("Get a job"),
                option("Build Apps"),
                option("Study"),
                option("Just for fun"),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: selected == null
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Question3Page()),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB7D46D),
                    ),
                    child: const Text("Next",
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget option(String text) {
    bool isSelected = selected == text;

    return GestureDetector(
      onTap: () => setState(() => selected = text),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFB7D46D) : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(isSelected
                ? Icons.check_circle
                : Icons.circle_outlined),
            const SizedBox(width: 10),
            Text(text,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}