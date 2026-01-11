import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ai_quiz_generator/data/models/quiz.dart';

abstract class PdfService {
  Future<Uint8List> generateQuizPdf(Quiz quiz, {required bool isRevision});
}

class LocalPdfService implements PdfService {
  @override
  Future<Uint8List> generateQuizPdf(Quiz quiz, {required bool isRevision}) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(45),
        build: (pw.Context context) {
          return [
            // TITLE
            pw.Text(quiz.title.toUpperCase(),
                style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blueGrey900)),
            pw.SizedBox(height: 30),

            // QUESTIONS
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

                    if (isRevision)
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 15),
                        child: pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start, // Align to top
                          children: [
                            pw.Text("Correct Answer: ", 
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold, 
                                    fontSize: 11,
                                    color: PdfColors.grey900)),
                            pw.Expanded(
                              child: pw.Text(q.correctAnswer, 
                                  style: const pw.TextStyle(fontSize: 11)),
                            ),
                          ],
                        ),
                      )
                    else
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