import 'package:ai_quiz_generator/constants/model_constants/quiz_question_constants.dart';

class QuizQuestion {
  String question;
  List<String> options;
  String answer;
  String explanation;
  String difficulty;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.answer,
    required this.explanation,
    required this.difficulty,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      question: json[QuizQuestionConstants.QUESTION],
      answer: json[QuizQuestionConstants.ANSWER],
      options: List<String>.from(json[QuizQuestionConstants.OPTIONS]),
      explanation: json[QuizQuestionConstants.EXPLANATION],
      difficulty: json[QuizQuestionConstants.DIFFICULTY],
    );
  }

  Map<String, dynamic> toJson() {
    return{
      QuizQuestionConstants.QUESTION: question,
      QuizQuestionConstants.ANSWER:  answer,
      QuizQuestionConstants.OPTIONS: options,
      QuizQuestionConstants.EXPLANATION: explanation,
      QuizQuestionConstants.DIFFICULTY: difficulty
    };
  }
}