import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ExtracaoPdf extends StatefulWidget {
  const ExtracaoPdf({super.key});

  @override
  State<ExtracaoPdf> createState() => _ExtracaoPdfState();
}

class _ExtracaoPdfState extends State<ExtracaoPdf> {
  OverlayEntry? _overlayEntry;
  File? file;

  void _showContextMenu(
      BuildContext context, PdfTextSelectionChangedDetails details) {
    final OverlayState contextMenuOverlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
              top: details.globalSelectedRegion!.center.dy - 55,
              left: details.globalSelectedRegion!.bottomLeft.dx,
              child: ElevatedButton(
                onPressed: () {},
                child: null,
              ),
            ));

    contextMenuOverlayState.insert(_overlayEntry!);
  }

  Widget getBody() {
    if (file != null) {
      return SfPdfViewer.file(
        file!,
        onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
          if (details.selectedText == null && _overlayEntry != null) {
            _overlayEntry!.remove();
            _overlayEntry = null;
          } else if (details.selectedText != null && _overlayEntry == null) {
            _showContextMenu(context, details);
          }
        },
      );
    } else {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Center(child: Text("Escolha um PDF!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Viewer"),
      ),
      body: getBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();

          if (result != null) {
            final newFile = File(result.files.single.path!);
            setState(() {
              file = newFile;
            });
          }
        },
        child: const Icon(Icons.folder),
      ),
    );
  }
}
