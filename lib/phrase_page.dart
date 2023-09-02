import 'package:flutter/material.dart';
import 'package:utranslator/navigation.dart';

class PhrasePage extends StatelessWidget {
  const PhrasePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: const Navigation(),
    appBar: AppBar(
      title: const Text('Frases'),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      centerTitle: true,
    ),
  );
}
