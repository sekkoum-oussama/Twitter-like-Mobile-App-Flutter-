import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twitter_demo/home/data/data_providers/tweet_data_provider.dart';
import 'package:twitter_demo/home/data/models/quote_tweet_model.dart';
import 'package:twitter_demo/home/data/models/reply_tweet_model.dart';
import 'package:twitter_demo/home/data/models/retweet_model.dart';
import 'package:twitter_demo/home/data/models/tweet_model.dart';
import 'package:twitter_demo/utils/custom_exceptions.dart';


class TweetsRepository {

  static Future<List> getTweets(String? order, int? id,String? username) async {
    List? tweets;
    http.Response response;
    if(username != null) {
      response = await TweetsDataProvider.getTweetsByUsername(order, id, username);

    } else {
     response = await TweetsDataProvider.getTweets(order, id);
    }
    
    if(response.statusCode == 200) {
      
      List body = jsonDecode(response.body);
      tweets = body.map((tweet) {
        switch(tweet['type']) {
          case 'reply':
            return ReplyTweetModel.fromJson(tweet);
          case 'quote':
            return QuoteTweetModel.fromJson(tweet);
          case 'retweet':
            return ReTweetModel.fromJson(tweet);
          default:
            return TweetModel.fromJson(tweet);
        }
      }).toList();
      return tweets;
    } else if(response.statusCode == 401) {
      throw NotAuthenticatedException();
    } else {
      
      throw Exception();
    }
  }


  static Future<int> likeTweet(int id) async {
    http.Response response = await TweetsDataProvider.likeTweet(id); 
    if(response.statusCode == 201) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      
      throw TweetNotFoundException();
    } else {
      throw Exception();
    }
  }

  static Future<int> unlikeTweet(int id) async {
    http.Response response = await TweetsDataProvider.unlikeTweet(id); 
    if(response.statusCode == 204) {
      return id;
    } else if (response.statusCode == 404) {
      
      throw TweetNotFoundException();
    } else {
      throw Exception();
    }
  }
}