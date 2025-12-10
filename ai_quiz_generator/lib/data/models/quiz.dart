import 'package:ai_quiz_generator/data/models/quiz_settings.dart';
import 'package:ai_quiz_generator/data/models/quiz_question.dart';

class Quiz {
  final String id;
  final String title;
  final List<Question> questions;
  final QuizSettings settings;

  Quiz({
    required this.id,
    required this.title,
    required this.questions,
    required this.settings,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['quizId'] ?? '',
      title: json['title'] ?? '',
      settings: QuizSettings.fromJson(json['settings'] ?? <String, dynamic>{}),
      questions: (json['questions'] as List<dynamic>? ?? const [])
          .map((q) => Question.fromJson(q))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quizId': id,
      'title': title,
      'settings': settings.toJson(),
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}
