import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(const PdfExporterApp());
}

class PdfExporterApp extends StatelessWidget {
  const PdfExporterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PdfScreen(),
    );
  }
}

class PdfScreen extends StatelessWidget {
  PdfScreen({super.key});

  final GlobalKey _pdfKey = GlobalKey();

  void generatedCenteredText() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final pdf = pw.Document();

      final image = await WidgetWrapper.fromKey(key: _pdfKey);

      pdf.addPage(
        pw.Page(
          build: (context) {
            return pw.Center(child: pw.Image(image));
          },
        ),
      );

      return pdf.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RepaintBoundary(
            key: _pdfKey,
            child: Image.network('https://scontent.fktm17-1.fna.fbcdn.net/v/t39.30808-6/317324031_6092671470840857_2357097034409341903_n.jpg?_nc_cat=111&cb=99be929b-8d691acd&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=X4kRXQ4fSiIAX9iU90B&_nc_ht=scontent.fktm17-1.fna&oh=00_AfA-qhlbp1a8eDyWKorZAWG2tVzz3_1eVbgazXS6rSWUlg&oe=65A2C768'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: generatedCenteredText,
        child: const Icon(
          Icons.picture_as_pdf,
        ),
      ),
    );
  }
}
