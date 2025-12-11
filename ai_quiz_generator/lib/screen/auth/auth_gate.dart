import 'package:ai_quiz_generator/controller/auth_controller.dart';
import 'package:ai_quiz_generator/screen/auth/login_screen.dart';
import 'package:ai_quiz_generator/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Obx(() {
      if (authController.isLoading.value &&
          authController.currentUser.value == null) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      if (authController.currentUser.value == null) {
        return const LoginScreen();
      }
      return const HomeScreen();
    });
  }
}
