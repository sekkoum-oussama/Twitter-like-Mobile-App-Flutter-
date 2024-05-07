
import 'package:flutter/material.dart';


final customDarkTheme = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme.dark(
    primaryContainer: Colors.black,
    primary: Colors.blue
    ), 
  
  //iconTheme: const IconThemeData(color: Colors.white),
  expansionTileTheme: const ExpansionTileThemeData(textColor: Colors.white,),
  scaffoldBackgroundColor: Colors.black,
  canvasColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color.fromARGB(255, 11, 41, 66),
    contentTextStyle: TextStyle(
      color: Colors.white
    )
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
    unselectedItemColor: Colors.white,
    selectedItemColor: Colors.white
  ),
  dialogTheme: const DialogTheme(
    contentTextStyle: TextStyle(color: Colors.white, fontSize: 15.0),
    titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
  )
);