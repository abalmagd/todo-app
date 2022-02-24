import 'package:flutter/material.dart';
import 'package:todo_app/theme/palette.dart';

class CustomTheme {
  static ThemeData darkTheme(BuildContext context) {
    final theme = Theme.of(context);
    return ThemeData(
      scaffoldBackgroundColor: Palette.darkGrey,
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        primarySwatch: MaterialColor(
          Palette.blue500.value,
          const {
            100: Palette.blue100,
            200: Palette.blue200,
            300: Palette.blue300,
            400: Palette.blue400,
            500: Palette.blue500,
            600: Palette.blue600,
            700: Palette.blue700,
            800: Palette.blue800,
            900: Palette.blue900,
          },
        ),
        accentColor: Palette.blue500,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 2,
        color: Palette.blue500,
      ),
      textTheme: theme.primaryTextTheme
          .copyWith(
        button: theme.primaryTextTheme.button?.copyWith(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      )
          .apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Palette.blue500,
        ),
      ),
    );
  }

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData();
  }
}