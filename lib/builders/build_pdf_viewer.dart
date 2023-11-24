import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:invert_colors/invert_colors.dart';
import 'package:utranslator/controllers/drawer_status_controller.dart';
import 'package:utranslator/controllers/home_page_body_controller.dart';
import 'package:utranslator/controllers/initial_page_controller.dart';
import 'package:utranslator/provider/theme_controller.dart';
import 'package:google_cloud_translation/google_cloud_translation.dart';
import 'package:utranslator/pages/initial_page.dart';
import 'package:utranslator/controllers/configuration_controller.dart';

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
      pdfPath: pdfPath,
      callbackFunction: callbackFunction,
      currentPage: currentPage);
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
    final OverlayState contextMenuOverlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
            top: details.globalSelectedRegion!.center.dy - 100,
            left: details.globalSelectedRegion!.bottomLeft.dx,
            child: OverlayTrasnlation(
                textSelected: details.selectedText as String,
                translateText: translateText)));

    contextMenuOverlayState.insert(_overlayEntry!);
  }

  void _removeContextMenu() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  Future<String> translateText(String text, String toLanguage) async {
    _translated = (await _translation?.translate(text: text, to: toLanguage))!;
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

    Widget pdfBodyGenerator() {
      return Stack(children: <Widget>[
        SfPdfViewer.file(
          _file!,
          controller: _pdfViewerController,
          onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
            if (details.selectedText == null && _overlayEntry != null) {
              _removeContextMenu();
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
            icon: const Icon(Icons.arrow_back_ios,
                color: Color.fromARGB(255, 0, 0, 0)),
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
                  icon: const Icon(Icons.arrow_downward_rounded,
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
                  icon: const Icon(Icons.arrow_upward_rounded,
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

    return AnimatedBuilder(
        animation: DrawerStatusController.instance,
        builder: (context, child) {
          if (DrawerStatusController.instance.drawnerOpened) {
            _removeContextMenu();
          }

          return themeProvider.isDarkMode
              ? InvertColors(child: pdfBodyGenerator())
              : pdfBodyGenerator();
        });
  }
}

class OverlayTrasnlation extends StatefulWidget {
  final String textSelected;
  final Function translateText;

  const OverlayTrasnlation(
      {super.key, required this.textSelected, required this.translateText});

  @override
  State<OverlayTrasnlation> createState() => _OverlayTrasnlationState(
      textSelected: textSelected, translateText: translateText);
}

class _OverlayTrasnlationState extends State<OverlayTrasnlation> {
  String textSelected;
  Function translateText;
  bool showBox = false;
  bool canSave = false;
  bool translated = false;
  String _textTranslated = "Traduzindo...";
  ConfigurationController controller = ConfigurationController();

  _OverlayTrasnlationState(
      {required this.textSelected, required this.translateText});

  @override
  void initState() {
    super.initState();
    controller.changeIfLanguageSelected();
    controller.addListener(() {
      setState(() {});
    });
  }

  Future<void> troggleTranslatePressed() async {
    setState(() {
      showBox = true;
    });
    if (textSelected.length < 200) {
      String t = await translateText(
          textSelected, controller.getCodeFromOutputLanguage);
      setState(() {
        _textTranslated = t;
        canSave = true;
        translated = true;
      });
    } else {
      setState(() {
        _textTranslated = "Texto muito longo";
        canSave = false;
      });
    }
  }

  Future<void> troggleSaveWordPressed() async {
    PDFWords.addToWords(_textTranslated, textSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
                onPressed: !translated ? troggleTranslatePressed : null,
                child: const Text("Traduzir")),
            translated
                ? ElevatedButton(
                    onPressed: troggleSaveWordPressed,
                    child: const Text("Salvar"))
                : Container()
          ],
        ),
        showBox == true
            ? Container(
                width: 300,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Color.fromARGB(255, 88, 81, 81)),
                child: Text(
                  _textTranslated,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      decoration: TextDecoration.none),
                ),
              )
            : Container()
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

class PDFWords {
  static const word = 'pdf_Words';

  static Future<List<String>> getWords() async {
    final prefs = await SharedPreferences.getInstance();
    final words = prefs.getStringList(word) ?? [];
    return words;
  }

  static Future<List<String>> addToWords(
      String pdfWords, String wordpdf) async {
    final prefs = await SharedPreferences.getInstance();
    final words = prefs.getStringList(word) ?? [];

    if (words.contains(pdfWords) && words.contains(wordpdf)) {
      words.remove(pdfWords);
      words.remove(wordpdf);
    }

    words.insert(0, pdfWords);
    words.insert(0, wordpdf);

    if (words.length > 50) {
      words.removeLast();
      words.removeLast();
    }

    await prefs.setStringList(word, words);
    return words;
  }
}
