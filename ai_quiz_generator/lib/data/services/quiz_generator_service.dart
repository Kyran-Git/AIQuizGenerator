import 'dart:developer';

import 'package:ai_quiz_generator/data/models/difficulty_level.dart';
import 'package:ai_quiz_generator/data/models/question_type.dart';
import 'package:ai_quiz_generator/data/models/quiz_question.dart';
import 'package:ai_quiz_generator/data/models/quiz_settings.dart';
import 'package:ai_quiz_generator/data/services/gemini_api.dart';

abstract class QuizGeneratorService {
  Future<List<Question>> generateQuiz(QuizSettings settings);
}

/// Real implementation using Gemini API with temperature-based difficulty.
class GeminiQuizGeneratorService implements QuizGeneratorService {
  GeminiQuizGeneratorService({required this.geminiApi});

  final GeminiApi geminiApi;

  /// Map difficulty levels to temperature values.
  /// Lower temperature = more deterministic, consistent answers.
  /// Higher temperature = more creative, varied answers.
  double _difficultyToTemperature(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.easy:
        return 0.3; // Low temp: simpler, more straightforward questions
      case DifficultyLevel.medium:
        return 0.7; // Medium temp: balanced
      case DifficultyLevel.hard:
        return 1.5; // High temp: complex, creative, challenging questions
    }
  }

  @override
  Future<List<Question>> generateQuiz(QuizSettings settings) async {
    try {
      log('GeminiQuizGeneratorService :: generateQuiz()');

      final temperature = _difficultyToTemperature(settings.difficulty);
      final prompt = _buildPrompt(settings);

      final response = await geminiApi.sendPrompt(
        prompt,
        temperature: temperature,
      );
      log('Gemini response received');

      final jsonData = await geminiApi.receiveJson(response);
      log('JSON parsed: $jsonData');

      final questionsList = jsonData['questions'] as List<dynamic>? ?? [];
      final questions = questionsList.map((q) => Question.fromJson(q)).toList();

      return questions;
    } catch (e) {
      log('GeminiQuizGeneratorService :: generateQuiz() :: Error: $e');
      rethrow;
    }
  }

  String _buildPrompt(QuizSettings settings) {
    final numQuestions = settings.numOfQuestions;
    final difficulty = settings.difficulty.name;
    final type = settings.type.name;
    final isMcq = settings.type == QuestionType.multipleChoice;

    final requirementBlock = isMcq
        ? '''Each question MUST have:
- 4 distinct answer options
- 1 correct answer (must match exactly one of the options)
- A brief explanation of why the answer is correct
- Difficulty matching the requested level'''
        : '''Each question MUST have:
- No options (leave options as an empty array [])
- 1 correct short answer string
- A brief explanation of why the answer is correct
- Difficulty matching the requested level''';

    final optionsExample = isMcq
        ? '''"options": ["Option A", "Option B", "Option C", "Option D"],
      "correctAnswer": "Option A",'''
        : '''"options": [],
      "correctAnswer": "The short textual answer",''';

    return '''You are a professional educational assessment expert. Generate exactly $numQuestions high-quality questions about the following topic:

Topic: ${settings.sourceText}
Difficulty Level: $difficulty
Question Type: $type

$requirementBlock

For $difficulty difficulty:
- EASY: Simple, straightforward questions testing basic knowledge
- MEDIUM: Intermediate questions requiring understanding and application
- HARD: Complex questions requiring deep analysis and critical thinking

Respond ONLY with valid JSON in this exact format:
{
  "questions": [
    {
      "questionId": "q1",
      "questionText": "Question text here?",
      $optionsExample
      "difficulty": "$difficulty",
      "explanation": "Why this answer is correct."
    }
  ]
}

Generate the JSON now:''';
  }
}

/// Temporary mock implementation for testing.
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
