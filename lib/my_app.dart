import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utranslator/provider/theme_controller.dart';
import 'package:utranslator/pages/initial_page.dart';
import 'package:utranslator/provider/theme_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => AppThemeProvider(),
        builder: (context, _) {
          final themeController = Provider.of<AppThemeProvider>(context);
          
          return MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const InitialPage(),
          );
        },
      );
}
