import 'dart:math';

import 'package:flutter/material.dart';
import 'package:utranslator/builders/build_floating_file_button.dart';
import 'package:utranslator/controllers/home_page_body_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? pdfPath;
  int myIndex = 0;
  final animation = Tween(begin: 0, end: 2 * pi).animate(kAlwaysCompleteAnimation);

  @override
  Widget build(BuildContext context) =>
      AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
        return Scaffold(
          body: HomePageBodyController().bodyContent,
          floatingActionButton: HomePageBodyController().buttonIsActive
              ? const FloatingFileButton()
              : null,
        );
      });
}
