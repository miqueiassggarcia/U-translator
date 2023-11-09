import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationController extends ChangeNotifier {
  late String inputLanguage;
  late String outputLanguage;

  Map<String, dynamic> languagesCodes = {
    "Africâner": "af",
    "Albanês": "sq",
    "Amárico": "am",
    "Árabe": "ar",
    "Armênio": "hy",
    "Assamês": "as",
    "Aymara": "ay",
    "Azerbaijano": "az",
    "Bambara": "bm",
    "Basco": "eu",
    "Bielorrusso": "be",
    "Bengalês": "bn",
    "Boiapuri": "bho",
    "Bósnio": "bs",
    "Búlgaro": "bg",
    "Catalão": "ca",
    "Cebuano": "ceb",
    "Chinês (simp)": "zh-CN",
    "Chinês (trad)": "zh-TW",
    "Córsico": "co",
    "Croata": "hr",
    "Tcheco": "cs",
    "Coreano": "da",
    "Divehi": "dv",
    "Dogri": "doi",
    "Holandês": "nl",
    "Inglês": "en",
    "Esperanto": "eo",
    "Estoniano": "et",
    "Ewe": "ee",
    "Filipino": "fil",
    "Finlandês": "fi",
    "Francês": "fr",
    "Frísio": "fy",
    "Galego": "gl",
    "Georgiano": "ka",
    "Alemão": "de",
    "Grego": "el",
    "Guarani": "gn",
    "Gujarati": "gu",
    "Haitiano": "ht",
    "Hauçá": "ha",
    "Havaiano": "haw",
    "Hebraico": "he",
    "Hindi": "hi",
    "Hmong": "hmn",
    "Húngaro": "hu",
    "Islandês": "is",
    "Igbo": "ig",
    "Ilocano": "ilo",
    "Indonésio": "id",
    "Irlandês": "ga",
    "Italian": "it",
    "Japonês": "ja",
    "Javanês": "jv",
    "Canarês": "kn",
    "Cazaque": "kk",
    "Cmer": "km",
    "Quiniaruanda": "rw",
    "Concani": "gom",
    // "Coreano": "ko",
    "Krio": "kri",
    "Curdo": "ku",
    "Curdo (Sorani)": "ckb",
    "Quirguiz": "ky",
    "Laosiano": "lo",
    "Latim": "la",
    "Letão": "lv",
    "Lingala": "ln",
    "Lituano": "lt",
    "Luganda": "lg",
    "Luxemburguês": "lb",
    "Macedônio": "mk",
    "Maithili": "mai",
    "Malgaxe": "mg",
    "Malaio": "ms",
    "Malaiala": "ml",
    "Maltês": "mt",
    "Maori": "mi",
    "Marata": "mr",
    "Manipuri": "mni-Mtei",
    "Mizo": "lus",
    "Mongol": "mn",
    "Birmanês": "my",
    "Nepalês": "ne",
    "Norueguês": "no",
    "Chichewa": "ny",
    "Oriá": "or",
    "Oromo": "om",
    "Pashto": "ps",
    "Persa": "fa",
    "Polonês": "pl",
    "Português": "pt",
    "Punjabi": "pa",
    "Quíchua": "qu",
    "Romeno": "ro",
    "Russo": "ru",
    "Samoano": "sm",
    "Sânscrito": "sa",
    "Escocês": "gd",
    "Sepedi": "nso",
    "Sérvio": "sr",
    "Sesoto": "st",
    "Xona": "sn",
    "Sindi": "sd",
    "Cingalês": "si",
    "Eslovaco": "sk",
    "Esloveno": "sl",
    "Somali": "so",
    "Espanhol": "es",
    "Sundanês": "su",
    "Suaíli": "sw",
    "Sueco": "sv",
    // "Filipino": "tl",
    "Tajique": "tg",
    "Tâmil": "ta",
    "Tártaro": "tt",
    "Telugu": "te",
    "Tailandês": "th",
    "Tigrínia": "ti",
    "Tsonga": "ts",
    "Turco": "tr",
    "Turcomano": "tk",
    "Twi": "ak",
    "Ucraniano": "uk",
    "Urdu": "ur",
    "Uyghur": "ug",
    "Usbeque": "uz",
    "Vietnamita": "vi",
    "Galês": "cy",
    "Xosa": "xh",
    "Ídiche": "yi",
    "Iorubá": "yo",
    "Zulu": "zu"
  };

  String get getCodeFromInputLanguage {
    return languagesCodes[inputLanguage];
  }

  String get getCodeFromOutputLanguage {
    return languagesCodes[outputLanguage];
  }

  static const _keyInputLanguage = 'imput_language';
  static const _keyOutputLanguage = 'output_language';

  ConfigurationController() {
    inputLanguage = "Inglês";
    outputLanguage = "Português";
    changeIfLanguageSelected();
  }

  changeIfLanguageSelected() async {
    String inputLang = await getInputLanguage();
    String outputLang = await getOutputLanguage();

    inputLanguage = inputLang;
    outputLanguage = outputLang;

    notifyListeners();
  }

  changeInputLanguage(String language) {
    inputLanguage = language;
    setInputLanguage(language);

    notifyListeners();
  }

  changeOutputLanguage(String language) {
    outputLanguage = language;
    setOutputLanguage(language);

    notifyListeners();
  }

  Future<void> setInputLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_keyInputLanguage, language);
  }

  Future<String> getInputLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString(_keyInputLanguage);

    if (language != null) {
      return language;
    } else {
      setInputLanguage("Inglês");
      return "Inglês";
    }
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
