import 'package:ai_quiz_generator/controller/ai_controller.dart';
import 'package:ai_quiz_generator/controller/auth_controller.dart';
import 'package:ai_quiz_generator/data/models/difficulty_level.dart';
import 'package:ai_quiz_generator/data/models/question_type.dart';
import 'package:ai_quiz_generator/screen/auth/auth_gate.dart';
import 'package:ai_quiz_generator/theme/app_theme.dart';
import 'package:ai_quiz_generator/widgets/primary_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formkey = GlobalKey<FormState>();
  AiController aiController = Get.find();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFE6F2FF), Colors.white],
              ),
            ),
            child: Column(
              children: [
                _header(),
                Expanded(child: bodyContainer()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyContainer() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _quickStats(),
            const SizedBox(height: 16.0),
            _createQuizCard(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    final name = authController.currentUser.value?.username ?? 'there';
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                const Text(
                  'welcome back',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5C6B7A)),
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Logout',
            onPressed: () async {
              await authController.logout();
              Get.offAll(() => const AuthGate());
            },
            icon: const Icon(Icons.logout, color: Color(0xFF2C3E50)),
          ),
        ],
      ),
    );
  }

  Widget _quickStats() {
    final items = [
      _InfoPill(
        icon: Icons.check_circle,
        title: 'Done',
        subtitle: 'Completed quizzes',
      ),
      _InfoPill(
        icon: Icons.history,
        title: 'History',
        subtitle: 'Past attempts',
      ),
      _InfoPill(
        icon: Icons.analytics_outlined,
        title: 'Analyze',
        subtitle: 'Review scores',
      ),
    ];
    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemBuilder: (_, i) => items[i],
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemCount: items.length,
      ),
    );
  }

  Widget _createQuizCard() {
    return Card(
      color: Colors.white,
      elevation: 6,
      shadowColor: AppTheme.primaryApp.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create Quiz",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: aiController.createQuizExplanation,
              minLines: 4,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: "Explain the topic you want a quiz on...",
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This is Required";
                }
                return null;
              },
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<DifficultyLevel>(
                    initialValue: aiController.selectedDifficulty,
                    decoration: const InputDecoration(labelText: "Difficulty"),
                    items: DifficultyLevel.values
                        .map(
                          (level) => DropdownMenuItem(
                            value: level,
                            child: Text(level.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => aiController.selectedDifficulty = value);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<QuestionType>(
                    initialValue: aiController.selectedType,
                    decoration: const InputDecoration(
                      labelText: "Question Type",
                    ),
                    items: QuestionType.values
                        .map(
                          (type) => DropdownMenuItem(
                            value: type,
                            child: Text(
                              type.name.replaceAll('_', ' ').toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => aiController.selectedType = value);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              initialValue: aiController.numOfQuestions.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Number of Questions",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter a number";
                }
                final parsed = int.tryParse(value);
                if (parsed == null || parsed <= 0) {
                  return "Enter a valid positive number";
                }
                return null;
              },
              onSaved: (value) {
                final parsed = int.tryParse(value ?? '');
                if (parsed != null && parsed > 0) {
                  aiController.numOfQuestions = parsed;
                }
              },
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              child: PrimaryButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    await aiController.createQuiz();
                  }
                },
                text: "Generate Quiz",
                isRounded: true,
                isFullWidth: true,
              ),
            ),
            const SizedBox(height: 8.0),
            Obx(() {
              if (!aiController.isRetrying.value) {
                return const SizedBox.shrink();
              }
              final attempt = aiController.retryAttempt.value;
              return Row(
                children: const [
                  Icon(Icons.autorenew, color: Color(0xFF4169E1)),
                ],
              );
            }),
            Obx(() {
              if (!aiController.isRetrying.value) {
                return const SizedBox.shrink();
              }
              final attempt = aiController.retryAttempt.value;
              return Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  'Retrying… attempt $attempt of 3',
                  style: const TextStyle(color: Color(0xFF4169E1)),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _InfoPill({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: AppTheme.primaryApp,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(icon, color: AppTheme.primaryApp, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(subtitle, style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
