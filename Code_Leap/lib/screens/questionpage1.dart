import 'package:flutter/material.dart';
import 'questionpage2.dart';

class Question1Page extends StatefulWidget {
  const Question1Page({super.key});

  @override
  State<Question1Page> createState() => _Question1PageState();
}

class _Question1PageState extends State<Question1Page> {
  String? selected;

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

                const Text("Question 1 of 3",
                    style: TextStyle(color: Colors.grey)),

                const SizedBox(height: 10),

                const Text(
                  "Have you coded before?",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 25),

                option("Yes"),
                option("No"),

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
                                      const Question2Page()),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB7D46D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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
      onTap: () {
        setState(() {
          selected = text;
        });
      },
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
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? const Color(0xFFB7D46D) : Colors.grey,
            ),
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