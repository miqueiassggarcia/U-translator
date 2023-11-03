import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utranslator/builders/build_inicial_home_text.dart';
import 'package:utranslator/builders/build_pdf_history.dart';
import 'package:utranslator/builders/build_pdf_viewer.dart';

class HomePageBodyController extends ChangeNotifier {
  bool buttonIsActive = true;
  Widget currentBody = Container();

  static const _keyIfOpen = 'if_pdf_is_already_open';
  static const _keyPDFOpen = 'pdf_is_open';

  Future<void> changeIfThePDFHasAlreadyBeenOpen(
      Function callbackFunction) async {
    final prefs = await SharedPreferences.getInstance();
    final isAlreadyOpen = prefs.getBool(_keyIfOpen) ?? false;
    if (!isAlreadyOpen) {
      currentBody = const HomePageInitialText();
      notifyListeners();
    } else {
      currentBody = PdfHistory(
        callbackFunction: callbackFunction,
      );
      notifyListeners();
    }
  }

  Future<void> setIfThePDFHasAlreadyBeenOpen(bool isOpen) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_keyIfOpen, isOpen);
  }

  changeBodyToPdfView(String pdfPath) {
    currentBody = PDFViewerBody(pdfPath: pdfPath, callbackFunction: setPDFOpen);
    buttonIsActive = false;
    setIfThePDFHasAlreadyBeenOpen(true);
    setPDFOpen(pdfPath);
    notifyListeners();
  }

  Future<void> setPDFOpen(String path) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_keyPDFOpen, path);
  }

  Future<void> changeIfPDFOpen() async {
    final prefs = await SharedPreferences.getInstance();
    String? path = prefs.getString(_keyPDFOpen);

    if (path != null && path.isNotEmpty) {
      changeBodyToPdfView(path);
    }
  }
}
