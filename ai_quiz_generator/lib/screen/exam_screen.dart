import 'package:ai_quiz_generator/controller/ai_controller.dart';
import 'package:ai_quiz_generator/data/models/question_type.dart';
import 'package:ai_quiz_generator/data/models/quiz_question.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(title: Text("Exam mode")),
      body: bodyContainer(),
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
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
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
                    ),
                  ),
                ),
                Text(
                  widget.question.difficulty,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
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
    return Column(
      children: widget.question.options.map((option) {
        return RadioListTile<String>(
          value: option,
          groupValue: selectedOption,
          onChanged: (val) {
            setState(() {
              selectedOption = val;
              isCorrect = val == widget.question.correctAnswer;
            });
          },
          title: Text(option),
        );
      }).toList(),
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
          child: ElevatedButton(
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
      ],
    );
  }
}
