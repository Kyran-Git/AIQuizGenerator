import 'package:ai_quiz_generator/controller/binding/app_binding.dart';
import 'package:ai_quiz_generator/screen/auth/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_quiz_generator/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      title: "AI Quiz Generator",
      theme: AppTheme.lightTheme(),
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}
