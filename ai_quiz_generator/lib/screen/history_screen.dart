import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_quiz_generator/controller/ai_controller.dart';
// import 'package:ai_quiz_generator/screen/exam_screen.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final AiController controller = Get.find();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadLibrary();
    });

    return Scaffold(
      // Add a background color so it doesn't look transparent during transition
      backgroundColor: const Color(0xFFF5F7FA), 
      
      // Add AppBar so the "Back Arrow" appears automatically
      appBar: AppBar(
        title: const Text(
          "Quiz History",
          style: TextStyle(color: Color(0xFF2C3E50), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2C3E50)), // Dark back arrow
      ),
      
      body: Obx(() {
        if (controller.isLoadingLibrary.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.myLibrary.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history_toggle_off, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  "No history yet",
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.loadLibrary(),
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.myLibrary.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final quiz = controller.myLibrary[index];
              return Card(
                elevation: 2, // Slightly lower elevation for a cleaner look
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: const Color(0xFFE6F2FF),
                    child: Text(
                      quiz.title.isNotEmpty ? quiz.title[0].toUpperCase() : '?',
                      style: const TextStyle(
                        color: Color(0xFF2C3E50), 
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  title: Text(
                    quiz.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text("${quiz.questions.length} Questions • ${quiz.settings.difficulty}"),
                  ),
                  onTap: () {
                    // Navigate to details
                    // controller.currentQuiz = quiz;
                    // Get.to(() => const ExamScreen());
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }
}