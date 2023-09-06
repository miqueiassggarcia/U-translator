import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:utranslator/navigation/navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Home'),
          centerTitle: true,
        ),
        drawer: const Navigation(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Use o botão no canto inferior direito',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'e abra o seu primeiro arquivo',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf'],
            );
            if (result != null){
              var pdf_file = result.files.single.path;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PDFViewerPage(pdfPath: pdf_file),
                ),
              );
            }
          },
          tooltip: 'open file',
          child: const Icon(Icons.folder),
        ));
  }
}
class PDFViewerPage extends StatelessWidget {
  final String? pdfPath;

  PDFViewerPage({Key? key, this.pdfPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizador de PDF'),
      ),
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}
