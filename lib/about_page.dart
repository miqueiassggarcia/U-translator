import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Sobre'),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      centerTitle: true,
    ),
  );
}