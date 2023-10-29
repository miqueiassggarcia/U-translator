import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utranslator/builders/build_inicial_home_text.dart';
import 'package:utranslator/builders/build_pdf_history.dart';
import 'package:utranslator/builders/build_pdf_viewer.dart';
import 'package:utranslator/pages/home_page_body.dart';

class HomePageBodyController extends ChangeNotifier {
  bool buttonIsActive = true;
  Widget currentBody = Container();

  static const _key = 'if_pdf_is_already_open';

  Future<void> changeIfThePDFHasAlreadyBeenOpen(Function callbackFunction) async {
    final prefs = await SharedPreferences.getInstance();
    final isAlreadyOpen = prefs.getBool(_key) ?? false;
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

    await prefs.setBool(_key, isOpen);
  }

  changeBodyToPdfView(String pdfPath) {
    print(pdfPath);
    currentBody = PDFViewerBody(pdfPath: pdfPath);
    buttonIsActive = false;
    setIfThePDFHasAlreadyBeenOpen(true);
    notifyListeners();
  }
}