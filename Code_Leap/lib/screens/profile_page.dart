import 'package:flutter/material.dart';
import 'auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? _profileData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    final data = await _authService.getProfile();
    if (mounted) {
      setState(() {
        _profileData = data as Map<String, dynamic>?;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B2200),
      appBar: AppBar(
        title: const Text("Account Details", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFB7D46D)))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Profile Header Section
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xFFB7D46D),
                      child: Icon(Icons.person, size: 50, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _profileData?['username'] ?? 'User',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  
                  // NEW: Email Display
                  Text(
                    _profileData?['email'] ?? 'No email linked',
                    style: const TextStyle(fontSize: 14, color: Colors.white60),
                  ),
                  
                  const SizedBox(height: 30),
                  const Divider(color: Colors.white10),
                  const SizedBox(height: 20),

                  // Stats Grid (Using the fields from your serializer)
                  _buildProfileInfoTile(Icons.trending_up, "Current Rank", (_profileData?['level'] ?? 'beginner').toString().toUpperCase()),
                  _buildProfileInfoTile(Icons.star, "Total Experience", "${_profileData?['xp'] ?? 0} XP"),
                  _buildProfileInfoTile(Icons.local_fire_department, "Current Streak", "${_profileData?['streak'] ?? 0} Days"),
                  _buildProfileInfoTile(Icons.calendar_month, "Last Active", _profileData?['last_active'] ?? 'N/A'),
                  
                  const SizedBox(height: 40),
                  
                  // Back Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB7D46D),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Return to Dashboard", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileInfoTile(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFB7D46D), size: 20),
          const SizedBox(width: 16),
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 15)),
          const Spacer(),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      ),
    );
  }
}