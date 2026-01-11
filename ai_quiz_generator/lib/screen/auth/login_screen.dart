import 'package:ai_quiz_generator/controller/auth_controller.dart';
import 'package:ai_quiz_generator/screen/auth/signup_screen.dart';
import 'package:ai_quiz_generator/screen/auth/auth_gate.dart';
import 'package:ai_quiz_generator/theme/app_theme.dart';
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
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    authController = Get.find<AuthController>();
  }

  void _submitLogin() async {
    if (_formKey.currentState!.validate()) {
      final success = await authController.login(
        _usernameController.text.trim(),
        _passwordController.text.trim(),
      );
      if (success) {
        Get.offAll(() => const AuthGate());
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE6F2FF), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Column(
                  children: [
                    const SizedBox(height: 12.0),
                    Text(
                      'welcome back !',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3E50),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'Please verify your identity to proceed',
                      style: TextStyle(color: Color(0xFF5C6B7A)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),
                    Card(
                      color: Colors.white,
                      elevation: 6,
                      shadowColor: AppTheme.primaryApp.withValues(alpha: 0.15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // USERNAME FIELD
                              TextFormField(
                                controller: _usernameController,
                                focusNode: _usernameFocus,
                                decoration: const InputDecoration(
                                  labelText: 'Email or Username',
                                  prefixIcon: Icon(Icons.person_outline),
                                ),
                                validator: (val) => (val == null || val.isEmpty)
                                    ? 'Username is required'
                                    : null,
                                onFieldSubmitted: (_){
                                  FocusScope.of(context).requestFocus(_passwordFocus);
                                },
                              ),
                              const SizedBox(height: 12.0),
                              // PASSWORD FIELD
                              TextFormField(
                                controller: _passwordController,
                                focusNode: _passwordFocus,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock_outline),
                                ),
                                obscureText: true,
                                validator: (val) => (val == null || val.isEmpty)
                                    ? 'Password is required'
                                    : null,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) => _submitLogin(),
                              ),
                              const SizedBox(height: 8.0),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text('Forgot your password?'),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Obx(() {
                                final loading = authController.isLoading.value;
                                return SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: PrimaryButton(
                                    onPressed: authController.isLoading.value
                                        ? null
                                        : _submitLogin,
                                    text: authController.isLoading.value ? 'Logging in...' : 'Login',
                                    isRounded: true,
                                    isFullWidth: true,
                                  ),
                                );
                              }),
                              const SizedBox(height: 8.0),
                              Obx(() {
                                final err = authController.error.value;
                                if (err == null) return const SizedBox.shrink();
                                return Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Text(
                                    err,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
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
                    const SizedBox(height: 12.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
