import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart'; // import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  Future<ThemeMode> getLastThemeSetted() async {
    return ThemePreferences().getTheme();
  }

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    ThemePreferences().setTheme(isOn);
    notifyListeners();
  }
}

class ThemePreferences {
  static const key = "themePreferences";

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(key, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? theme = sharedPreferences.getBool(key);

    if (theme == null) {
      return ThemeMode.system;
    } else if (theme) {
      return ThemeMode.dark;
    } else if (!theme) {
      return ThemeMode.light;
    }
  }
}
