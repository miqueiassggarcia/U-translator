import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart'; // import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode themeOfSystem = ThemeMode.system;

  AppThemeProvider() {
    getThemePreferences();
  }

  getThemePreferences() async {
    themeOfSystem = await ThemePreferences().getTheme();
  }

  bool get isDarkMode {
    return themeOfSystem == ThemeMode.dark;
  }

  void toggleTheme(String theme) {
    if (theme == "dark") {
      themeOfSystem = ThemeMode.dark;
    } else if (theme == "light") {
      themeOfSystem = ThemeMode.light;
    } else {
      themeOfSystem = ThemeMode.system;
    }
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

  Future<ThemeMode> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? theme = sharedPreferences.getString(key);

    if (theme != null) {
      if (theme == "dark") {
        return ThemeMode.dark;
      } else if (theme == "light") {
        return ThemeMode.light;
      } else {
        return ThemeMode.system;
      }
    } else {
      return ThemeMode.system;
    }
  }
}
