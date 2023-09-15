import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utranslator/builders/build_inicial_home_text.dart';
import 'package:utranslator/builders/build_pdf_history.dart';
import 'package:utranslator/builders/build_pdf_viewer.dart';

class HomePageBodyController extends ChangeNotifier {
  bool buttonIsActive = true;
  Widget currentBody = const Text("Erro ao carregar tela");

  static const _key = 'if_pdf_is_already_open';

  Future<void> getIfThePDFHasAlreadyBeenOpen() async {
    final prefs = await SharedPreferences.getInstance();
    final isAlreadyOpen = prefs.getBool(_key) ?? false;
    if (!isAlreadyOpen) {
      currentBody = const HomePageInitialText();
      notifyListeners();
    } else {
      currentBody = const PdfHistory();
      notifyListeners();
    }
  }

  Future<void> setIfThePDFHasAlreadyBeenOpen(bool isOpen) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_key, isOpen);
  }

  changeBody(int index, String? pdfPath) {
    if (index == 0) {
      currentBody = const HomePageInitialText();
      notifyListeners();
    } else if (index == 1 && pdfPath != null) {
      currentBody = PDFViewerBody(pdfPath: pdfPath);
      buttonIsActive = false;
      setIfThePDFHasAlreadyBeenOpen(true);
      notifyListeners();
    } else if (index == 2) {
      currentBody = const PdfHistory();
      buttonIsActive = false;
      notifyListeners();
    }
  }
}

// body: FutureBuilder<bool>(
//           future: IfPDFIsAlreadyOpen.getIfPDFIsAlreadyOpen(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text(
//                   'Erro ao carregar estado da página: ${snapshot.error}');
//             } else if (!snapshot.hasData) {
//               return Text('Nenhum dado de estado.');
//             } else {
//               if (snapshot.data!) {
//                 controller.changeBody(2, null);
//               } else {
//                 controller.changeBody(0, null);
//               }
//             }
//             return Scaffold (

// class IfPDFIsAlreadyOpen {
//   static const _key = 'if_pdf_is_already_open';

//   static Future<bool> getIfPDFIsAlreadyOpen() async {
//     final prefs = await SharedPreferences.getInstance();
//     final isAlreadyOpen = prefs.getBool(_key) ?? false;
//     return isAlreadyOpen;
//   }

//   static Future<bool> addIfPDFIsAlreadyOpen(bool isOpen) async {
//     final prefs = await SharedPreferences.getInstance();

//     await prefs.setBool(_key, isOpen);

//     return isOpen;
//   }
// }
