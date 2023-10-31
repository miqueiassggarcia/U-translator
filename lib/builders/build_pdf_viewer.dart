import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:invert_colors/invert_colors.dart';
import 'package:utranslator/provider/theme_controller.dart';
import 'package:utranslator/pages/initial_page.dart';

class PDFViewerBody extends StatelessWidget {
  final String? pdfPath;
  OverlayEntry? _overlayEntry;
  File? _file;
  final Function callbackFunction;

  PDFViewerBody({Key? key, this.pdfPath, required this.callbackFunction})
      : super(key: key);

  void _showContextMenu(
      BuildContext context, PdfTextSelectionChangedDetails details) {
    final OverlayState _overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
              top: details.globalSelectedRegion!.center.dy - 55,
              left: details.globalSelectedRegion!.bottomLeft.dx,
              child: ElevatedButton(
                onPressed: () {},
                child: null,
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
            child: Stack(children: <Widget>[
            SfPdfViewer.file(
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
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    color: Color.fromARGB(255, 0, 0, 0)),
                onPressed: () {
                  Navigator.pop(context);
                  callbackFunction("");

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InitialPage()));
                },
              ),
            ),
          ]))
        : Stack(children: <Widget>[
            SfPdfViewer.file(
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
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    color: Color.fromARGB(255, 0, 0, 0)),
                onPressed: () {
                  Navigator.pop(context);
                  callbackFunction("");

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InitialPage()));
                },
              ),
            ),
          ]);
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
