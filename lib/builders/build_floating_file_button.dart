import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:utranslator/controllers/home_page_body_controller.dart';

class FloatingFileButton extends StatelessWidget {
  const FloatingFileButton({super.key});
  get controller => HomePageBodyController();

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
          controller.changeBody(0, pdfFile);
        }
      },
      tooltip: 'open file',
      child: const Icon(Icons.folder),
    );
  }
}
