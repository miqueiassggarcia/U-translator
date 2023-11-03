import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:invert_colors/invert_colors.dart';
import 'package:utranslator/controllers/initial_page_controller.dart';
import 'package:utranslator/provider/theme_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_cloud_translation/google_cloud_translation.dart';
import 'package:utranslator/pages/initial_page.dart';

class PDFViewerBody extends StatefulWidget {
  final String? pdfPath;
  final Function callbackFunction;

  const PDFViewerBody(
      {super.key, this.pdfPath, required this.callbackFunction});

  @override
  State<PDFViewerBody> createState() => _PDFViewerBodyState(
      pdfPath: this.pdfPath, callbackFunction: this.callbackFunction);
}

class _PDFViewerBodyState extends State<PDFViewerBody> {
  final String? pdfPath;
  Translation? _translation;
  TranslationModel _translated =
      TranslationModel(translatedText: '', detectedSourceLanguage: '');
  OverlayEntry? _overlayEntry;
  File? _file;
  final Function callbackFunction;
  late PdfViewerController _pdfViewerController;

  _PDFViewerBodyState({required this.pdfPath, required this.callbackFunction});

  @override
  void initState() {
    super.initState();

    _pdfViewerController = PdfViewerController();

    print("iniciou");
    String ak = dotenv.env['APIKEY'] as String;
    _translation = Translation(apiKey: ak);
  }

  void _showContextMenu(
      BuildContext context, PdfTextSelectionChangedDetails details) {
    final OverlayState _overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
              top: details.globalSelectedRegion!.center.dy - 55,
              left: details.globalSelectedRegion!.bottomLeft.dx,
              child: Row(children: [
                ElevatedButton(
                  child: Text("Traduzir"),
                  onPressed: () async {
                    _translated = (await _translation?.translate(
                        text: details.selectedText as String, to: 'en'))!;
                    print(_translated.translatedText);
                  },
                )
              ]),
            ));

    _overlayState.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final initialPageController = Provider.of<InitialPageController>(context);

    if (pdfPath != null) {
      PDFHistory.addToHistory(pdfPath!);
      _file = File(pdfPath!);
    }

    Widget PDFBodyGenerator() {
      return Stack(children: <Widget>[
        SfPdfViewer.file(
          _file!,
          onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
            if (details.selectedText == null && _overlayEntry != null) {
              _overlayEntry!.remove();
              _overlayEntry = null;
            } else if (details.selectedText != null && _overlayEntry == null) {
              _showContextMenu(context, details);
            }
          },
        ),
        Positioned(
          top: 10,
          left: 10,
          child: IconButton(
            icon:
                Icon(Icons.arrow_back_ios, color: Color.fromARGB(255, 0, 0, 0)),
            onPressed: () {
              setState(() {
                initialPageController.openHeaderAndFooter();
              });

              Navigator.pop(context);
              callbackFunction("");

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const InitialPage()));
            },
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: initialPageController.headerAndFooterIsActive
              ? IconButton(
                  icon: Icon(Icons.arrow_downward_rounded,
                      color: Color.fromARGB(255, 0, 0, 0)),
                  onPressed: () {
                    setState(() {
                      initialPageController.closeHeaderAndFooter();
                      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                          overlays: []);
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.arrow_upward_rounded,
                      color: Color.fromARGB(255, 0, 0, 0)),
                  onPressed: () {
                    setState(() {
                      initialPageController.openHeaderAndFooter();
                      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                          overlays: [
                            SystemUiOverlay.top,
                            SystemUiOverlay.bottom
                          ]);
                    });
                  },
                ),
        ),
      ]);
    }

    return themeProvider.isDarkMode
        ? InvertColors(child: PDFBodyGenerator())
        : PDFBodyGenerator();
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
