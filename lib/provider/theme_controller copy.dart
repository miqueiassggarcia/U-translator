// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AppThemeProvider extends ChangeNotifier {
//   ThemeMode themeMode = ThemeMode.light;

//   Future<void> getCurrentTheme() async {
//     ThemeMode currentTheme = await ThemePreferences().getTheme();
//     themeMode = currentTheme;
//   }

//   bool get isDarkMode => ThemeMode.dark == themeMode;

//   void changeTheme(bool darkThemeActive) {
//     if (darkThemeActive) {
//       themeMode = ThemeMode.dark;
//     } else {
//       themeMode = ThemeMode.light;
//     }

//     ThemePreferences().setTheme(darkThemeActive);
//     notifyListeners();
//   }
// }

// class ThemePreferences {
//   static const key = "themePreferences";

//   setTheme(bool value) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.setBool(key, value);
//   }

//   getTheme() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     bool? theme = sharedPreferences.getBool(key);

//     if (theme == null) {
//       // ThemeMode currentTheme = ThemeMode.system;

//       // if (currentTheme == ThemeMode.light) {
//       //   sharedPreferences.setBool(key, false);
//       // } else if (currentTheme == ThemeMode.dark) {
//       //   sharedPreferences.setBool(key, true);
//       // }

//       return ThemeMode.light;
//     } else if (theme) {
//       print("dark teste");
//       return ThemeMode.dark;
//     } else if (!theme) {
//       print("light teste");
//       return ThemeMode.light;
//     }
//   }
// }

// // class ThemeController extends ChangeNotifier {
// //   late bool _isDarkTheme;
// //   late ThemePreferences _preferences;

// //   bool get isDarkTheme => _isDarkTheme;

// //   ThemeController() {
// //     _preferences = ThemePreferences();
// //     _isDarkTheme = _preferences.getTheme();
// //     getPreferences();
// //   }

// //   getPreferences() async {
// //     _isDarkTheme = await _preferences.getTheme();
// //     notifyListeners();
// //   }

// //   setPreferences(bool value) async {
// //     _isDarkTheme = await _preferences.setTheme(value);
// //     notifyListeners();
// //   }
// // }