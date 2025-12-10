import 'package:ai_quiz_generator/data/models/quiz.dart';

abstract class PdfService {
  Future<void> generatePdf(Quiz quiz);
  Future<void> downloadPdf(String quizId);
}

/// Placeholder PDF service to be implemented later.
class StubPdfService implements PdfService {
  @override
  Future<void> downloadPdf(String quizId) async {
    // no-op stub
  }

  @override
  Future<void> generatePdf(Quiz quiz) async {
    // no-op stub
  }
}
