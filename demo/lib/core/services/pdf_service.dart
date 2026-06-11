import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  static const PdfColor ucshBlue = PdfColor.fromInt(0xFF004677);
  static const PdfColor ucshYellow = PdfColor.fromInt(0xFFF6BE00);

  static Future<void> printReport({
    required String title,
    required String subtitle,
    required List<pw.Widget> content,
    Uint8List? signatureImage,
  }) async {
    final pdf = await _buildDocument(title, subtitle, content, signatureImage);
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  static Future<void> exportPdf({
    required String title,
    required String subtitle,
    required List<pw.Widget> content,
    Uint8List? signatureImage,
  }) async {
    final pdf = await _buildDocument(title, subtitle, content, signatureImage);
    final bytes = await pdf.save();
    await Printing.sharePdf(bytes: bytes, filename: '${title.replaceAll(' ', '_')}_Report.pdf');
  }

  static Future<pw.Document> _buildDocument(
    String title,
    String subtitle,
    List<pw.Widget> content,
    Uint8List? signatureImage,
  ) async {
    final pdf = pw.Document();

    final font = await PdfGoogleFonts.robotoRegular();
    final fontBold = await PdfGoogleFonts.robotoBold();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          // Header Block
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            decoration: const pw.BoxDecoration(
              color: ucshBlue,
              borderRadius: pw.BorderRadius.vertical(top: pw.Radius.circular(8)),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      title.toUpperCase(),
                      style: pw.TextStyle(font: fontBold, color: PdfColors.white, fontSize: 24),
                    ),
                    pw.Text(
                      subtitle,
                      style: pw.TextStyle(font: font, color: ucshYellow, fontSize: 12),
                    ),
                  ],
                ),
                // Placeholder for logo
                pw.Container(
                  width: 60,
                  height: 60,
                  decoration: const pw.BoxDecoration(color: PdfColors.white, shape: pw.BoxShape.circle),
                  child: pw.Center(child: pw.Text('UCSH', style: const pw.TextStyle(color: ucshBlue, fontSize: 10))),
                ),
              ],
            ),
          ),
          
          pw.SizedBox(height: 30),
          
          ...content,

          if (signatureImage != null) ...[
            pw.SizedBox(height: 50),
            pw.Divider(color: PdfColors.grey400),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Image(pw.MemoryImage(signatureImage), width: 200),
                    pw.Container(
                      width: 200,
                      height: 1,
                      color: PdfColors.black,
                    ),
                    pw.Text('Firma del Participante', style: pw.TextStyle(font: font, fontSize: 10)),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text('Fecha: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}', style: pw.TextStyle(font: font, fontSize: 10)),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );

    return pdf;
  }
}
