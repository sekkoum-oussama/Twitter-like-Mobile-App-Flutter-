import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_demo/users/data/models/user_model.dart';

class CurrentUserService {
  CurrentUserService(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  isUserAvailable() {
    return _sharedPreferences.containsKey("user");
  }

  saveCurrentUser(Map user) async {
    _sharedPreferences.setString("user", jsonEncode(user));
  }

  UserModel get user {
    return UserModel.fromJson(jsonDecode(_sharedPreferences.getString("user")!));
  }

}