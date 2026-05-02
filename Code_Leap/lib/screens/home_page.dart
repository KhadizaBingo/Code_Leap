import 'package:flutter/material.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        // Background Gradient
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

                // Top Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB7D46D),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.code, color: Colors.black),
                    ),

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
                    )
                  ],
                ),

                const SizedBox(height: 20),

                // Welcome Text
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Welcome, $username!",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.local_fire_department,
                              color: Colors.white, size: 18),
                          SizedBox(width: 4),
                          Text("1", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                const Text(
                  "Current Level: beginner",
                  style: TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 20),

                // Progress Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Your Progress",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        "Keep learning to level up!",
                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Experience"),
                          Text("0 / 100 XP"),
                        ],
                      ),

                      const SizedBox(height: 8),

                      LinearProgressIndicator(
                        value: 0.0,
                        backgroundColor: Colors.grey[300],
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Feature Cards
                Expanded(
                  child: ListView(
                    children: const [
                      FeatureTile(
                        icon: Icons.menu_book,
                        title: "Start Learning",
                        subtitle: "Choose your level and begin lessons",
                        iconColor: Colors.green,
                      ),
                      FeatureTile(
                        icon: Icons.flash_on,
                        title: "Quick Quiz",
                        subtitle: "Test your knowledge",
                        iconColor: Colors.orange,
                      ),
                      FeatureTile(
                        icon: Icons.emoji_events,
                        title: "Achievements",
                        subtitle: "Completed 0 lessons",
                        iconColor: Colors.green,
                      ),
                      FeatureTile(
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

  const FeatureTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle,
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}