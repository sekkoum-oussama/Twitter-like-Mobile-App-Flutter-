import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_demo/twitter_app.dart';
import 'package:twitter_demo/utils/current_user_service.dart';


void customLogCallback(message) {

}

Future setUpGetIt() async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  GetIt.I.registerLazySingleton<CurrentUserService>(() => CurrentUserService(sharedPreferences));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  await setUpGetIt();
  FlutterFFmpegConfig().enableLogCallback(customLogCallback);
  runApp(TwitterApp());
}

