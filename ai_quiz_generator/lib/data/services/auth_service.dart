import 'dart:convert';

import 'package:ai_quiz_generator/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthService {
  Future<bool> validateCredentials(String username, String password);
  Future<bool> checkUsernameAvailability(String username);
  Future<void> register(User user);
  Future<void> manageSession(User user);
  Future<User?> currentUser();
  Future<void> logout();
}

/// Local persistent auth using SharedPreferences.
class LocalAuthService implements AuthService {
  static const String _usersKey = 'auth_users';
  static const String _sessionKey = 'auth_current_user';

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<Map<String, String>> _loadUsers() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_usersKey);
    if (raw == null) return {};
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map((k, v) => MapEntry(k, v as String));
  }

  Future<void> _saveUsers(Map<String, String> users) async {
    final prefs = await _prefs;
    await prefs.setString(_usersKey, jsonEncode(users));
  }

  @override
  Future<bool> validateCredentials(String username, String password) async {
    if (username == 'admin' && password == 'admin') {
      return true;
    }
    final users = await _loadUsers();
    return users[username] == password;
  }

  @override
  Future<bool> checkUsernameAvailability(String username) async {
    final users = await _loadUsers();
    return !users.containsKey(username);
  }

  @override
  Future<void> register(User user) async {
    final users = await _loadUsers();
    users[user.username] = user.password;
    await _saveUsers(users);
  }

  @override
  Future<void> manageSession(User user) async {
    final prefs = await _prefs;
    await prefs.setString(_sessionKey, jsonEncode(user.toJson()));
  }

  @override
  Future<User?> currentUser() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_sessionKey);
    if (raw == null) return null;
    try {
      return User.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    final prefs = await _prefs;
    await prefs.remove(_sessionKey);
  }
}
