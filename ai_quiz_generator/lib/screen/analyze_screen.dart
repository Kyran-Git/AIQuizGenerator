import 'package:ai_quiz_generator/controller/ai_controller.dart';
import 'package:ai_quiz_generator/data/models/quiz_question.dart';
import 'package:ai_quiz_generator/data/models/quiz.dart'; 
import 'package:ai_quiz_generator/theme/app_theme.dart';
import 'package:ai_quiz_generator/screen/pdf_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnalyzeScreen extends StatelessWidget {
  const AnalyzeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AiController controller = Get.find();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Study & Review",
          style: TextStyle(color: Color(0xFF2C3E50), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2C3E50)),
      ),
      // Use Obx here to listen to changes in the library
      body: Obx(() {
        if (controller.myLibrary.isEmpty) {
          return _buildEmptyState();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.myLibrary.length,
          itemBuilder: (context, index) {
            final quiz = controller.myLibrary[index];
            final topic = quiz.title.isNotEmpty ? quiz.title : "General Review";
            return _TopicCard(topic: topic, quiz: quiz);
          },
        );
      }),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu_book_rounded, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            "No quizzes to study yet.",
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  final String topic;
  final dynamic quiz; // Using dynamic here avoids the import error if the class name is slightly different

  const _TopicCard({required this.topic, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        shape: const Border(),
        leading: CircleAvatar(
          backgroundColor: AppTheme.primaryApp.withOpacity(0.1),
          child: Icon(Icons.bookmark, color: AppTheme.primaryApp, size: 20),
        ),
        title: Text(
          topic,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text("${quiz.questions.length} Questions"),
        trailing: IconButton(
          tooltip: 'Download PDF',
          icon: const Icon(Icons.download_rounded, color: Color(0xFF4169E1)),
          onPressed: () {
            Get.to(() => PdfPreviewScreen(quiz: quiz, isRevisionMode: true));
          },
        ),
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: quiz.questions.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final q = quiz.questions[index];
              return Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      q.questionText,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check_circle, size: 14, color: Colors.green),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              q.correctAnswer,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}