import 'package:flutter/material.dart';
import '../helpers/custom_route.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade900,
      colorScheme: ColorScheme.dark(),
      primarySwatch: Colors.purple,
      accentColor: Colors.deepOrange,
      fontFamily: 'Lato',
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.android: CustomPageTransitionBuilder(),
        TargetPlatform.iOS: CustomPageTransitionBuilder(),
      }));

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(),
      primarySwatch: Colors.purple,
      accentColor: Colors.deepOrange,
      fontFamily: 'Lato',
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.android: CustomPageTransitionBuilder(),
        TargetPlatform.iOS: CustomPageTransitionBuilder(),
      }));
}
