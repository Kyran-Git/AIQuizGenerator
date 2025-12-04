import 'package:ai_quiz_generator/data/models/quiz_question.dart';
import 'package:ai_quiz_generator/screen/exam_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ai_quiz_generator/constants/gemini_constants.dart';

import 'dart:convert';
import 'dart:developer';

class AiController extends GetxController {
  TextEditingController createQuizExplanation = TextEditingController();
  List<QuizQuestion> questions = [];

  String demoquestions = "Hello";

  Future createQuiz() async {
    // AI quiz creation logic here
    try {
      log("AiController :: createQuiz()");
      /*final model = GenerativeModel(
        model: 'gemini-2.5-flash',
        apiKey: GeminiConstants.API_KEY,
    );

    final prompt = generatePrompt();
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    String? responseText = response.text;*/

    String responseText = demoquestions;
    if(responseText != null){
      responseText = responseText.trim();
      responseText = responseText.trim().substring(7, responseText.length - 3).trim();
      Map<String, dynamic> map = jsonDecode(responseText);
      questions = (map["questions"] as List<dynamic>).map((q){
        return QuizQuestion.fromJson(q);
      }).toList();
      Get.to(() => ExamScreen());
    }
    } catch (e) {
      log("AiController :: createQuiz() :: Error:$e");
    }
  }

  String generatePrompt(){
    return '''
        You are a professional test agency that specialize in generating high-quality multiple-choice question (MCQs). Given a topic by the user, you will create a JSON-formatted output containing a list of MCQs. Each question should include four answer choice, one correct answer, and an explanation.

        Generate question that vary in difficulty (easy, medium and hard). Ensure they are clear, concise, and relevant to the given topic.

        Output Format (JSON):
        {
          "question":[{
            "question": "<MCQ question text>",
            "options": ["option A", "option B", "option C", "option D"],
            "correct_amswer": "<correct option>",
            "difficulty": "<easy | medium | hard>",
          },
          ...
          ]
        }
        Now, generate MCQs for the topic: '${createQuizExplanation.text.trim()}'."
      ''';
  }
}
