import 'package:flutter/material.dart';
import 'package:utranslator/builders/build_inicial_home_text.dart';
import 'package:utranslator/builders/build_pdf_viewer.dart';

class HomePageBodyController extends ChangeNotifier {
  static HomePageBodyController instance = HomePageBodyController();

  bool buttonIsActive = true;
  Widget bodyContent = const HomePageInitialText();

  changeBody(int index, String? pdfPath) {
    if (index == 0) {
      bodyContent = const HomePageInitialText();
      notifyListeners();
    } else if (index == 1) {
      bodyContent = PDFViewerBody(pdfPath: pdfPath);
      buttonIsActive = false;
      notifyListeners();
    }
  }
}
