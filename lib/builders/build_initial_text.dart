import 'package:flutter/material.dart';
import 'package:utranslator/builders/build_pdf_viewer.dart';

class PhrasePageBody extends StatelessWidget {
  const PhrasePageBody({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: PDFWords.getWords(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro ao carregar palavras: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Nenhum palavra no histórico.');
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final words = snapshot.data![index];
                return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.1),
                title: Text(words),
              );
            }
          );
        }
      },
    );
  }
}