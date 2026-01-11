import 'dart:developer';

import 'package:ai_quiz_generator/data/models/quiz.dart';
import 'package:ai_quiz_generator/data/models/quiz_question.dart';
import 'package:ai_quiz_generator/data/models/quiz_settings.dart';
import 'package:ai_quiz_generator/data/models/difficulty_level.dart';
import 'package:ai_quiz_generator/data/models/question_type.dart';
import 'package:ai_quiz_generator/data/models/user.dart';
import 'package:ai_quiz_generator/data/services/quiz_generator_service.dart';
import 'package:ai_quiz_generator/screen/exam_screen.dart';
import 'package:ai_quiz_generator/controller/auth_controller.dart';
import 'package:ai_quiz_generator/data/services/quiz_repository.dart';
import 'package:ai_quiz_generator/data/services/quiz_repository_remote.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AiController extends GetxController {
  AiController({required this.quizGeneratorService});
  // 1. Inject AuthController
  final AuthController _authController = Get.find();
  
  // 2. Inject Repository
  final QuizRepository quizRepo = QuizRepositoryRemote(); 

  // Library State
  var myLibrary = <Quiz>[].obs;
  var isLoadingLibrary = false.obs;

  final QuizGeneratorService quizGeneratorService;

  final TextEditingController createQuizExplanation = TextEditingController();
  DifficultyLevel selectedDifficulty = DifficultyLevel.medium;
  QuestionType selectedType = QuestionType.multipleChoice;
  int numOfQuestions = 5;
  Quiz? currentQuiz;
  List<Question> questions = [];

  // Retry status for Gemini backoff
  final RxBool isRetrying = false.obs;
  final RxInt retryAttempt = 0.obs; // 1..N
  final RxBool isGenerating = false.obs;

  Future<void> createQuiz() async {
    try {
      isGenerating.value = true;
      log('AiController :: createQuiz()');

      //get auth controllers
      final currentUser = _authController.currentUser.value;

      final settings = QuizSettings(
        sourceText: createQuizExplanation.text.trim(),
        numOfQuestions: numOfQuestions,
        difficulty: selectedDifficulty,
        type: selectedType,
      );
      final generatedQuestions = await quizGeneratorService.generateQuiz(
        settings,
        onRetry: (attempt, error) {
          isRetrying.value = true;
          retryAttempt.value = attempt;
        },
      );

      // 3. Handle Guest ID safely
      // If currentUser is null, use '' (Guest). 
      // This is safe because we are just storing it in RAM for now.
      String safeUserId = currentUser?.userId ?? '';

      currentQuiz = Quiz(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: settings.sourceText.isEmpty
            ? 'Untitled Quiz'
            : settings.sourceText,
        questions: generatedQuestions,
        settings: settings,
        userId: safeUserId,
      );

      questions = generatedQuestions;
      Get.to(() => const ExamScreen());
      isRetrying.value = false;
      retryAttempt.value = 0;
    } catch (e) {
      log('AiController :: createQuiz() :: Error:$e');
      Get.snackbar("Error", "Failed to generate quiz. Please try again.");
      isRetrying.value = false;
    } finally {
      isGenerating.value = false;
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

  Future<void> loadLibrary() async {
    isLoadingLibrary.value = true;
    try {
      final currentUser = _authController.currentUser.value;

      // 4. Handle Guest ID safely
      String safeUserId = currentUser?.userId ?? '';
      if (safeUserId.isEmpty) {
        myLibrary.clear();
        isLoadingLibrary.value = false;
        return;
      } // Don't load for guests

      final quizzes = await quizRepo.listQuizzes(safeUserId);
      myLibrary.value = quizzes;
    } catch (e) {
      log('AiController :: loadLibrary() :: Error:$e');
      Get.snackbar("Error", "Failed to load library.");
    } finally {
      isLoadingLibrary.value = false;
    }
  }

  Future<void> saveCurrentQuiz() async {
    if (currentQuiz == null) return;
    if (_authController.currentUser.value == null) {
      Get.snackbar("Error", "You must be logged in to save quizzes.");
      return;
    }
    try {
      await quizRepo.saveQuiz(currentQuiz!);
      myLibrary.add(currentQuiz!);
      log('AiController :: saveCurrentQuiz() :: Quiz saved successfully.');
    } catch (e) {
      log('AiController :: saveCurrentQuiz() :: Error:$e');
      Get.snackbar("Error", "Failed to save quiz.");
    }
  }

  void retryQuiz(Quiz quiz) {
    String newQuizId = DateTime.now().millisecondsSinceEpoch.toString();
    // 1. Create a deep copy of questions with 'userAnswer' wiped to null.
    final List<Question> cleanQuestions = quiz.questions.asMap().entries.map((entry) {
      int index = entry.key;
      Question q = entry.value;

      return Question(
        id: "${newQuizId}_$index", 
        questionText: q.questionText,
        options: List<String>.from(q.options),
        correctAnswer: q.correctAnswer,
        difficulty: q.difficulty,
        explanation: q.explanation,
      );
    }).toList();

    // 3. Create the NEW Quiz Object
    Quiz newQuizAttempt = Quiz(
      id: newQuizId,
      userId: quiz.userId,    
      settings: quiz.settings,
      questions: cleanQuestions,
      title: quiz.title,
    );

    // 2. Set as the current active quiz
    currentQuiz = newQuizAttempt;
    questions = cleanQuestions; // Use the clean list

    // 3. Navigate to Exam
    Get.to(() => const ExamScreen());
  }
}