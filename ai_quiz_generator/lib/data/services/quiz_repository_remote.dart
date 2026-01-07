import 'package:ai_quiz_generator/data/models/quiz.dart';
import 'package:ai_quiz_generator/data/models/quiz_question.dart';
import 'package:ai_quiz_generator/data/models/quiz_settings.dart';
import 'package:ai_quiz_generator/data/services/api_client.dart';
import 'package:ai_quiz_generator/data/services/quiz_repository.dart';
import 'package:uuid/uuid.dart';

class QuizRepositoryRemote implements QuizRepository {
  
  @override
  Future<void> saveQuiz(Quiz quiz) async {
    // 1. Prepare the data (Map Flutter object to JSON)
    final body = {
      "id": quiz.id,
      "userId": quiz.userId,
      "title": quiz.title,
      "settings": quiz.settings.toJson(),
      "questions": quiz.questions.map((q) {
        String safeId = q.id;
        if (safeId.length < 5 || !safeId.contains('-')) {
             safeId = const Uuid().v4(); 
        }

        return {
          "id": safeId, // <--- NEW: Send safe UUID
          "questionText": q.questionText,
          "correctAnswer": q.correctAnswer,
          "options": q.options,
          "difficulty": q.difficulty,
          "explanation": q.explanation ?? ""
        };
      }).toList(),
    };

    // 2. Send it to Python
    await ApiClient.post('/quizzes/save', body: body);
  }

  @override
  Future<List<Quiz>> listQuizzes(String userId) async {
    // 1. Ask Python for the list
    final List<dynamic> response = await ApiClient.get('/quizzes/list/$userId');

    // 2. Convert raw JSON back into Flutter Quiz objects
    return response.map((json) {
      QuizSettings parsedSettings = QuizSettings.fromJson(json['settings'] ?? {});
      
      // Handle the nested questions list
      var qList = json['questions'] as List;
      List<Question> parsedQuestions = qList.map((qJson) {
        return Question(
          id: qJson['id'],
          questionText: qJson['questionText'],
          options: List<String>.from(qJson['options']),
          correctAnswer: qJson['correctAnswer'],
          explanation: qJson['explanation'],
          difficulty: qJson['difficulty'],
        );
      }).toList();

      return Quiz(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        questions: parsedQuestions,
        settings: parsedSettings,
      );
    }).toList();
  }
}