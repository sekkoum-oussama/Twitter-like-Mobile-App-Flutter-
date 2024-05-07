import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:twitter_demo/users/data/models/user_model.dart';

Future<UserModel> loadUserInfo() async {
  final storage = new FlutterSecureStorage();
  String?  userString = await storage.read(key: "user");
  UserModel userModel = UserModel.fromJson(jsonDecode(userString!));
  return userModel;
}