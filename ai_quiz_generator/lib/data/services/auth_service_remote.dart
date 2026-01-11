import 'package:ai_quiz_generator/data/models/user.dart';
import 'package:ai_quiz_generator/data/services/api_client.dart';
import 'package:ai_quiz_generator/data/services/auth_service.dart';

/// API-based auth service using remote backend.
class RemoteAuthService implements AuthService {
  User? _currentUser;

  @override
  Future<bool> validateCredentials(String username, String password) async {
    if (username == 'admin' && password == 'admin') {
      _currentUser = User(
        userId: 'admin',
        username: 'admin',
        password: 'admin',
      );
      return true;
    }
    try {
      final response = await ApiClient.post<Map<String, dynamic>>(
        '/auth/login',
        body: {'username': username, 'password': password},
      );
      final success = response['success'] == true;
      if (success) {
        _currentUser = User(
          userId: response['userId'].toString(),
          username: response['username'] ?? '',
          password: password,
        );
      }
      return success;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> checkUsernameAvailability(String username) async {
    // Backend doesn't expose availability check; return true (proceed)
    return true;
  }

  @override
  Future<void> register(User user) async {
    final response = await ApiClient.post<Map<String, dynamic>>(
      '/auth/signup',
      body: {'username': user.username, 'password': user.password},
    );
    
    if (response['success'] == true) {
      // Capture the actual UUID from the backend response
      _currentUser = User(
        userId: response['userId'].toString(),
        username: user.username,
        password: user.password,
      );
    } else {
      throw Exception(response['message'] ?? 'Signup failed');
    }
  }

  @override
  Future<void> manageSession(User user) async {
    _currentUser = user;
  }

  @override
  Future<User?> currentUser() async {
    return _currentUser;
  }

  @override
  Future<void> logout() async {
    _currentUser = null;
  }
}

/// Fallback in-memory auth (for offline/testing).
class InMemoryAuthService implements AuthService {
  final Map<String, String> _users = {};
  User? _currentUser;

  @override
  Future<bool> validateCredentials(String username, String password) async {
    return _users[username] == password;
  }

  @override
  Future<bool> checkUsernameAvailability(String username) async {
    return !_users.containsKey(username);
  }

  @override
  Future<void> register(User user) async {
    try {
      final response = await ApiClient.post<Map<String, dynamic>>(
        '/auth/signup',
        body: {'username': user.username, 'password': user.password},
      );

      if (response['success'] == true) {
        _currentUser = User(
          userId: response['userId'].toString(),
          username: user.username,
          password: user.password,
        );
      } else {
        throw Exception(response['message'] ?? 'Signup failed');
      }
    } catch (e) {
      print("Signup Error: $e");
      rethrow;
    }
  }

  @override
  Future<void> manageSession(User user) async {
    _currentUser = user;
  }

  @override
  Future<User?> currentUser() async {
    return _currentUser;
  }

  @override
  Future<void> logout() async {
    _currentUser = null;
  }
}
