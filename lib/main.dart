import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:utranslator/my_app.dart';
import 'package:receive_intent/receive_intent.dart';
import 'package:lecle_flutter_absolute_path/lecle_flutter_absolute_path.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
  final receivedIntent = await ReceiveIntent.getInitialIntent();
  if (receivedIntent != null) {
    if (receivedIntent.action == 'android.intent.action.VIEW' &&
        receivedIntent.data != null) {
      runApp(const MyWidget());
    }
  }
  // runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
  late File newFile;

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
      if (receivedIntent.action == 'android.intent.action.VIEW' &&
          receivedIntent.data != null) {
        final pdfPath =
            receivedIntent.data!; // Extrai o caminho do arquivo da query do URL
        var path = await LecleFlutterAbsolutePath.getAbsolutePath(
            uri: pdfPath, fileExtension: "pdf");
        File url = File(path!);
        setState(() {
          newFile = url;
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
      body: SfPdfViewer.file(newFile),
    );
  }
}
// @override
// void initState() {
//   initState();
//   }
