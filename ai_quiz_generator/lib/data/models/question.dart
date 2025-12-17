import 'dart:convert';

class Question {
  final String id;
  final String quizId;
  final String questionText;
  final String correctAnswer;
  final String? explanation;
  final String difficulty;
  final List<String> options;

  Question({
    required this.id,
    required this.quizId,
    required this.questionText,
    required this.correctAnswer,
    this.explanation,
    required this.difficulty,
    required this.options,
  });

  // Convert JSON from Database/API into a Question object
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      quizId: json['quizId'],
      questionText: json['questionText'],
      correctAnswer: json['correctAnswer'],
      explanation: json['explanation'],
      difficulty: json['difficulty'],
      // Handle options: SQL stores them as a JSON string, API might send them as a List
      options: json['options'] is String
          ? List<String>.from(jsonDecode(json['options']))
          : List<String>.from(json['options']),
    );
  }

  // Convert Question object to JSON (for sending to API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quizId': quizId,
      'questionText': questionText,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'difficulty': difficulty,
      'options': options,
    };
  }
}