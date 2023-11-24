import 'package:flutter/material.dart';
import 'package:utranslator/builders/build_pdf_viewer.dart';
import 'package:path/path.dart';
import 'package:pdf_thumbnail/pdf_thumbnail.dart';

class PdfHistory extends StatelessWidget {
  const PdfHistory({super.key, required this.callbackFunction});
  final Function callbackFunction;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: PDFHistory.getHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro ao carregar o histórico: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Nenhum PDF no histórico.');
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final pdfPath = snapshot.data![index];
              final pdfFileName = basename(pdfPath);
              const maxLength = 25;

              final displayedFileName = pdfFileName.length > maxLength
                  ? "${pdfFileName.substring(0, maxLength)}..."
                  : pdfFileName;
              return ListTile(
                leading: SizedBox(
                  width: 50,
                  child: PdfThumbnail.fromFile(
                    pdfPath,
                    currentPage: 1,
                    height: 50,
                    backgroundColor: Colors.white,
                  ),
                ),
                title: Text(displayedFileName),
                onTap: () {
                  callbackFunction(pdfPath);
                },
              );
            },
          );
        }
      },
    );
  }
}
