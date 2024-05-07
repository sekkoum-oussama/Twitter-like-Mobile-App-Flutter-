import 'package:http/http.dart' as http;
import 'package:twitter_demo/constants/constants.dart';


class PasswordResetDataProvider {
  static Future<http.Response> password_reset(String email) async {
    return await http.post(
      Uri.parse("http://$HOST/$PASSWORD_REST_URL"),
      body: {
        "email" : email,
      }
    );
  }

  static Future<http.Response> password_reset_confirm(email, token, new_password1, new_password2) async {
    return await http.post(
      Uri.parse("http://$HOST/$PASSWORD_REST_CONFIRM_URL"),
      body: {
        "email" : email,
        "token" : token,
        "new_password1" : new_password1,
        "new_password2" : new_password2
      }
    );   
  }
}