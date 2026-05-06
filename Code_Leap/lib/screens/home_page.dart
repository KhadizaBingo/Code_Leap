import 'package:flutter/material.dart';
import 'login_page.dart';
import 'auth_service.dart';
import 'preference_page.dart';
import 'quiz_screen.dart';
import 'profile_page.dart'; // Import your new profile page

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();

  // Dynamic State variables synchronized with Django UserProfile
  String _level = 'beginner';
  int _xp = 0;
  int _streak = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Fetches fresh data from your Django profile view
  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);
    try {
      final profile = await _authService.getProfile();
      if (profile != null && mounted) {
        setState(() {
          _level = profile['level'] ?? 'beginner';
          _xp = profile['xp'] ?? 0;
          _streak = profile['streak'] ?? 0;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Progress logic: 100 XP (Intermediate) / 200 XP (Advanced)
  double get _progressValue {
    if (_xp >= 200) return 1.0;
    if (_xp >= 100) return (_xp - 100) / 100;
    return _xp / 100;
  }

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
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTopBar(),
                      const SizedBox(height: 20),
                      _buildWelcomeHeader(),
                      const SizedBox(height: 20),
                      _buildProgressCard(),
                      const SizedBox(height: 20),
                      const Text(
                        "Learning Hub",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(child: _buildFeatureList()),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            // LOGO & PROFILE LINK
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                ).then((_) => _loadUserData()); // Refresh home when returning
              },
              child: Row(
                children: [
                  Image.asset(
                    "assets/logo.png",
                    height: 55,
                    width: 55,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.account_circle,
                      size: 55,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // LOGOUT BUTTON
            ElevatedButton(
              onPressed: () async {
                await _authService.logout();
                if (mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // STREAK BADGE
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.95),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "🔥 $_streak",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome ${widget.username}!",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "Current Level: ${_level.toUpperCase()}",
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressCard() {
    int nextGoal = _xp < 100 ? 100 : 200;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your Progress",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 5),
          const Text(
            "Keep learning to level up!",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Experience",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              Text(
                "$_xp / $nextGoal XP",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: _progressValue,
              backgroundColor: Colors.grey[200],
              color: Colors.black,
              minHeight: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureList() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        FeatureTile(
          icon: Icons.menu_book,
          title: "Start Learning",
          subtitle: "Choose your language preference",
          iconColor: Colors.green,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PreferencePage()),
          ).then((_) => _loadUserData()),
        ),
        FeatureTile(
          icon: Icons.flash_on,
          title: "Quick Quiz",
          subtitle: "Test your knowledge for bonus XP",
          iconColor: Colors.orange,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QuizScreen()),
          ).then((_) => _loadUserData()),
        ),
        FeatureTile(
          icon: Icons.emoji_events,
          title: "Achievements",
          subtitle: "View your earned badges",
          iconColor: Colors.blue,
          onTap: () {
            // Future achievements logic
          },
        ),
        FeatureTile(
          icon: Icons.access_time,
          title: "Daily Reminder",
          subtitle: "Set your learning schedule",
          iconColor: Colors.purple,
          onTap: () {
            // Future reminder logic
          },
        ),
      ],
    );
  }
}

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;

  const FeatureTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.1),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}
