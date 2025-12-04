import 'package:flutter/material.dart';
import 'package:ai_quiz_generator/widgets/primary_buttons.dart';
import 'package:get/get.dart';
import 'package:ai_quiz_generator/controller/ai_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formkey = GlobalKey<FormState>();
  AiController aiController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Home")),
        body: bodyContainer(),
      ),
    );
  }

  Widget bodyContainer() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text(
                        "Create Quiz for",
                        style: TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: aiController.createQuizExplanation,
                      minLines: 4,
                      maxLines: 6,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20.0),
                        border: InputBorder.none,
                        hintText:
                            "Explain here the topic you want a quiz on...",
                        hintStyle: TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This is Required";
                        }
                        return null; //valid
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: PrimaryButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      await aiController.createQuiz();
                    }
                  },
                  text: "GENERATE QUIZ",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
