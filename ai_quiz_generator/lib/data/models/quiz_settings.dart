import 'difficulty_level.dart';
import 'question_type.dart';

class QuizSettings {
  final String sourceText;
  final int numOfQuestions;
  final DifficultyLevel difficulty;
  final QuestionType type;

  QuizSettings({
    required this.sourceText,
    required this.numOfQuestions,
    required this.difficulty,
    required this.type,
  });

  factory QuizSettings.defaultFromText(String text) {
    return QuizSettings(
      sourceText: text,
      numOfQuestions: 5,
      difficulty: DifficultyLevel.medium,
      type: QuestionType.multipleChoice,
    );
  }

  factory QuizSettings.fromJson(Map<String, dynamic> json) {
    return QuizSettings(
      sourceText: json['sourceText'] ?? '',
      numOfQuestions: json['numOfQuestions'] ?? 0,
      difficulty: DifficultyLevelMapper.fromString(
        json['difficulty'] as String?,
      ),
      type: QuestionTypeMapper.fromString(json['type'] as String?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sourceText': sourceText,
      'numOfQuestions': numOfQuestions,
      'difficulty': difficulty.value,
      'type': type.value,
    };
  }
}
