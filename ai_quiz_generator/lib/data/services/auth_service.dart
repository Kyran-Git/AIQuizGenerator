import 'package:ai_quiz_generator/data/models/user.dart';

abstract class AuthService {
  Future<bool> validateCredentials(String username, String password);
  Future<bool> checkUsernameAvailability(String username);
  Future<void> manageSession(User user);
}

/// Simple stub that always succeeds; replace with real auth/provider later.
class InMemoryAuthService implements AuthService {
  final Map<String, String> _users = {};

  @override
  Future<bool> validateCredentials(String username, String password) async {
    return _users[username] == password;
  }

  @override
  Future<bool> checkUsernameAvailability(String username) async {
    return !_users.containsKey(username);
  }

  @override
  Future<void> manageSession(User user) async {
    // No-op for stub; in real app store token/session.
  }

  Future<void> register(User user) async {
    _users[user.username] = user.password;
  }
}
