import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twitter_demo/password_reset/data/data_providers.dart';

class PasswordResetRepository {
  static Future<int> password_reset(String email) async {
    try {
      http.Response res = await PasswordResetDataProvider.password_reset(email);
      return res.statusCode;
    } catch(e) {
      throw Exception();
    }
    
  }

  static Future<Map<String, dynamic>> password_reset_confirm(email, token, new_password1, new_password2) async {
    try {
      http.Response res = await PasswordResetDataProvider.password_reset_confirm(email, token, new_password1, new_password2);
      return {
        'status_code' : res.statusCode,
        'content' : res.body
      };
    } catch(e) {
      throw Exception();
    }
    
  }
}