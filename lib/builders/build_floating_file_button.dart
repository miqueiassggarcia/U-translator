import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:utranslator/controllers/home_page_body_controller.dart';

class FloatingFileButton extends StatelessWidget {
  const FloatingFileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );
        if (result != null) {
          var pdfFile = result.files.single.path;
          HomePageBodyController().changeBody(1, pdfFile);
        }
      },
      tooltip: 'open file',
      child: const Icon(Icons.folder),
    );
  }
}
