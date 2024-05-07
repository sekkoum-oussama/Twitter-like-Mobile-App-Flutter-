import 'package:flutter/material.dart';

final customLightTheme = ThemeData.light().copyWith(
  colorScheme: const ColorScheme.light(
    primaryContainer: Colors.white,
    primary: Colors.blue
  ), 
  iconTheme: const IconThemeData(color: Colors.black),
  expansionTileTheme: const ExpansionTileThemeData(textColor: Colors.black,),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Colors.black87,
    contentTextStyle: TextStyle(
      color: Colors.white
    )
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
    unselectedItemColor: Colors.black,
    selectedItemColor: Colors.black
  ),
  dialogTheme: const DialogTheme(
    contentTextStyle: TextStyle(color: Colors.black, fontSize: 15.0),
    titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
    backgroundColor: Colors.white
  )
);