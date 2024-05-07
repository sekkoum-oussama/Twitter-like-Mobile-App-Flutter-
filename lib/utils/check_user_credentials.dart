import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_demo/constants/constants.dart';


final storage = new FlutterSecureStorage();

Future<dynamic> is_logged_in() async {
  try {
    String? token = await storage.read(key: "token");
    if(token != null) {
      http.Response res = await http.post(
        Uri.parse("http://$HOST/$TOKEN_VERIFY_URL"),
        body: {"token" : token}
        );
      if(res.statusCode==200) {
        return token;
      } else {
        return await refresh_token();
      }
    } else {
      return false;
    }
  } catch(e) {
    return false;
  }

}

Future<dynamic> refresh_token() async {
      String? refresh = await storage.read(key: "refresh_token");
      if(refresh != null) {
        http.Response res = await http.post(
          Uri.parse("http://$HOST/$TOKEN_REFRESH_URL"),
          body: {"refresh" : refresh}
        );
        if(res.statusCode==200) {
          String new_token = jsonDecode(res.body)["access"];
          await storage.write(key: "token", value: new_token);
          return new_token;
        } else {
          return false;
        }
      } else {
        return false;
      }
}

Future<bool> log_out() async {
   await storage.delete(key: "token");
   await storage.delete(key: "refresh_token");
   await storage.delete(key: "user");
   return true;
}