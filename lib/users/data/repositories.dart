import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_demo/register/data/data_providers.dart';
import 'package:twitter_demo/users/data/data_providers.dart';
import 'package:twitter_demo/users/data/models/user_model.dart';
import 'package:twitter_demo/utils/current_user_service.dart';
import 'package:twitter_demo/utils/custom_exceptions.dart';

class UsersRepository {
  static Future<UserModel> getUser(userUrl) async {
    try {
      final res = await UsersDataProvider.getUser(userUrl);
      if(res.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(res.body));
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  static Future<bool> followUser(String username) async {
    try {
      Response response = await UsersDataProvider.followUser(username);
      if(response.statusCode == 201) {
        return true;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  static Future<bool> unfollowUser(String username) async {
    try {
      Response response = await UsersDataProvider.unfollowUser(username);
      if(response.statusCode == 200) {
        return true;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  static Future<List> getFollowers(String username) async {
    
    Response response = await UsersDataProvider.getFollowers(username);
    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if(response.statusCode == 404){
      throw UserNotFoundException();
    } else {
      throw Exception();
    }
  }

  static Future<List> getFollowings(String username) async {
    
    Response response = await UsersDataProvider.getFollowings(username);
    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if(response.statusCode == 404){
      throw UserNotFoundException();
    } else {
      throw Exception();
    }
  }

  static Future updateUser(String username, Map<String, String> newValues, {List? files}) async {
    try {
      final Response response = await UsersDataProvider.updateUser(username, newValues, files: files);
      if(response.statusCode == 404) {
        throw UserNotFoundException();
      } else if(response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("user", response.body);
        return UserModel.fromJson(jsonDecode(response.body));
      } else if(response.statusCode == 400) {
        throw UpdateUserFieldErrorException(jsonDecode(response.body));
      } 
      else {
        throw Exception();
      }
    } catch(e) {
      rethrow;
    }
  }
}