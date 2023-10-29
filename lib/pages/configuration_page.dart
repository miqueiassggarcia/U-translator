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

  List<String> themeItems = ["Tema do sistema", "Darkmode", "Lightmode"];

  List<String> languageItems = ["Português", "Inglês", "Espanhol", "Frânces"];
  String? selectedInputLanguage = "Inglês";
  String? selectedOutputLanguage = "Português";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    String? selectedItem = themeProvider.currentTheme;

    return Scaffold(
        drawer: const Navigation(),
        appBar: AppBar(
          title: const Text('Configurações'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment
                .start, // Center the content vertically within the Column.
            crossAxisAlignment: CrossAxisAlignment
                .center, // Center the content horizontally within the Column.
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                          height: height! / 10,
                          width: width! / 2.2,
                          child: Center(
                              child: Text("Tema padrão",
                                  style: TextStyle(fontSize: 24))))),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                          height: height! / 10,
                          width: width! / 2.1,
                          child: Center(
                              child: DropdownButton<String>(
                                  value: selectedItem,
                                  items: themeItems
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item,
                                                style: TextStyle(fontSize: 20)),
                                          ))
                                      .toList(),
                                  onChanged: (item) => setState(() => {
                                        if (item == "Darkmode")
                                          {
                                            themeProvider
                                                .toggleTheme("Darkmode")
                                          }
                                        else if (item == "Lightmode")
                                          {
                                            themeProvider
                                                .toggleTheme("Lightmode")
                                          }
                                        else
                                          {
                                            themeProvider
                                                .toggleTheme("Tema do sistema")
                                          },
                                        selectedItem = item
                                      }))))),
                ],
              ),
              const Divider(
                color: Colors.black54,
                indent: 15,
                endIndent: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                          height: height! / 10,
                          width: width!,
                          child: Center(
                              child: Text("Seleção de linguagens",
                                  style: TextStyle(fontSize: 24))))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                          height: height! / 10,
                          width: width! / 2.2,
                          child: Center(
                              child: DropdownButton<String>(
                                  value: selectedInputLanguage,
                                  items: languageItems
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item,
                                                style: TextStyle(fontSize: 20)),
                                          ))
                                      .toList(),
                                  onChanged: (item) => setState(
                                      () => selectedInputLanguage = item))))),
                  const Icon(Icons.arrow_forward),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                          height: height! / 10,
                          width: width! / 2.2,
                          child: Center(
                              child: DropdownButton<String>(
                                  value: selectedOutputLanguage,
                                  items: languageItems
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item,
                                                style: TextStyle(fontSize: 20)),
                                          ))
                                      .toList(),
                                  onChanged: (item) => setState(
                                      () => selectedOutputLanguage = item))))),
                ],
              ),
            ]));
  }
}
