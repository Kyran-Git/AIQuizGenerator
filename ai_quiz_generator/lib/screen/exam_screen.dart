import 'package:ai_quiz_generator/controller/ai_controller.dart';
import 'package:ai_quiz_generator/data/models/quiz_question.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  AiController aiController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exam mode"),
      ),
      body: bodyContainer(),
    );
  }

  Widget bodyContainer(){
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: aiController.questions.length,
            itemBuilder: (context, index){
              return questionTile(question: aiController.questions[index]);
          })
        ],
      ),
    );
  }

  Widget questionTile({required QuizQuestion question}){
    return ListTile(
      title: Text(question.question),
      trailing: Text(question.difficulty),
    );
  }
}