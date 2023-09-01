import 'package:flutter/material.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Configurações'),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      centerTitle: true,
    ),
  );
}