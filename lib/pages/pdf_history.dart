import 'package:flutter/material.dart';
import 'package:utranslator/navigation/navigation.dart';
import 'package:utranslator/pages/home_page.dart';
import 'package:path/path.dart';

class PdfHistory extends StatelessWidget {
  const PdfHistory({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const Navigation(),
        appBar: AppBar(
          title: const Text('Histórico'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
        ),
        body: FutureBuilder<List<String>>(
          future: PDFHistory.getHistory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro ao carregar o histórico: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('Nenhum PDF no histórico.');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final pdfPath = snapshot.data![index];
                  final pdfFileName = basename(pdfPath);
                  final maxLength = 25;

                  final displayedFileName = pdfFileName.length > maxLength ? pdfFileName.substring(0, maxLength) + '...' : pdfFileName;
                  return ListTile(
                    title: Row(
                      children: [
                        const Icon(Icons.picture_as_pdf),
                        const SizedBox(width: 8),
                        Text(displayedFileName),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PDFViewerPage(pdfPath: pdfPath),
                ),
              );
                  },
                );
              },
            );
          }
        },
      ),
      );
}