import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:invert_colors/invert_colors.dart';

class PDFViewerBody extends StatelessWidget {
  final String? pdfPath;

  const PDFViewerBody({Key? key, this.pdfPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InvertColors(
        child: PDFView(
      filePath: pdfPath,
    ));
  }
}
