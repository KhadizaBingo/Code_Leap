import 'package:flutter/material.dart';
import 'login_page.dart';
import 'preference_page.dart';

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({super.key, required this.username});

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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // 🔥 TOP BAR FIXED ALIGNMENT
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    // LOGO (ALIGNED WITH TEXT START)
                    Image.asset(
                      "assets/logo.png",
                      height: 55,
                      width: 55,
                      fit: BoxFit.contain,
                    ),

                    const Spacer(),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 🔥 WELCOME TEXT (ALIGNED WITH LOGO START LINE)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome $username!",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 12, 12, 12),
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  "Current Level: beginner",
                  style: TextStyle(color: Color.fromARGB(179, 22, 22, 22)),
                ),

                const SizedBox(height: 20),

                // PROGRESS CARD
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Progress",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Keep learning to level up!",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Experience"),
                          Text("0 / 100 XP"),
                        ],
                      ),
                      SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: 0.0,
                        backgroundColor: Colors.grey,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: ListView(
                    children: [

                      FeatureTile(
                        icon: Icons.menu_book,
                        title: "Start Learning",
                        subtitle: "Choose your language preference",
                        iconColor: Colors.green,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PreferencePage(),
                            ),
                          );
                        },
                      ),

                      const FeatureTile(
                        icon: Icons.flash_on,
                        title: "Quick Quiz",
                        subtitle: "Test your knowledge",
                        iconColor: Colors.orange,
                      ),

                      const FeatureTile(
                        icon: Icons.emoji_events,
                        title: "Achievements",
                        subtitle: "Completed 0 lessons",
                        iconColor: Colors.green,
                      ),

                      const FeatureTile(
                        icon: Icons.access_time,
                        title: "Daily Reminder",
                        subtitle: "Set your learning schedule",
                        iconColor: Colors.purple,
                      ),
                    ],
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

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback? onTap;

  const FeatureTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}