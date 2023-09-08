import 'package:flutter/material.dart';
import 'package:utranslator/builders/build_inicial_home_text.dart';
import 'package:utranslator/builders/build_pdf_viewer.dart';

class HomePageBodyController extends ChangeNotifier {
  bool buttonIsActive = true;
  Widget currentBody = HomePageInitialText();

  changeBody(int index, String? pdfPath) {
    if (index == 0) {
      currentBody = const HomePageInitialText();
      notifyListeners();
    } else if (index == 1 && pdfPath != null) {
      currentBody = PDFViewerBody(pdfPath: pdfPath);
      buttonIsActive = false;
      notifyListeners();
    }
  }
}
