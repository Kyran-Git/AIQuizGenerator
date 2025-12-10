import 'dart:developer';

import 'package:ai_quiz_generator/data/models/quiz.dart';
import 'package:ai_quiz_generator/data/models/quiz_question.dart';
import 'package:ai_quiz_generator/data/models/quiz_settings.dart';
import 'package:ai_quiz_generator/data/models/difficulty_level.dart';
import 'package:ai_quiz_generator/data/models/question_type.dart';
import 'package:ai_quiz_generator/data/services/quiz_generator_service.dart';
import 'package:ai_quiz_generator/screen/exam_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AiController extends GetxController {
  AiController({required this.quizGeneratorService});

  final QuizGeneratorService quizGeneratorService;

  final TextEditingController createQuizExplanation = TextEditingController();
  DifficultyLevel selectedDifficulty = DifficultyLevel.medium;
  QuestionType selectedType = QuestionType.multipleChoice;
  int numOfQuestions = 5;
  Quiz? currentQuiz;
  List<Question> questions = [];

  Future<void> createQuiz() async {
    try {
      log('AiController :: createQuiz()');
      final settings = QuizSettings(
        sourceText: createQuizExplanation.text.trim(),
        numOfQuestions: numOfQuestions,
        difficulty: selectedDifficulty,
        type: selectedType,
      );
      final generatedQuestions = await quizGeneratorService.generateQuiz(
        settings,
      );

      currentQuiz = Quiz(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: settings.sourceText.isEmpty
            ? 'Untitled Quiz'
            : settings.sourceText,
        questions: generatedQuestions,
        settings: settings,
      );

      questions = generatedQuestions;
      Get.to(() => const ExamScreen());
    } catch (e) {
      log('AiController :: createQuiz() :: Error:$e');
    }
  }

  String generatePrompt(QuizSettings settings) {
    return '''
You are a professional test agency that specializes in generating high-quality multiple-choice questions (MCQs). Given a topic, create a JSON-formatted output containing a list of MCQs. Each question must include four answer choices, one correct answer, and an explanation.

Vary difficulty (easy, medium, hard) and keep questions clear, concise, and relevant to: ${settings.sourceText}.

Output Format (JSON):
{
  "questions": [{
    "questionId": "<id>",
    "questionText": "<MCQ question text>",
    "options": ["option A", "option B", "option C", "option D"],
    "correctAnswer": "<correct option>",
    "difficulty": "<easy | medium | hard>",
    "explanation": "<brief explanation>"
  }]
}
''';
  }
}
