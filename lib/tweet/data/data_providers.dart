import 'dart:math';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:twitter_demo/constants/constants.dart';
import 'package:twitter_demo/utils/check_user_credentials.dart';
import 'package:http/http.dart' as http;


class TweetDetailsDataProvider {
  
  static Future<http.Response> getTweetDetails(String tweetUrl) async {
    String token = await is_logged_in() ?? '';
    return await http.get(
      Uri.parse(tweetUrl),
      headers: {
        'authorization' : 'Bearer $token',
      }
    );
  }

  static Future<http.Response> getTweetReplies(int id) async {
    String token = await is_logged_in() ?? '';
    return await http.get(
      Uri.parse('http://$HOST/$TWEET_REPLIES$id/'),
      headers: {
        'authorization' : 'Bearer $token',
      }
    );
  }

  static Future<http.Response> getTweetAncestors(int id) async {
    String token = await is_logged_in() ?? '';
    return await http.get(
      Uri.parse('http://$HOST/$TWEET_ANCESTORS$id/'),
      headers: {
        'authorization' : 'Bearer $token',
      }
    );
  }

  static Future<http.Response> addTweet({String? text, List? files}) async {
    
    String token = await is_logged_in() ?? '';
    final headers = {
      'Authorization' : 'Bearer $token',
    };
    final body = {
      "text" : text!,
    };

    final request = http.MultipartRequest("POST", Uri.parse('http://$HOST/$TWEETS'))
    ..fields.addAll(body)
    ..headers.addAll(headers)
    ..files.addAll(files!.map((file) {
          File myfile = file["file"];
          return http.MultipartFile.fromBytes(
              'files',
              myfile.readAsBytesSync(),
              filename: file["title"].split("/").last,
              contentType: MediaType("image", file["title"].split(".").last)
          );
        }
      ).toList()
    );
  
    final streamResponse = await request.send();
    return await http.Response.fromStream(streamResponse);
  }

  static Future<http.Response> addReply(int related_to, {String? text, List? files}) async {
    String token = await is_logged_in() ?? '';
    final headers = {
      'Authorization' : 'Bearer $token',
    };
    final body = {
      "related_to" : related_to.toString(),
      "text" : text!,
      "type" : "reply",
    };
    final request = http.MultipartRequest("POST", Uri.parse('http://$HOST/$TWEETS'))
    ..fields.addAll(body)
    ..headers.addAll(headers)
    ..files.addAll(files!.map((file) {
          File myfile = file["file"];
          return http.MultipartFile.fromBytes(
              'files',
              myfile.readAsBytesSync(),
              filename: file["title"].split("/").last,
              contentType: MediaType("image", file["title"].split(".").last)
          );
        }
      ).toList()
    );
    final streamResponse = await request.send();
    return await http.Response.fromStream(streamResponse);
  }

  static Future<http.Response> quoteTweet(int related_to, {String? text, List? files}) async {
    
    String token = await is_logged_in() ?? '';
    final headers = {
      'Authorization' : 'Bearer $token',
    };
    final body = {
      "related_to" : related_to.toString(),
      "text" : text!,
      "type" : "quote",
    };

    final request = http.MultipartRequest("POST", Uri.parse('http://$HOST/$TWEETS'))
    ..fields.addAll(body)
    ..headers.addAll(headers)
    ..files.addAll(files!.map((file) {
          File myfile = file["file"];
          return http.MultipartFile.fromBytes(
              'files',
              myfile.readAsBytesSync(),
              filename: file["title"].split("/").last,
              contentType: MediaType("image", file["title"].split(".").last)
          );
        }
      ).toList()
    );
  
    final streamResponse = await request.send();
    return await http.Response.fromStream(streamResponse);
  }

  static Future<http.Response> retweetTweet(int related_to) async {
    String token = await is_logged_in() ?? '';
    return await http.post(
      Uri.parse('http://$HOST/$TWEETS'),
      headers: {
        'authorization' : 'Bearer $token',
      },
      body: {
        "type" : "retweet",
        "related_to" : related_to.toString()
      }
    );
  }

  static Future<http.Response> deleteRetweet(int related_to) async {
    String token = await is_logged_in() ?? '';
    return await http.delete(
      Uri.parse('http://$HOST/$DELETE_RETWEET$related_to/'),
      headers: {
        'authorization' : 'Bearer $token',
      },
    );
  }

  static Future<http.Response> getRetweetsList(int id) async {
    String token = await is_logged_in() ?? '';
    return await http.get(
      Uri.parse("http://$HOST/$TWEET_RETWEETS_LIST$id"),
      headers: {
        'authorization' : 'Bearer $token',
      }
    );
  }

  static Future<http.Response> getQuotesList(int id) async {
    String token = await is_logged_in() ?? '';
    return await http.get(
      Uri.parse("http://$HOST/$TWEET_QUOTES_LIST$id"),
      headers: {
        'authorization' : 'Bearer $token',
      }
    );
  }

  static Future<http.Response> deleteTweet(String tweetUrl) async {
    String token = await is_logged_in() ?? '';
    return await http.delete(
      Uri.parse(tweetUrl),
      headers: {
        'authorization' : 'Bearer $token',
      }
    );
  }

}