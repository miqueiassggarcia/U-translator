import 'package:flutter/material.dart';
import 'package:utranslator/home_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const Navigation(),
        appBar: AppBar(
          title: const Text('Sobre'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
        ),
      );
}
