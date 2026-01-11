import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ai_quiz_generator/data/models/quiz.dart';

class PdfPreviewScreen extends StatelessWidget {
  final Quiz quiz;

  const PdfPreviewScreen({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    const darkGrey = Color(0xFF2C3E50);
    const lightBlue = Color(0xFFE6F2FF);

    return Scaffold(
      backgroundColor: darkGrey,
      appBar: AppBar(
        title: Text(
          quiz.title,
          style: const TextStyle(
            color: darkGrey,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: lightBlue,
        iconTheme: const IconThemeData(color: darkGrey),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Color(0xFF4169E1)),
            onPressed: () async {
              final pdfData = await _generatePdf(PdfPageFormat.a4, quiz);
              // Open the system Print/Save dialog
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
          // This Container provides the dark background color you want
          color: darkGrey,
          child: PdfPreview(
            build: (format) => _generatePdf(format, quiz),
            initialPageFormat: PdfPageFormat.a4,
            canChangePageFormat: false,
            canChangeOrientation: false,
            allowPrinting: false,
            allowSharing: false,
            canDebug: false,
            actions: const [],
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
            maxPageWidth: MediaQuery.of(context).size.width * 0.6,
            pdfPreviewPageDecoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, Quiz quiz) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(45),
        build: (pw.Context context) {
          return [
            // TOPIC
            pw.Text(quiz.title.toUpperCase(),
                style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blueGrey900)),
            pw.SizedBox(height: 30),

            // QUESTIONS & ANSWERS (A, B, C, D)
            ...quiz.questions.asMap().entries.map((entry) {
              final qIndex = entry.key;
              final q = entry.value;

              return pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 25),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("${qIndex + 1}. ${q.questionText}",
                        style: pw.TextStyle(
                            fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 10),
                    ...q.options.asMap().entries.map((optEntry) {
                      final label = String.fromCharCode(65 + optEntry.key);
                      return pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 15, bottom: 4),
                        child: pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(
                                width: 20,
                                child: pw.Text("$label.",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 11))),
                            pw.Expanded(
                                child: pw.Text(optEntry.value.toString(),
                                    style: const pw.TextStyle(fontSize: 11))),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            }).toList(),
          ];
        },
      ),
    );

    return pdf.save();
  }
}