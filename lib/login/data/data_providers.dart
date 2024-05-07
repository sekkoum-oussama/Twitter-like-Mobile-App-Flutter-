import 'package:http/http.dart' as http;
import 'package:twitter_demo/constants/constants.dart';

class LoginDataProvider {
  static Future<http.Response> login(String email, String password) async {
    return await http.post(
      Uri.parse("http://$HOST/$LOGIN_URL"),
      body: {
        "email" : email,
        "password" : password
      }
    );
  }
}
