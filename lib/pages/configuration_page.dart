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

  List<String> items = ["Tema do sistema", "Darkmode", "Lightmode"];

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
                          width: width! / 2,
                          child: Center(
                              child: Text("Tema padrão",
                                  style: TextStyle(fontSize: 24))))),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                          height: height! / 10,
                          width: width! / 2,
                          child: Center(
                              child: DropdownButton<String>(
                                  value: selectedItem,
                                  items: items
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                          height: height! / 10,
                          width: width! / 2,
                          child: Center(
                              child: Text("Tema padrão",
                                  style: TextStyle(fontSize: 24))))),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                          height: height! / 10,
                          width: width! / 2,
                          child: Center(
                              child: DropdownButton<String>(
                                  value: selectedItem,
                                  items: items
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item,
                                                style: TextStyle(fontSize: 20)),
                                          ))
                                      .toList(),
                                  onChanged: (item) => setState(() => {
                                        if (item == "Darkmode")
                                          {themeProvider.toggleTheme("dark")}
                                        else if (item == "Lightmode")
                                          {themeProvider.toggleTheme("light")}
                                        else
                                          {themeProvider.toggleTheme("system")},
                                        selectedItem = item
                                      }))))),
                ],
              )
            ]));
  }
}


// Container(
//                   height: height! / 10,
//                   width: width!,
//                   child: SwitchListTile(
//                     title: const Text("Mudar tema"),
//                     value: themeProvider.isDarkMode,
//                     secondary: themeProvider.isDarkMode
//                         ? const Icon(Icons.dark_mode)
//                         : const Icon(Icons.light_mode),
//                     onChanged: (bool value) {
//                       final provider =
//                           Provider.of<AppThemeProvider>(context, listen: false);
//                       provider.toggleTheme(value);
//                     },
//                   )),


// [
//               Container(
//                   height: height! / 10,
//                   width: width!,
//                   child: DropdownButton<String>(
//                       value: selectedItem,
//                       items: items
//                           .map((item) => DropdownMenuItem<String>(
//                                 value: item,
//                                 child:
//                                     Text(item, style: TextStyle(fontSize: 24)),
//                               ))
//                           .toList(),
//                       onChanged: (item) =>
//                           setState(() => selectedItem = item))),
//             ]