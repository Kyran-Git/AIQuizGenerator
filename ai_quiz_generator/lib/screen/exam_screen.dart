import 'package:ai_quiz_generator/controller/ai_controller.dart';
import 'package:ai_quiz_generator/data/models/question_type.dart';
import 'package:ai_quiz_generator/data/models/quiz_question.dart';
import 'package:flutter/material.dart';
import 'package:ai_quiz_generator/widgets/quiz_radio_group.dart';
import 'package:ai_quiz_generator/theme/app_theme.dart';
import 'package:get/get.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final AiController aiController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exam Mode',
          style: TextStyle(color: Color(0xFF2C3E50), fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFFE6F2FF),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2C3E50)),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFE6F2FF), Colors.white],
            ),
          ),
          child: bodyContainer(),
        ),
      ),
    );
  }

  Widget bodyContainer() {
    final questionType = aiController.currentQuiz?.settings.type ?? QuestionType.multipleChoice;

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: aiController.questions.length + 1,
      itemBuilder: (context, index) {
        if (index == aiController.questions.length) {
          return _buildFinishButton();
        }

        return QuestionCard(
          key: ValueKey(aiController.questions[index].id),
          question: aiController.questions[index],
          type: questionType,
          index: index,
          onChanged: () => setState(() {}),
        );
      },
    );
  }

  Widget _buildFinishButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryApp,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () async {
            await aiController.saveCurrentQuiz();
            Get.back();
          },
          child: const Text("Finish & Save Quiz",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    super.key,
    required this.question,
    required this.type,
    required this.index,
    required this.onChanged,
  });

  final Question question;
  final QuestionType type;
  final int index;
  final VoidCallback onChanged;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final AiController aiController = Get.find();

  // Quiz State
  String? selectedOption;
  String shortAnswer = '';
  bool? isCorrect;
  bool answered = false;

  // Edit Mode State
  bool isEditing = false;
  late TextEditingController _qController;
  late TextEditingController _ansController;
  late List<TextEditingController> _optionControllers;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _qController = TextEditingController(text: widget.question.questionText);
    _ansController = TextEditingController(text: widget.question.correctAnswer);
    _optionControllers = widget.question.options
        .map((opt) => TextEditingController(text: opt))
        .toList();
  }

  void _saveChanges() {
    final updatedOptions = _optionControllers.map((c) => c.text).toList();
    
    aiController.updateQuestion(
      widget.index,
      text: _qController.text,
      answer: _ansController.text,
      options: updatedOptions,
    );
    
    setState(() => isEditing = false);
    widget.onChanged(); // Refresh the list view
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 12.0),
            if (isEditing) _buildEditForm() else _buildQuizView(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: isEditing
              ? TextField(
                  controller: _qController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: "Question",
                    border: OutlineInputBorder(),
                  ),
                )
              : Text(
                  widget.question.questionText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),
        ),
        const SizedBox(width: 8),
        if (!isEditing)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.primaryAppExtraLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.question.difficulty,
              style: const TextStyle(fontSize: 12, color: Color(0xFF2C3E50)),
            ),
          ),
        IconButton(
          icon: Icon(
            isEditing ? Icons.check_circle : Icons.edit,
            color: isEditing ? Colors.green : AppTheme.primaryApp,
          ),
          onPressed: isEditing ? _saveChanges : () => setState(() => isEditing = true),
        ),
      ],
    );
  }

  Widget _buildEditForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.type == QuestionType.multipleChoice) ...[
          const Text("Options:", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ..._optionControllers.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: entry.value,
                decoration: InputDecoration(
                  labelText: "Option ${entry.key + 1}",
                  border: const OutlineInputBorder(),
                ),
              ),
            );
          }),
        ],
        const SizedBox(height: 8),
        TextField(
          controller: _ansController,
          decoration: const InputDecoration(
            labelText: "Correct Answer (Must match an option exactly)",
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildQuizView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.type == QuestionType.multipleChoice ? _buildMCQ() : _buildSA(),
        if (isCorrect != null) _buildFeedback(),
      ],
    );
  }

  Widget _buildMCQ() {
    return QuizRadioGroup(
      options: widget.question.options,
      value: selectedOption,
      onChanged: (val) {
        if (answered) return;
        setState(() {
          selectedOption = val;
          isCorrect = val == widget.question.correctAnswer;
          answered = true;
        });
      },
    );
  }

  Widget _buildSA() {
    return Column(
      children: [
        TextField(
          enabled: !answered,
          decoration: const InputDecoration(labelText: 'Your answer', border: OutlineInputBorder()),
          onChanged: (val) => shortAnswer = val,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: answered ? null : () => setState(() {
              isCorrect = shortAnswer.trim().toLowerCase() == widget.question.correctAnswer.trim().toLowerCase();
              answered = true;
            }),
            child: const Text("Check"),
          ),
        ),
      ],
    );
  }

  Widget _buildFeedback() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCorrect! ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isCorrect! ? "Correct!" : "Incorrect (Answer: ${widget.question.correctAnswer})",
            style: TextStyle(fontWeight: FontWeight.bold, color: isCorrect! ? Colors.green : Colors.red),
          ),
          const SizedBox(height: 4),
          Text("Explanation: ${widget.question.explanation}", style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _qController.dispose();
    _ansController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}