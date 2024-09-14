import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryLightColor = const Color(0xff5D9CEC);
  static Color selectedDayColor = const Color(0xffAFDBF5);
  static Color whiteColor = const Color(0xffffffff);
  static Color greenColor = const Color(0xff61E757);
  static Color redColor = const Color(0xffEC4B4B);
  static Color blackColor = const Color(0xff383838);
  static Color blackTextColor = const Color(0xff060E1E);
  static Color greyColor = const Color(0xff7a7a7b);
  static Color backgroundLight = const Color(0xffDFECDB);
  static Color backgroundDark = const Color(0xff060E1E);
  static Color blackDark = const Color(0xff141922);

  static ThemeData lightMode = ThemeData(
      scaffoldBackgroundColor: backgroundLight,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryLightColor,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryLightColor,
          unselectedItemColor: greyColor,
          elevation: 0,
          backgroundColor: Colors.transparent),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryLightColor,
          shape: StadiumBorder(
              side: BorderSide(
            width: 4,
            color: whiteColor,
          ))),
      textTheme: TextTheme(
        titleLarge: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: whiteColor),
        titleMedium: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: blackColor),
        titleSmall: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: blackColor),
      ));

  static ThemeData darkMode = ThemeData(
      scaffoldBackgroundColor: backgroundDark,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryLightColor,
        elevation: 0,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
          elevation: 20, shadowColor: whiteColor, color: blackDark),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryLightColor,
          unselectedItemColor: whiteColor,
          elevation: 2,
          backgroundColor: Colors.transparent),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryLightColor,
          shape: StadiumBorder(
              side: BorderSide(
            width: 4,
            color: blackDark,
          ))),
      textTheme: TextTheme(
        titleLarge: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: whiteColor),
        titleMedium: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: whiteColor),
        titleSmall: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: whiteColor),
      ));
}
