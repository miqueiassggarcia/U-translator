import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Abra um pdf.',
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

    if (pdfPath != null) {
      PDFHistory.addToHistory(pdfPath!);
    }

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
class PDFHistory{
  static const _key = 'pdf_history';

  static Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_key) ?? [];
    return history;
  }

  static Future<List<String>> addToHistory(String pdfPath) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_key) ?? [];

    if (history.contains(pdfPath)) {
      history.remove(pdfPath);
    }

    history.insert(0, pdfPath);

    if (history.length > 20) {
      history.removeLast();
    }

    await prefs.setStringList(_key, history);
    return history;
  }
}