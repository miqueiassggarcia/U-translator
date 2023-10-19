import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utranslator/provider/theme_controller.dart';
import 'package:utranslator/navigation/navigation.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        drawer: const Navigation(),
        appBar: AppBar(
          title: const Text('Configurações'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Container(
                  height: height! / 10,
                  width: width!,
                  child: SwitchListTile(
                    title: const Text("Mudar tema"),
                    value: themeProvider.isDarkMode,
                    secondary: themeProvider.isDarkMode
                        ? const Icon(Icons.dark_mode)
                        : const Icon(Icons.light_mode),
                    onChanged: (bool value) {
                      final provider =
                          Provider.of<AppThemeProvider>(context, listen: false);
                      provider.toggleTheme(value);
                    },
                  )),
            ])));
  }
}
