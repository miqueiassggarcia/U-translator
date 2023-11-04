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

  changeBodyToPdfView(String pdfPath, int currentPage) {
    currentBody = PDFViewerBody(pdfPath: pdfPath, callbackFunction: setPDFOpen, currentPage: currentPage);
    buttonIsActive = false;
    setIfThePDFHasAlreadyBeenOpen(true);
    setPDFOpen(pdfPath, currentPage);
    notifyListeners();
  }

  Future<void> setPDFOpen(String path, int currentPage) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_keyPDFOpen, [path, currentPage.toString()]);
  }

  Future<void> changeIfPDFOpen() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? PDFProperties = prefs.getStringList(_keyPDFOpen);

    if (PDFProperties != null && PDFProperties[0].isNotEmpty) {
      changeBodyToPdfView(PDFProperties[0], int.parse(PDFProperties[1]));
    }
  }
}
