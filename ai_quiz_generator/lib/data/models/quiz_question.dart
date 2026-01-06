import 'package:ai_quiz_generator/constants/model_constants/quiz_question_constants.dart';

/// Domain model representing a single quiz question.
class Question {
  final String id;
  final String questionText;
  final List<String> options;
  final String correctAnswer;
  final String explanation;
  final String difficulty; // use DifficultyLevel enum string value

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.difficulty,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json[QuizQuestionConstants.QUESTION_ID] ?? '',
      questionText: json[QuizQuestionConstants.QUESTION_TEXT] ?? '',
      options: List<String>.from(
        json[QuizQuestionConstants.OPTIONS] ?? const [],
      ),
      correctAnswer: json[QuizQuestionConstants.CORRECT_ANSWER] ?? '',
      explanation: json[QuizQuestionConstants.EXPLANATION] ?? '',
      difficulty: json[QuizQuestionConstants.DIFFICULTY] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      QuizQuestionConstants.QUESTION_ID: id,
      QuizQuestionConstants.QUESTION_TEXT: questionText,
      QuizQuestionConstants.OPTIONS: options,
      QuizQuestionConstants.CORRECT_ANSWER: correctAnswer,
      QuizQuestionConstants.EXPLANATION: explanation,
      QuizQuestionConstants.DIFFICULTY: difficulty,
    };
  }
}
