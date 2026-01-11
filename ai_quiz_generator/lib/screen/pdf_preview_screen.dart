import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:ai_quiz_generator/data/models/quiz.dart';
import 'package:ai_quiz_generator/data/services/pdf_service.dart';

class PdfPreviewScreen extends StatelessWidget {
  final Quiz quiz;
  final bool isRevisionMode;
  // Initialize your service logic
  final PdfService pdfService = LocalPdfService();

  PdfPreviewScreen({
    super.key,
    required this.quiz,
    this.isRevisionMode = false,
  });

  @override
  Widget build(BuildContext context) {
    const darkGrey = Color(0xFF2C3E50);
    const lightBlue = Color(0xFFE6F2FF);

    return Scaffold(
      backgroundColor: darkGrey,
      appBar: AppBar(
        title: Text(
          quiz.title,
          style: const TextStyle(color: darkGrey, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: lightBlue,
        iconTheme: const IconThemeData(color: darkGrey),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Color(0xFF4169E1)),
            onPressed: () async {
              final pdfData = await pdfService.generateQuizPdf(quiz, isRevision: isRevisionMode);
              await Printing.layoutPdf(
                onLayout: (PdfPageFormat format) async => pdfData,
                name: quiz.title,
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: WidgetStateProperty.all(Colors.transparent),
            trackColor: WidgetStateProperty.all(Colors.transparent),
            thickness: WidgetStateProperty.all(0),
          ),
        ),
        child: Container(
          color: darkGrey,
          child: PdfPreview(
            // Logic is called from the service
            build: (format) => pdfService.generateQuizPdf(quiz, isRevision: isRevisionMode),
            initialPageFormat: PdfPageFormat.a4,
            canChangePageFormat: false,
            canChangeOrientation: false,
            allowPrinting: false,
            allowSharing: false,
            canDebug: false,
            actions: const [], // Hides the extra icons/buttons you didn't like
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
            maxPageWidth: MediaQuery.of(context).size.width * 0.6,
            pdfPreviewPageDecoration: const BoxDecoration(color: Colors.white),
          ),
        ),
      ),
    );
  }
}