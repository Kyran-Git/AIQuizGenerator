import 'package:ai_quiz_generator/controller/auth_controller.dart';
import 'package:ai_quiz_generator/screen/auth/signup_screen.dart';
import 'package:ai_quiz_generator/screen/auth/auth_gate.dart';
import 'package:ai_quiz_generator/widgets/primary_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AuthController authController;

  @override
  void initState() {
    super.initState();
    authController = Get.find<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (val) => (val == null || val.isEmpty)
                    ? 'Username is required'
                    : null,
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (val) => (val == null || val.isEmpty)
                    ? 'Password is required'
                    : null,
              ),
              const SizedBox(height: 20.0),
              Obx(() {
                final loading = authController.isLoading.value;
                return SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: PrimaryButton(
                    onPressed: loading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              final success = await authController.login(
                                _usernameController.text.trim(),
                                _passwordController.text.trim(),
                              );
                              if (success) {
                                Get.offAll(() => const AuthGate());
                              }
                            }
                          },
                    text: loading ? 'Logging in...' : 'Login',
                  ),
                );
              }),
              const SizedBox(height: 12.0),
              Obx(() {
                final err = authController.error.value;
                if (err == null) return const SizedBox.shrink();
                return Text(err, style: const TextStyle(color: Colors.red));
              }),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () => Get.to(() => const SignupScreen()),
                    child: const Text('Sign up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
