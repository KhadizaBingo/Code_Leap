import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // 👇 Change this based on where you're running Flutter
  static const baseUrl = 'http://localhost:8000/api/accounts'; // Flutter Web
  // static const baseUrl = 'http://10.0.2.2:8000/api/accounts'; // Android Emulator
  // static const baseUrl = 'http://192.168.x.x:8000/api/accounts'; // Real Device

  final _storage = const FlutterSecureStorage();

  // ─────────────────────────────────────────
  // REGISTER
  // ─────────────────────────────────────────
  Future<bool> register(String username, String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/register/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (res.statusCode == 201) {
        final data = jsonDecode(res.body);
        await _storage.write(key: 'access', value: data['access']);
        await _storage.write(key: 'refresh', value: data['refresh']);
        await _storage.write(key: 'username', value: username);
        return true;
      }
      return false;
    } catch (e) {
      print('Register error: $e');
      return false;
    }
  }

  // ─────────────────────────────────────────
  // LOGIN
  // ─────────────────────────────────────────
  Future<bool> login(String username, String password) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/login/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        await _storage.write(key: 'access', value: data['access']);
        await _storage.write(key: 'refresh', value: data['refresh']);
        await _storage.write(key: 'username', value: username);
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  // ─────────────────────────────────────────
  // LOGOUT
  // ─────────────────────────────────────────
  Future<void> logout() async {
    await _storage.deleteAll();
  }

  // ─────────────────────────────────────────
  // CHECK IF LOGGED IN
  // ─────────────────────────────────────────
  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'access');
    return token != null;
  }

  // ─────────────────────────────────────────
  // GET SAVED USERNAME
  // ─────────────────────────────────────────
  Future<String?> getUsername() async {
    return await _storage.read(key: 'username');
  }

  // ─────────────────────────────────────────
  // GET PROFILE (authenticated request)
  // ─────────────────────────────────────────
  Future<Map?> getProfile() async {
    try {
      final token = await _storage.read(key: 'access');

      if (token == null) return null;

      final res = await http.get(
        Uri.parse('$baseUrl/profile/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      }

      if (res.statusCode == 401) {
        final refreshed = await _refreshToken();
        if (refreshed) return getProfile();
      }

      return null;
    } catch (e) {
      print('Get profile error: $e');
      return null;
    }
  }

  // ─────────────────────────────────────────
  // REFRESH TOKEN
  // ─────────────────────────────────────────
  Future<bool> _refreshToken() async {
    try {
      final refresh = await _storage.read(key: 'refresh');

      if (refresh == null) return false;

      final res = await http.post(
        Uri.parse('$baseUrl/token/refresh/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refresh': refresh}),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        await _storage.write(key: 'access', value: data['access']);
        return true;
      }

      await logout();
      return false;
    } catch (e) {
      print('Refresh token error: $e');
      return false;
    }
  }

  // ─────────────────────────────────────────
  // FORGOT PASSWORD
  // ─────────────────────────────────────────
  Future<bool> forgotPassword(String email) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/password-reset/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );
      return res.statusCode == 200;
    } catch (e) {
      print('Forgot password error: $e');
      return false;
    }
  }

  // ─────────────────────────────────────────
  // RESET PASSWORD
  // ─────────────────────────────────────────
  Future<bool> resetPassword(String token, String newPassword) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/password-reset/confirm/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token, 'password': newPassword}),
      );
      return res.statusCode == 200;
    } catch (e) {
      print('Reset password error: $e');
      return false;
    }
  }

  // ─────────────────────────────────────────
  // COURSE & LESSON METHODS (Now inside the class)
  // ─────────────────────────────────────────

  Future<bool> completeLesson(int lessonId) async {
    try {
      final token = await _storage.read(key: 'access');
      final res = await http.post(
        Uri.parse('$baseUrl/lesson/$lessonId/complete/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<List<dynamic>> getCourses() async {
    try {
      final token = await _storage.read(key: 'access');
      final res = await http.get(
        Uri.parse('$baseUrl/courses/'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (res.statusCode == 200) return jsonDecode(res.body);
      if (res.statusCode == 401) {
        final refreshed = await _refreshToken();
        if (refreshed) return getCourses();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<Map?> getCourseDetail(int courseId) async {
    try {
      final token = await _storage.read(key: 'access');
      final res = await http.get(
        Uri.parse('$baseUrl/courses/$courseId/'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (res.statusCode == 200) return jsonDecode(res.body);
      return null;
    } catch (e) {
      return null;
    }
  }
} // End of AuthService class
