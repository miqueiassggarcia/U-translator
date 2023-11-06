import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:invert_colors/invert_colors.dart';
import 'package:utranslator/controllers/home_page_body_controller.dart';
import 'package:utranslator/controllers/initial_page_controller.dart';
import 'package:utranslator/provider/theme_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_cloud_translation/google_cloud_translation.dart';
import 'package:utranslator/pages/initial_page.dart';

class PDFViewerBody extends StatefulWidget {
  final String? pdfPath;
  final Function callbackFunction;
  final int currentPage;

  const PDFViewerBody(
      {super.key,
      this.pdfPath,
      required this.callbackFunction,
      required this.currentPage});

  @override
  State<PDFViewerBody> createState() => _PDFViewerBodyState(
      pdfPath: this.pdfPath,
      callbackFunction: this.callbackFunction,
      currentPage: this.currentPage);
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
  final int currentPage;
  final homePageBodyController = HomePageBodyController();

  _PDFViewerBodyState(
      {required this.pdfPath,
      required this.callbackFunction,
      required this.currentPage});

  @override
  void initState() {
    super.initState();

    _pdfViewerController = PdfViewerController();
    _pdfViewerController.jumpToPage(currentPage);

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
              child: OverlayTrasnlation(text_selected: details.selectedText as String ,translateText: translateText)
            ));

    _overlayState.insert(_overlayEntry!);
  }

  Future<String> translateText(String text) async {
    _translated = (await _translation?.translate(text: text, to: 'en'))!;
    return _translated.translatedText; 
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
          controller: _pdfViewerController,
          onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
            if (details.selectedText == null && _overlayEntry != null) {
              _overlayEntry!.remove();
              _overlayEntry = null;
            } else if (details.selectedText != null && _overlayEntry == null) {
              _showContextMenu(context, details);
            }
          },
          onPageChanged: (PdfPageChangedDetails details) {
            homePageBodyController.setPDFOpen(pdfPath!, details.newPageNumber);
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
              callbackFunction("", 0);

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


class OverlayTrasnlation extends StatefulWidget {
  final String text_selected;
  final Function translateText;


  OverlayTrasnlation({
    required this.text_selected,
    required this.translateText
  });

  @override
  State<OverlayTrasnlation> createState() => _OverlayTrasnlationState(
    text_selected: this.text_selected, 
    translateText: this.translateText
  );
}

class _OverlayTrasnlationState extends State<OverlayTrasnlation> {
  String text_selected;
  Function translateText;
  bool showBox = false;
  bool canSave = false;
  bool translated = false;
  late String _text_translated = "Traduzindo...";

  _OverlayTrasnlationState({required this.text_selected, required this.translateText});

  Future<void> _troggle_pressed() async {
    setState(() {
      showBox = true;
    });
    if (text_selected.length < 200) {
      String t = await translateText(text_selected);
      setState(() {
        _text_translated = t;
        canSave = true;
        translated = true;
      });
    } else {
      setState(() {
        _text_translated = "Texto muito longo";
        canSave = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
              child: Text("Traduzir"),
              onPressed: !translated ? _troggle_pressed : null
            )
          ],
        ),
        showBox == true ? Container (
          width: 300,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: const Color.fromARGB(255, 88, 81, 81)
          ),
          child: Text(_text_translated, 
            style: TextStyle(color: Colors.white, fontSize: 15, decoration: TextDecoration.none),),
        ) : Container()
      ],
    );
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
