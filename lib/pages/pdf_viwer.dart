import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PDFViewerPage extends StatelessWidget {
  final String? pdfPath;

  PDFViewerPage({Key? key, this.pdfPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (pdfPath != null) {
      PDFHistory.addToHistory(pdfPath!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizador de PDF'),
      ),
      body: PDFView(
        filePath: pdfPath,
      ),
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

  static Future<void> addToHistory(String pdfPath) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_key) ?? [];
    history.add(pdfPath);
    await prefs.setStringList(_key, history);
  }
}