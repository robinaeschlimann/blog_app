import 'package:blog_app/service/theme_notifier.dart';
import 'package:flutter/material.dart';

class BlogTheme
{
  static ThemeData getTheme( BrightnessNotifier brightnessNotifier )
  {
    const primaryColor = Color(0xFFC5264E);
    const secondaryColor = Colors.white;
    const inactiveColor = Colors.white70;

    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        secondary: secondaryColor,
        brightness: brightnessNotifier.brightness,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        titleTextStyle: TextStyle(
          color: secondaryColor,
          fontSize: 20,
        ),
        foregroundColor: inactiveColor,
      ),
      tabBarTheme: TabBarTheme(
        overlayColor: MaterialStateProperty.all(primaryColor),
        labelColor: secondaryColor,
        unselectedLabelColor: inactiveColor,

        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 4.0,
            color: secondaryColor,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: inactiveColor,
        shape: CircleBorder(),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryColor,
      ),
      dividerTheme: const DividerThemeData(
        color: primaryColor,
        thickness: 1,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(brightnessNotifier.brightness == Brightness.light ? Colors.grey.shade600 : inactiveColor),
        trackColor: MaterialStateProperty.all(brightnessNotifier.brightness == Brightness.light ? secondaryColor : primaryColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          foregroundColor: MaterialStateProperty.all(secondaryColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

}