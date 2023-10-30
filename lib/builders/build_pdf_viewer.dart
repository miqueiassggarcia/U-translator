import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:invert_colors/invert_colors.dart';
import 'package:utranslator/provider/theme_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PDFViewerBody extends StatelessWidget {
  final String? pdfPath;
  OverlayEntry? _overlayEntry;
  File? _file;

  PDFViewerBody({Key? key, this.pdfPath}) : super(key: key);

  void _showContextMenu(
      BuildContext context, PdfTextSelectionChangedDetails details) {
    final OverlayState _overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
              top: details.globalSelectedRegion!.center.dy - 55,
              left: details.globalSelectedRegion!.bottomLeft.dx,
              child: Row(
                children: [
                  ElevatedButton(
                    child: Text("Traduzir"),
                    onPressed: () {
                      String? apikey = dotenv.env['APIKEY'];
                      print(details.selectedText);
                    },
                  )
                ]
              ),
            ));

    _overlayState.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);

    if (pdfPath != null) {
      PDFHistory.addToHistory(pdfPath!);
      _file = File(pdfPath!);
    }

    return themeProvider.isDarkMode
        ? InvertColors(
            child: SfPdfViewer.file(
            _file!,
            onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
              if (details.selectedText == null && _overlayEntry != null) {
                _overlayEntry!.remove();
                _overlayEntry = null;
              } else if (details.selectedText != null &&
                  _overlayEntry == null) {
                _showContextMenu(context, details);
              }
            },
          ))
        : SfPdfViewer.file(
            _file!,
            onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
              if (details.selectedText == null && _overlayEntry != null) {
                _overlayEntry!.remove();
                _overlayEntry = null;
              } else if (details.selectedText != null &&
                  _overlayEntry == null) {
                _showContextMenu(context, details);
              }
            },
          );
    //return PDFView(
    //  filePath: pdfPath,
    //);
  }
}

class PDFHistory {
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
