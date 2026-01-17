import 'package:ai_quiz_generator/data/models/user.dart';
import 'package:ai_quiz_generator/data/services/auth_service.dart';
import 'package:ai_quiz_generator/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
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
    checkConnectivityAndRedirect();
  }

  Future<void> _loadSession() async {
    final user = await authService.currentUser();
    currentUser.value = user;
  }

  Future<void> checkConnectivityAndRedirect() async {
    try {
      // check internet connectivity
      final result = await InternetAddress.lookup('google.com');
      
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // ONLINE: Do nothing, stay on Login Screen (or check saved session)
        print("You are Online. Please Login.");
      }
    } on SocketException catch (_) {
      // 2. OFFLINE: Skip Login!
      print("No Internet detected. Skipping to Offline Mode...");
      
      // Create the Offline Guest User
      final offlineUser = User(
        userId: "offline_guest",
        username: '', 
        password: '',
        // Add other required fields with dummy data
      );

      // Set as current user
      currentUser.value = offlineUser;
      
      // Navigate straight to Home, removing Login from back stack
      // (Wait 1 frame to ensure GetX is ready)
      Future.delayed(Duration.zero, () {
        Get.offAll(() => const HomeScreen()); 
        Get.snackbar("Offline Mode", "No internet connection. Logged in as Guest.", 
          backgroundColor: Colors.orange, colorText: Colors.white, duration: const Duration(seconds: 4));
      });
    }
  }

  Future<bool> login(String username, String password) async {
    isLoading.value = true;
    error.value = null;
    final valid = await authService.validateCredentials(username, password);
    if (valid) {
      final user = await authService.currentUser();
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
    try {
      final user = User(userId: '', username: username, password: password);
      await authService.register(user);
      final registeredUser = await authService.currentUser();
      currentUser.value = registeredUser;
      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = 'Signup failed';
      isLoading.value = false;
      return false;
    }
  }

  Future<void> logout() async {
    await authService.logout();
    currentUser.value = null;
  }
}
