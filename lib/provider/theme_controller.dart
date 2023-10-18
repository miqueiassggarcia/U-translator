import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart'; // import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  late bool _themeIsDark;
  ThemeMode themeOfSystem = ThemeMode.system;

  AppThemeProvider() {
    _themeIsDark = false;
    getPreferences();
  }

  getPreferences() async {
    bool? theme = await ThemePreferences().getTheme();
    if (theme != null) {
      _themeIsDark = theme;
    } else if (SchedulerBinding
            .instance.platformDispatcher.platformBrightness ==
        Brightness.dark) {
      ThemePreferences().setTheme(true);
      _themeIsDark = true;
    } else {
      ThemePreferences().setTheme(false);
      _themeIsDark = false;
    }
    notifyListeners();
  }

  bool get isDarkMode {
    return _themeIsDark;
  }

  void toggleTheme(bool isOn) {
    _themeIsDark = isOn ? true : false;

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

    return theme;
  }
}
