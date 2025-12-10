import 'package:ai_quiz_generator/data/models/quiz_question.dart';
import 'package:ai_quiz_generator/data/models/quiz_settings.dart';

abstract class QuizGeneratorService {
  Future<List<Question>> generateQuiz(QuizSettings settings);
}

/// Temporary mock implementation that returns a single sample question.
class MockQuizGeneratorService implements QuizGeneratorService {
  @override
  Future<List<Question>> generateQuiz(QuizSettings settings) async {
    return [
      Question(
        id: 'q1',
        questionText: 'Sample question based on ${settings.sourceText}?',
        options: const ['A', 'B', 'C', 'D'],
        correctAnswer: 'A',
        explanation: 'Placeholder explanation.',
        difficulty: settings.difficulty.name,
      ),
    ];
  }
}
