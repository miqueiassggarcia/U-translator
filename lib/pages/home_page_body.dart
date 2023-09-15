import 'package:flutter/material.dart';
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
    controller.getIfThePDFHasAlreadyBeenOpen();
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
        body: currentBody,
        floatingActionButton: buttonIsActive
            ? FloatingFileButton(callbackFunction: callback)
            : null,
      );
}
