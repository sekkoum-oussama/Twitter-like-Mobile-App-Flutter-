import 'package:http/http.dart' as http;
import 'package:twitter_demo/login/data/data_providers.dart';

class LoginRepository {
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      http.Response res = await LoginDataProvider.login(email, password);
      return {
        "statuscode" : res.statusCode,
        "body" : res.body
      };
    } catch(e) {
      print(e.toString());
      throw Exception();
    }
  }
}