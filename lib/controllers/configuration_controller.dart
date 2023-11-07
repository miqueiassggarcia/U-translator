import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationController extends ChangeNotifier {
  late String inputLanguage;
  late String outputLanguage;

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
