import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PDFViewerBody extends StatelessWidget {
  final String? pdfPath;

  const PDFViewerBody({Key? key, this.pdfPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pdfPath != null) {
      PDFHistory.addToHistory(pdfPath!);
    }

    return PDFView(
      filePath: pdfPath,
    );
  }
}

class PDFHistory{
  static const _key = 'pdf_history';

  static Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_key) ?? [];
    return history;
  }

  static Future<List<String>> addToHistory(String pdfPath) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_key) ?? [];

    if (history.contains(pdfPath)) {
      history.remove(pdfPath);
    }

    history.insert(0, pdfPath);

    if (history.length > 20) {
      history.removeLast();
    }

    await prefs.setStringList(_key, history);
    return history;
  }
}