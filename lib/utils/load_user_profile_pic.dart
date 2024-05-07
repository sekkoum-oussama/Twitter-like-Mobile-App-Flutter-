import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

  Future<String> loadUserPic() async {
  final storage = new FlutterSecureStorage();
  String?  userString = await storage.read(key: "user");
  String userPic = jsonDecode(userString!)["avatar"];
  return userPic;
}