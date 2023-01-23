import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: const Color(0xff333739),
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff333739),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Color(0xff333739),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color(0xff333739),
    unselectedItemColor: Colors.grey,
    selectedItemColor: defaultColor,
    selectedIconTheme: IconThemeData(
      color: defaultColor,
      size: 25,
    ),
    selectedLabelStyle: TextStyle(
      fontSize: 18,
      color: defaultColor,
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.grey,
    ),
    elevation: 20.0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  fontFamily: 'Jannah',
  cardTheme: CardTheme(
    color: const Color(0xff333739),
    elevation: 8.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: defaultColor,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: defaultColor,
    unselectedLabelColor: Colors.grey,
    labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    unselectedLabelStyle:
        const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
    indicator: BoxDecoration(
      border: const Border(
        top: BorderSide(width: 4.0, color: defaultColor),
        left: BorderSide(width: 4.0, color: defaultColor),
        right: BorderSide(width: 4.0, color: defaultColor),
        bottom: BorderSide(width: 4.0, color: defaultColor),
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    backgroundColor: const Color(0xff333739),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
);

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xff333739),
    unselectedItemColor: Colors.grey,
    selectedItemColor: defaultColor,
    selectedIconTheme: IconThemeData(
      size: 25,
    ),
    selectedLabelStyle: TextStyle(fontSize: 18, color: defaultColor),
    unselectedIconTheme: IconThemeData(color: Colors.grey),
    elevation: 20.0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  fontFamily: 'Jannah',
);
