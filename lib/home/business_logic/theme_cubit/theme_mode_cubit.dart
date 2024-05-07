import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_cubit_state.dart';

class ThemeCubit extends Cubit<ThemeModeInfo> {
  String _themeModeKey = "themeMode";

  ThemeCubit() : super(ThemeModeInfo());

  getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int themeModeIndex =  prefs.getInt(_themeModeKey) ?? 0;
    emit(ThemeModeInfo(ThemeMode.values[themeModeIndex]));
  }

  setTheme(ThemeMode themeMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, ThemeMode.values.indexOf(themeMode));
    emit(ThemeModeInfo(themeMode));
  }
}
