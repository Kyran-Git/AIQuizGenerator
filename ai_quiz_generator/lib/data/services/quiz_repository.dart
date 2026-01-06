import 'package:ai_quiz_generator/data/models/quiz.dart';

abstract class QuizRepository {
  Future<void> saveQuiz(Quiz quiz);
  Future<List<Quiz>> listQuizzes();
}

/// In-memory placeholder repository.
class InMemoryQuizRepository implements QuizRepository {
  final List<Quiz> _quizzes = [];

  @override
  Future<void> saveQuiz(Quiz quiz) async {
    _quizzes.removeWhere((q) => q.id == quiz.id);
    _quizzes.add(quiz);
  }

  @override
  Future<List<Quiz>> listQuizzes() async {
    return List<Quiz>.unmodifiable(_quizzes);
  }
}
