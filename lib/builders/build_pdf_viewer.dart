import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerBody extends StatelessWidget {
  final String? pdfPath;

  const PDFViewerBody({Key? key, this.pdfPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PDFView(
      filePath: pdfPath,
    );
  }
}
