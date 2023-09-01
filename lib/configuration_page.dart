import 'package:flutter/material.dart';
import 'package:utranslator/home_page.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: const Navigation(),
    appBar: AppBar(
      title: const Text('Configurações'),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      centerTitle: true,
    ),
  );
}