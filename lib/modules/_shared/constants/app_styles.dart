import 'package:flutter/material.dart';

import 'app_color.dart';

class AppStyles {
  static AppStyles? _instance;
  // Avoid self instance
  AppStyles._();
  static AppStyles get instance => _instance ??= AppStyles._();

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        backgroundColor: AppColors.primary,
        textStyle: TextStyles.instance.textButtonLabel,
      );
}

extension AppStylesExtension on BuildContext {
  AppStyles get appStyles => AppStyles.instance;
}

class TextStyles {
  static TextStyles? _instance;
  // Avoid self instance
  TextStyles._();
  static TextStyles get instance => _instance ??= TextStyles._();

  String get fontFamily => 'mplus1';

  TextStyle get light => TextStyle(fontWeight: FontWeight.w300, fontFamily: fontFamily);

  TextStyle get regular => TextStyle(fontWeight: FontWeight.normal, fontFamily: fontFamily);

  TextStyle get medium => TextStyle(fontWeight: FontWeight.w500, fontFamily: fontFamily);

  TextStyle get semiBold => TextStyle(fontWeight: FontWeight.w600, fontFamily: fontFamily);

  TextStyle get bold => TextStyle(fontWeight: FontWeight.bold, fontFamily: fontFamily);

  TextStyle get extraBold => TextStyle(fontWeight: FontWeight.w800, fontFamily: fontFamily);

  TextStyle get textButtonLabel => extraBold.copyWith(fontSize: 14);

  TextStyle get textTitle => extraBold.copyWith(fontSize: 22);
}

extension TextStylesExtension on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}

class ThemeConfig {
  ThemeConfig._();

  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: BorderSide(width: 1, color: Colors.grey[400]!),
  );

  static final theme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secundary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppStyles.instance.primaryButton,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      contentPadding: EdgeInsets.all(20),
      border: _defaultInputBorder,
      focusedBorder: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      labelStyle: TextStyles.instance.regular.copyWith(color: Colors.black),
      errorStyle: TextStyles.instance.regular.copyWith(color: Colors.redAccent),
    ),
  );
}
