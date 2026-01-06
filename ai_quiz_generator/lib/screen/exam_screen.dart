import 'package:ai_quiz_generator/controller/ai_controller.dart';
import 'package:ai_quiz_generator/data/models/question_type.dart';
import 'package:ai_quiz_generator/data/models/quiz_question.dart';
import 'package:flutter/material.dart';
import 'package:ai_quiz_generator/widgets/quiz_radio_group.dart';
import 'package:ai_quiz_generator/theme/app_theme.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  AiController aiController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Exam mode',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: bodyContainer()),
            ],
          ),
        ),
      ),
    );
  }

  Widget bodyContainer() {
    final questionType =
        aiController.currentQuiz?.settings.type ?? QuestionType.multipleChoice;

    return Container(
      padding: EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: aiController.questions.length,
        itemBuilder: (context, index) {
          return QuestionCard(
            question: aiController.questions[index],
            type: questionType,
          );
        },
      ),
    );
  }
}

class QuestionCard extends StatefulWidget {
  const QuestionCard({super.key, required this.question, required this.type});

  final Question question;
  final QuestionType type;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String? selectedOption;
  String shortAnswer = '';
  bool? isCorrect;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      color: Colors.white,
      elevation: 4,
      shadowColor: AppTheme.primaryApp.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.question.questionText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryAppExtraLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.question.difficulty,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            if (widget.type == QuestionType.multipleChoice)
              _buildMultipleChoice()
            else
              _buildShortAnswer(),
            if (isCorrect != null) ...[
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(
                    isCorrect == true ? Icons.check_circle : Icons.error,
                    color: isCorrect == true ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    isCorrect == true
                        ? 'Correct'
                        : 'Incorrect (Answer: ${widget.question.correctAnswer})',
                    style: TextStyle(
                      color: isCorrect == true ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Text(
                'Explanation: ${widget.question.explanation}',
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMultipleChoice() {
    if (widget.question.options.isEmpty) {
      return const Text('No options provided by the generator.');
    }
    return QuizRadioGroup(
      options: widget.question.options,
      value: selectedOption,
      onChanged: (val) {
        setState(() {
          selectedOption = val;
          isCorrect = val == widget.question.correctAnswer;
        });
      },
    );
  }

  Widget _buildShortAnswer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Your answer',
            border: OutlineInputBorder(),
          ),
          onChanged: (val) {
            shortAnswer = val;
          },
        ),
        const SizedBox(height: 8.0),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            height: 44,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryApp,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                setState(() {
                  isCorrect =
                      shortAnswer.trim().toLowerCase() ==
                      widget.question.correctAnswer.trim().toLowerCase();
                });
              },
              child: const Text('Check'),
            ),
          ),
        ),
      ],
    );
  }
}
