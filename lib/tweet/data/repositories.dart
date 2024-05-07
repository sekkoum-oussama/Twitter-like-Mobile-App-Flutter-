import 'dart:convert';

import 'package:twitter_demo/home/data/data_providers/tweet_data_provider.dart';
import 'package:twitter_demo/home/data/models/quote_tweet_model.dart';
import 'package:twitter_demo/home/data/models/reply_tweet_model.dart';
import 'package:twitter_demo/home/data/models/retweet_model.dart';
import 'package:twitter_demo/home/data/models/tweet_model.dart';
import 'package:twitter_demo/tweet/data/data_providers.dart';
import 'package:twitter_demo/utils/custom_exceptions.dart';
import 'package:http/http.dart' as http;

class TweetDetailsRepository {
  static Future getTweetDetails(String tweetUrl) async {
    
    http.Response res = await TweetDetailsDataProvider.getTweetDetails(tweetUrl);
    if(res.statusCode == 200) {
      final tweet = jsonDecode(res.body);
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
    } else if(res.statusCode == 404) {
      throw TweetNotFoundException();
    } else {
      throw Exception();
    }
  }

  static Future<Map> addTweet({String? text,List? files}) async {
    try {
      http.Response res = await TweetDetailsDataProvider.addTweet(text: text, files: files);
      return {"statusCode" : res.statusCode, "body" : jsonDecode(res.body)};
    } catch(e) {
      throw Exception();
    }
  }

  static Future<List<ReplyTweetModel>> getTweetReplies(int id) async {
    http.Response response = await TweetDetailsDataProvider.getTweetReplies(id);
    if(response.statusCode == 200) {
      List body = jsonDecode(response.body);
      List<ReplyTweetModel> tweets = body.map((tweet) => ReplyTweetModel.fromJson(tweet)).toList();
      return tweets;
    } else {
      throw Exception();
    }
  }

  static Future<List> getTweetAncestors(int id) async {
    http.Response response = await TweetDetailsDataProvider.getTweetAncestors(id);
    if(response.statusCode == 200) {
      List body = jsonDecode(response.body);
      List tweets = body.map((tweet) {
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
    } else {
      throw Exception();
    }
  }

  static Future<ReplyTweetModel> addReply(int related_to, {String? text, List? files}) async {
    try {
      http.Response res = await TweetDetailsDataProvider.addReply(related_to, text: text, files: files);
      if(res.statusCode == 201) {
        return ReplyTweetModel.fromJson(jsonDecode(res.body));
      } else if(res.statusCode == 400) {
        throw TweetNotFoundException();
      } else {
        throw Exception();
      }
    } catch(e) {
      throw Exception();
    }
    
  }

  static Future retweetTweet(int related_to) async {
    try {
      http.Response res = await TweetDetailsDataProvider.retweetTweet(related_to);
      return res.statusCode;
    } catch(e) {
      throw Exception();
    }
  }

  static Future deleteRetweet(int related_to) async {
    try {
      http.Response res = await TweetDetailsDataProvider.deleteRetweet(related_to);
      return res.statusCode;
    } catch(e) {
      throw Exception();
    }
  }

  static Future quoteTweet(int related_to, {String? text, List? files}) async {
    try {
      http.Response res = await TweetDetailsDataProvider.quoteTweet(related_to, text:text, files:files);
      return res.statusCode;
    } catch(e) {
      throw Exception();
    }
  }


  static Future<List> getTweetRetweets(int id) async {
    try {
      http.Response response = await TweetDetailsDataProvider.getRetweetsList(id);
      if(response.statusCode == 200) {
        List users = jsonDecode(response.body);
        return users;
      } else if(response.statusCode == 404) {
        throw TweetNotFoundException();
      } else {
        throw Exception();
      }
    } catch(err) {
      rethrow;
    }
  }

  static Future<List<QuoteTweetModel>> getTweetQuotes(int id) async {
    try {
      http.Response response = await TweetDetailsDataProvider.getQuotesList(id);
      if(response.statusCode == 200) {
        List body = jsonDecode(response.body);
        List<QuoteTweetModel> quotes = body.map((tweet) => QuoteTweetModel.fromJson(tweet)).toList();
        return quotes;
      } else if(response.statusCode == 404) {
        throw TweetNotFoundException();
      } else {
        throw Exception();
      }
    } catch(err) {
      rethrow;
    }
  }

  static Future deleteTweet(String tweetUrl) async {
    try {
      final res = await TweetDetailsDataProvider.deleteTweet(tweetUrl);
      return res.statusCode;
    } catch (e) {
      throw Exception();
    }
  }
}