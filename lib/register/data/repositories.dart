import 'package:twitter_demo/register/data/data_providers.dart';

class RegisterRepository {
  static Future<Map<String, dynamic>> register(
      String email, String username, String password1, String password2) async {
    try {
      final res = await RegisterDataProvider.register(
          email, username, password1, password2);
      return {'statusCode': res.statusCode, 'body': res.body};
    } catch (e) {
      throw Exception();
    }
  }

  static Future<int> confirm_email(String key) async {
    try {
      final res = await RegisterDataProvider.confirm_email(key);
      return res.statusCode;
    } catch (e) {
      throw Exception();
    }
  }
}
