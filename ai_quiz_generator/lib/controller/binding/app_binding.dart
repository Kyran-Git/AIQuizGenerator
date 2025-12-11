import 'package:ai_quiz_generator/controller/ai_controller.dart';
import 'package:ai_quiz_generator/data/services/gemini_api.dart';
import 'package:ai_quiz_generator/data/services/quiz_generator_service.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GeminiApi>(GeminiApi());
    Get.put<QuizGeneratorService>(
      GeminiQuizGeneratorService(geminiApi: Get.find()),
    );
    Get.put<AiController>(AiController(quizGeneratorService: Get.find()));
  }
}
