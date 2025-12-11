import 'package:ai_quiz_generator/data/models/user.dart';
import 'package:ai_quiz_generator/data/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  AuthController({required this.authService});

  final AuthService authService;
  final Rxn<User> currentUser = Rxn<User>();
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();

  @override
  void onInit() {
    super.onInit();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final user = await authService.currentUser();
    currentUser.value = user;
  }

  Future<bool> login(String username, String password) async {
    isLoading.value = true;
    error.value = null;
    final valid = await authService.validateCredentials(username, password);
    if (valid) {
      final user = User(
        userId: username,
        username: username,
        password: password,
      );
      await authService.manageSession(user);
      currentUser.value = user;
    } else {
      error.value = 'Invalid username or password';
    }
    isLoading.value = false;
    return valid;
  }

  Future<bool> signUp(String username, String password) async {
    isLoading.value = true;
    error.value = null;
    final available = await authService.checkUsernameAvailability(username);
    if (!available) {
      error.value = 'Username is already taken';
      isLoading.value = false;
      return false;
    }
    final user = User(userId: username, username: username, password: password);
    await authService.register(user);
    await authService.manageSession(user);
    currentUser.value = user;
    isLoading.value = false;
    return true;
  }

  Future<void> logout() async {
    await authService.logout();
    currentUser.value = null;
  }
}
