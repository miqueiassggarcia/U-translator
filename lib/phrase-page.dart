import 'package:flutter/material.dart';

class PhrasePage extends StatelessWidget {
  const PhrasePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Frases'),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      centerTitle: true,
    ),
  );
}
