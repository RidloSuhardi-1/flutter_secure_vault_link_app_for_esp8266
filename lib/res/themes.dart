import 'package:flutter/material.dart';

import 'colors/color.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: kBackgroundColor,
    fontFamily: 'Inter',
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0),
            overlayColor:
                MaterialStateProperty.all<Color>(Colors.transparent))),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kBackgroundColor),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    toolbarTextStyle: TextStyle(color: Colors.white, fontSize: 18),
    // toolbarHeight: 68,
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyLarge: TextStyle(color: kTitleColor),
    bodyMedium: TextStyle(color: kTextColor),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(width: 1.0, color: kSecondaryColor),
    borderRadius: BorderRadius.circular(6.0),
  );

  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 11.0),
    hintStyle: const TextStyle(
        color: kSecondaryColor, fontSize: 12.0, fontWeight: FontWeight.w500),
    helperStyle: const TextStyle(color: kSecondaryColor, fontSize: 12.0),
    errorStyle: const TextStyle(color: kRedColor, fontSize: 12.0),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: kRedColor, width: 1.0),
      borderRadius: BorderRadius.circular(6.0),
    ),
    prefixStyle: const TextStyle(
      color: kTextColor,
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
    ),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
    isDense: true,
  );
}
