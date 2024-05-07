
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_demo/constants/constants.dart';
import 'package:twitter_demo/utils/check_user_credentials.dart';


class UsersDataProvider {
  
  static Future<http.Response> getUser(String userUrl) async {
    String token = await is_logged_in() ?? '';
    return await http.get(
      Uri.parse(userUrl),
      headers: {
        'authorization' : 'Bearer $token',
      }
    );
  }

  static Future followUser(String username) async {
    String token = await is_logged_in() ?? '';
    return await http.post(
      Uri.parse("http://$HOST/$USER_FOLLOW$username/"),
      headers: {
        'authorization' : 'Bearer $token',
      }
    );
  }

  static Future unfollowUser(String username) async {
    String token = await is_logged_in() ?? '';
    return await http.post(
      Uri.parse("http://$HOST/$USER_UNFOLLOW$username/"),
      headers: {
        'authorization' : 'Bearer $token',
      }
    );
  }

  static Future getFollowers(String username) async {
    String token = await is_logged_in() ?? '';
    return await http.get(
      Uri.parse("http://$HOST/users/$username/followers/"),
      headers: {
        'authorization' : 'Bearer $token',
      }
    );
  }

  static Future getFollowings(String username) async {
    String token = await is_logged_in() ?? '';
    return await http.get(
      Uri.parse("http://$HOST/users/$username/following/"),
      headers: {
        'authorization' : 'Bearer $token',
      }
    );
  }

  static Future updateUser(String username, Map<String, String> newValues, {List? files}) async {
    String token = await is_logged_in() ?? '';

    final request = http.MultipartRequest("PATCH", Uri.parse("http://$HOST/users/$username/"))
    ..headers.addAll({"authorization":"Bearer $token"})
    ..fields.addAll(newValues)
    ..files.addAll(
      files!.map(
        (file) {
          File image = file["image"];
          return http.MultipartFile.fromBytes(
              file["fieldName"],
              image.readAsBytesSync(),
              filename: image.path.split("/").last,
              contentType: MediaType("image", image.path.split(".").last)
          );
        })
    );
    final streamResponse = await request.send();
    return await http.Response.fromStream(streamResponse);
  }
}