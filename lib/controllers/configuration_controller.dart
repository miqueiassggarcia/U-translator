import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationController extends ChangeNotifier {
  late String outputLanguage;

  Map<String, dynamic> languagesCodes = {
    "Africâner": "af",
    "Albanês": "sq",
    "Alemão": "de",
    "Amárico": "am",
    "Árabe": "ar",
    "Armênio": "hy",
    "Assamês": "as",
    "Aymara": "ay",
    "Azerbaijano": "az",
    "Bambara": "bm",
    "Basco": "eu",
    "Bengalês": "bn",
    "Bielorrusso": "be",
    "Birmanês": "my",
    "Boiapuri": "bho",
    "Bósnio": "bs",
    "Búlgaro": "bg",
    "Canarês": "kn",
    "Catalão": "ca",
    "Cazaque": "kk",
    "Cebuano": "ceb",
    "Chichewa": "ny",
    "Chinês (simp)": "zh-CN",
    "Chinês (trad)": "zh-TW",
    "Cingalês": "si",
    "Cmer": "km",
    "Concani": "gom",
    "Coreano": "da",
    // "Coreano": "ko",
    "Córsico": "co",
    "Croata": "hr",
    "Curdo": "ku",
    "Curdo (Sorani)": "ckb",
    "Divehi": "dv",
    "Dogri": "doi",
    "Escocês": "gd",
    "Eslovaco": "sk",
    "Esloveno": "sl",
    "Espanhol": "es",
    "Esperanto": "eo",
    "Estoniano": "et",
    "Ewe": "ee",
    "Filipino": "fil",
    // "Filipino": "tl",
    "Finlandês": "fi",
    "Francês": "fr",
    "Frísio": "fy",
    "Galego": "gl",
    "Galês": "cy",
    "Georgiano": "ka",
    "Grego": "el",
    "Guarani": "gn",
    "Gujarati": "gu",
    "Haitiano": "ht",
    "Hauçá": "ha",
    "Havaiano": "haw",
    "Hebraico": "he",
    "Hindi": "hi",
    "Hmong": "hmn",
    "Holandês": "nl",
    "Húngaro": "hu",
    "Ídiche": "yi",
    "Igbo": "ig",
    "Ilocano": "ilo",
    "Indonésio": "id",
    "Inglês": "en",
    "Iorubá": "yo",
    "Irlandês": "ga",
    "Islandês": "is",
    "Italian": "it",
    "Japonês": "ja",
    "Javanês": "jv",
    "Krio": "kri",
    "Laosiano": "lo",
    "Latim": "la",
    "Letão": "lv",
    "Lingala": "ln",
    "Lituano": "lt",
    "Luganda": "lg",
    "Luxemburguês": "lb",
    "Macedônio": "mk",
    "Maithili": "mai",
    "Malaiala": "ml",
    "Malaio": "ms",
    "Malgaxe": "mg",
    "Maltês": "mt",
    "Manipuri": "mni-Mtei",
    "Maori": "mi",
    "Marata": "mr",
    "Mizo": "lus",
    "Mongol": "mn",
    "Nepalês": "ne",
    "Norueguês": "no",
    "Oriá": "or",
    "Oromo": "om",
    "Pashto": "ps",
    "Persa": "fa",
    "Polonês": "pl",
    "Português": "pt",
    "Punjabi": "pa",
    "Quíchua": "qu",
    "Quiniaruanda": "rw",
    "Quirguiz": "ky",
    "Romeno": "ro",
    "Russo": "ru",
    "Samoano": "sm",
    "Sânscrito": "sa",
    "Sepedi": "nso",
    "Sérvio": "sr",
    "Sesoto": "st",
    "Sindi": "sd",
    "Somali": "so",
    "Suaíli": "sw",
    "Sueco": "sv",
    "Sundanês": "su",
    "Tailandês": "th",
    "Tajique": "tg",
    "Tâmil": "ta",
    "Tártaro": "tt",
    "Tcheco": "cs",
    "Telugu": "te",
    "Tigrínia": "ti",
    "Tsonga": "ts",
    "Turco": "tr",
    "Turcomano": "tk",
    "Twi": "ak",
    "Ucraniano": "uk",
    "Urdu": "ur",
    "Usbeque": "uz",
    "Uyghur": "ug",
    "Vietnamita": "vi",
    "Xona": "sn",
    "Xosa": "xh",
    "Zulu": "zu",
  };

  String get getCodeFromOutputLanguage {
    return languagesCodes[outputLanguage];
  }

  static const _keyOutputLanguage = 'output_language';

  ConfigurationController() {
    outputLanguage = "Português";
    changeIfLanguageSelected();
  }

  changeIfLanguageSelected() async {
    String outputLang = await getOutputLanguage();

    outputLanguage = outputLang;

    notifyListeners();
  }

  changeOutputLanguage(String language) {
    outputLanguage = language;
    setOutputLanguage(language);

    notifyListeners();
  }

  Future<void> setOutputLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_keyOutputLanguage, language);
  }

  Future<String> getOutputLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString(_keyOutputLanguage);

    if (language != null) {
      return language;
    } else {
      setOutputLanguage("Português");
      return "Português";
    }
  }
}
