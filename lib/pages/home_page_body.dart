import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:utranslator/controllers/home_page_body_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomePageBodyController();

  Widget get currentBody => controller.currentBody;
  bool get buttonIsActive => controller.buttonIsActive;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: currentBody,
        floatingActionButton: buttonIsActive
            ? FloatingActionButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf'],
                  );
                  if (result != null) {
                    var pdfFile = result.files.single.path;
                    controller.changeBody(1, pdfFile);
                  }
                },
                tooltip: 'open file',
                child: const Icon(Icons.folder),
              )
            : null,
      );
}
