import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

buildPrintableData(
        {required pw.ImageProvider image,
        required String orderText,
        required String itemText,
        required String descriptionText,
        required String smallText,
        required String pickArea,
        required String plantDateText,
        required String quantity}) =>
    pw.Container(
      // margin: const pw.EdgeInsets.all(25.0),
      child: pw.Stack(
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Order #$orderText",
                  style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  "Item #$itemText",
                  style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 8),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                  pw.Text(
                    descriptionText,
                    style: const pw.TextStyle(fontSize: 12),
                    textAlign: pw.TextAlign.center,
                  ),
                ]),
                pw.SizedBox(height: 8),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Flexible(
                      child: pw.Text(
                        smallText,
                        style: pw.TextStyle(fontStyle: pw.FontStyle.italic, fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.Text(
                      " - ",
                      style: pw.TextStyle(fontStyle: pw.FontStyle.italic, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Flexible(
                      child: pw.Text(
                        pickArea,
                        style: pw.TextStyle(fontStyle: pw.FontStyle.italic, fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    "PLANT DATE $plantDateText",
                    style: const pw.TextStyle(fontSize: 14),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Align(
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      "____/$quantity QTY ____/____ BOXES",
                      style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                      textAlign: pw.TextAlign.center,
                    )),
              ],
            ),
          ),
          pw.Positioned(
            right: 8,
            top: 8,
            child: pw.Image(
              image,
              width: 50,
              height: 50,
            ),
          ),
          pw.Positioned(
            right: 0,
            top: 0,
            child: pw.Container(
                width: 305,
                height: 170,
                decoration: pw.BoxDecoration(
                    // color: PdfColors.transparent,
                    border: pw.Border.all(
                  color: PdfColors.black,
                ))),
          ),
        ],
      ),
    );
