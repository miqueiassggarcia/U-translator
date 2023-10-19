import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:utranslator/my_app.dart';
import 'package:receive_intent/receive_intent.dart';
import 'package:utranslator/controllers/home_page_body_controller.dart';
import 'package:utranslator/builders/build_pdf_viewer.dart';
import 'package:lecle_flutter_absolute_path/lecle_flutter_absolute_path.dart';
import 'package:utranslator/builders/build_pdf_history.dart';
import 'package:utranslator/pages/home_page_body.dart';

void main() async{
  runApp(const MyApp());
  final receivedIntent = await ReceiveIntent.getInitialIntent();
  if (receivedIntent != null){
    if (receivedIntent.action == 'android.intent.action.VIEW' && receivedIntent.data != null ){
      runApp(const MyWidget());
    }
  }
  // runApp(const MyWidget());
}


class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}


class Home extends StatefulWidget {
  
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late File _file;
  
  @override
  void initState() {
    super.initState();
    _intentFile();
  }


  Future<void> _intentFile() async {
  final receivedIntent = await ReceiveIntent.getInitialIntent();
  // final controller = HomePageBodyController();
  // final viwer = PDFViewerBody();
  if (receivedIntent != null) {
    if (receivedIntent.action == 'android.intent.action.VIEW' && receivedIntent.data != null ){
      print("teste");
      print(receivedIntent);
      final pdfPath = receivedIntent.data!; // Extrai o caminho do arquivo da query do URL
      var path = await LecleFlutterAbsolutePath.getAbsolutePath(uri: pdfPath, fileExtension: "pdf");
      File url = File(path!);
      setState(() {
        _file = url;
      });
      // print(url);
      // runApp(PDFViewerBody(pdfPath: path!));
      // PDFViewerBody(pdfPath: path);
      // controller.changeBodyToPdfView(path);
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _file != null ? SfPdfViewer.file(_file) : Text("ola gostosa"),
    );
  }
}
// @override
// void initState() {
//   initState();
//   }