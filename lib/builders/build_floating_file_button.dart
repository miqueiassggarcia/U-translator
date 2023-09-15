import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FloatingFileButton extends StatelessWidget {
  const FloatingFileButton({super.key, required this.callbackFunction});
  final Function callbackFunction;

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
          callbackFunction(pdfFile);
        }
      },
      tooltip: 'open file',
      child: const Icon(Icons.folder),
    );
  }
}
