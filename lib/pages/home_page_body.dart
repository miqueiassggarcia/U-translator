import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utranslator/builders/build_floating_file_button.dart';
import 'package:utranslator/controllers/home_page_body_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomePageBodyController();

  Widget get currentBody => controller.currentBody;
  bool get buttonIsActive => controller.buttonIsActive;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  void callback(int index, String pdfPath) {
    setState(() {
      controller.changeBody(index, pdfPath);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: FutureBuilder<bool>(
          future: IfPDFIsAlreadyOpen.getIfPDFIsAlreadyOpen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text(
                  'Erro ao carregar estado da página: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Text('Nenhum dado de estado.');
            } else {
              if (snapshot.data!) {
                controller.changeBody(2, null);
              } else {
                controller.changeBody(0, null);
              }
            }
            return Scaffold (
              body: currentBody,
              floatingActionButton: buttonIsActive
                  ? FloatingFileButton(callbackFunction: callback)
                  : null,
            );
          }));
}

class IfPDFIsAlreadyOpen {
  static const _key = 'if_pdf_is_already_open';

  static Future<bool> getIfPDFIsAlreadyOpen() async {
    final prefs = await SharedPreferences.getInstance();
    final isAlreadyOpen = prefs.getBool(_key) ?? false;
    return isAlreadyOpen;
  }

  static Future<bool> addIfPDFIsAlreadyOpen(bool isOpen) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_key, isOpen);

    return isOpen;
  }
}
