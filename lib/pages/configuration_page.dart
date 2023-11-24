import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utranslator/provider/theme_controller.dart';
import 'package:utranslator/controllers/configuration_controller.dart';
import 'package:utranslator/navigation/navigation.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  double? height;
  double? width;
  ConfigurationController controller = ConfigurationController();

  @override
  void initState() {
    super.initState();
    controller.changeIfLanguageSelected();
    controller.addListener(() {
      setState(() {});
    });
  }

  List<String> themeItems = ["Sistema", "Darkmode", "Lightmode"];

  List<String> languageItems = [
    "Africâner",
    "Albanês",
    "Alemão",
    "Amárico",
    "Árabe",
    "Armênio",
    "Assamês",
    "Aymara",
    "Azerbaijano",
    "Bambara",
    "Basco",
    "Bengalês",
    "Bielorrusso",
    "Birmanês",
    "Boiapuri",
    "Bósnio",
    "Búlgaro",
    "Canarês",
    "Catalão",
    "Cazaque",
    "Cebuano",
    "Chichewa",
    "Chinês (simp)",
    "Chinês (trad)",
    "Cingalês",
    "Cmer",
    "Concani",
    "Coreano",
    // "Coreano",
    "Córsico",
    "Croata",
    "Curdo",
    "Curdo (Sorani)",
    "Divehi",
    "Dogri",
    "Escocês",
    "Eslovaco",
    "Esloveno",
    "Espanhol",
    "Esperanto",
    "Estoniano",
    "Ewe",
    "Filipino",
    // "Filipino",
    "Finlandês",
    "Francês",
    "Frísio",
    "Galego",
    "Galês",
    "Georgiano",
    "Grego",
    "Guarani",
    "Gujarati",
    "Haitiano",
    "Hauçá",
    "Havaiano",
    "Hebraico",
    "Hindi",
    "Hmong",
    "Holandês",
    "Húngaro",
    "Ídiche",
    "Igbo",
    "Ilocano",
    "Indonésio",
    "Inglês",
    "Iorubá",
    "Irlandês",
    "Islandês",
    "Italian",
    "Japonês",
    "Javanês",
    "Krio",
    "Laosiano",
    "Latim",
    "Letão",
    "Lingala",
    "Lituano",
    "Luganda",
    "Luxemburguês",
    "Macedônio",
    "Maithili",
    "Malaiala",
    "Malaio",
    "Malgaxe",
    "Maltês",
    "Manipuri",
    "Maori",
    "Marata",
    "Mizo",
    "Mongol",
    "Nepalês",
    "Norueguês",
    "Oriá",
    "Oromo",
    "Pashto",
    "Persa",
    "Polonês",
    "Português",
    "Punjabi",
    "Quíchua",
    "Quiniaruanda",
    "Quirguiz",
    "Romeno",
    "Russo",
    "Samoano",
    "Sânscrito",
    "Sepedi",
    "Sérvio",
    "Sesoto",
    "Sindi",
    "Somali",
    "Suaíli",
    "Sueco",
    "Sundanês",
    "Tailandês",
    "Tajique",
    "Tâmil",
    "Tártaro",
    "Tcheco",
    "Telugu",
    "Tigrínia",
    "Tsonga",
    "Turco",
    "Turcomano",
    "Twi",
    "Ucraniano",
    "Urdu",
    "Usbeque",
    "Uyghur",
    "Vietnamita",
    "Xona",
    "Xosa",
    "Zulu",
  ];

  @override
  Widget build(BuildContext context) {
    String? selectedOutputLanguage = controller.outputLanguage;

    final themeProvider = Provider.of<AppThemeProvider>(context);
    String? selectedItem = themeProvider.currentTheme;

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

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
                          width: width! / 2.1,
                          child: const Center(
                              child: Text("Tema padrão",
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center)))),
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
                                                style: const TextStyle(
                                                    fontSize: 18)),
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
                                            themeProvider.toggleTheme("Sistema")
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
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: height! / 10,
                          width: width! / 2.1,
                          child: const Center(
                              child: Text(
                            "Linguagem de tradução",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          )))),
                  Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: height! / 10,
                          width: width! / 2.1,
                          child: Center(
                              child: DropdownButton<String>(
                                  value: selectedOutputLanguage,
                                  items: languageItems
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item,
                                                style: const TextStyle(
                                                    fontSize: 18)),
                                          ))
                                      .toList(),
                                  onChanged: (item) => setState(() => controller
                                      .changeOutputLanguage(item!)))))),
                ],
              ),
            ]));
  }
}
