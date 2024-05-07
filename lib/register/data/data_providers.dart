import 'package:twitter_demo/constants/constants.dart';
import 'package:http/http.dart' as http;


class RegisterDataProvider  {

  static Future<http.Response> register(String email, String username, String password1, String password2) async {
    return  await http.post(
      Uri.parse("http://$HOST/$USER_REGISTER_URL"),
      body: {
        "email" : email,
        "username" : username,
        "password1" : password1,
        "password2" : password2,
      }
    );
  }

  static Future<http.Response> confirm_email(String key) async {
    return await http.post(
      Uri.parse("http://$HOST/$USER_CONFIRM_EMAIL_URL"),
      body: {
        "key" : key
      }
      );
  }

  static Future<http.Response> resend_email_verification(String email) async {
    return await http.post(
      Uri.parse("http://$HOST/$RESEND_EMAIL_VERIFICATION_URL"),
      body: {
        "email" : email
      }
    );
  }
}