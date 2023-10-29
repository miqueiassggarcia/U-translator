import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart'; // import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  late String currentTheme;
  late ThemeMode themeMode;

  AppThemeProvider() {
    currentTheme = "Tema do sistema";
    themeMode = ThemeMode.system;
    getThemePreferences();
  }

  getThemePreferences() async {
    currentTheme = await ThemePreferences().getTheme();
    setMode(currentTheme);

    notifyListeners();
  }

  setMode(String theme) {
    if (theme == "Darkmode") {
      themeMode = ThemeMode.dark;
    } else if (theme == "Lightmode") {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.system;
    }
  }

  bool get isDarkMode {
    if (currentTheme != "Tema do sistema") {
      return currentTheme == "Darkmode";
    } else {
      var brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    }
  }

  void toggleTheme(String theme) {
    setMode(theme);
    currentTheme = theme;
    ThemePreferences().setTheme(theme);

    notifyListeners();
  }
}

class ThemePreferences {
  static const key = "themePreferences";

  void setTheme(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  Future<String> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? theme = sharedPreferences.getString(key);

    if (theme != null) {
      return theme;
    } else {
      return "Tema do sistema";
    }
  }
}
