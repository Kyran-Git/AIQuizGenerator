import 'package:ai_quiz_generator/controller/ai_controller.dart';
import 'package:ai_quiz_generator/controller/auth_controller.dart';
import 'package:ai_quiz_generator/data/models/difficulty_level.dart';
import 'package:ai_quiz_generator/data/models/question_type.dart';
import 'package:ai_quiz_generator/screen/auth/auth_gate.dart';
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
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
              onPressed: () async {
                await authController.logout();
                Get.offAll(() => const AuthGate());
              },
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
            ),
          ],
        ),
        body: bodyContainer(),
      ),
    );
  }

  Widget bodyContainer() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text(
                        "Create Quiz for",
                        style: TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: aiController.createQuizExplanation,
                      minLines: 4,
                      maxLines: 6,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20.0),
                        border: InputBorder.none,
                        hintText:
                            "Explain here the topic you want a quiz on...",
                        hintStyle: TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This is Required";
                        }
                        return null; //valid
                      },
                    ),
                    const SizedBox(height: 12.0),
                    DropdownButtonFormField<DifficultyLevel>(
                      value: aiController.selectedDifficulty,
                      decoration: const InputDecoration(
                        labelText: "Difficulty",
                      ),
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
                          setState(() {
                            aiController.selectedDifficulty = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12.0),
                    DropdownButtonFormField<QuestionType>(
                      value: aiController.selectedType,
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
                          setState(() {
                            aiController.selectedType = value;
                          });
                        }
                      },
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
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
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
                  text: "GENERATE QUIZ",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
