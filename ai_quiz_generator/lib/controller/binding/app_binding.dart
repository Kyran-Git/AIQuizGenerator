import 'package:get/get.dart';
import 'package:ai_quiz_generator/controller/ai_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AiController>(AiController());
  }
}
