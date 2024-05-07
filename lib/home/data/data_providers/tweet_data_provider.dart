import 'package:http/http.dart' as http;
import 'package:twitter_demo/constants/constants.dart';
import 'package:twitter_demo/utils/check_user_credentials.dart';


class TweetsDataProvider {
  
  static Future<http.Response> getTweets(order, id) async {
    
    String token = await is_logged_in() ?? '';
    final idParam = id ?? '';
    final orderParam = order ?? '';
    return await http.get(
      Uri.parse("http://$HOST/$TWEETS?order=$orderParam&id=$idParam"),
      headers: {
        'authorization' : 'Bearer $token',
      }
    );
  }
  static Future<http.Response> getTweetsByUsername(order, id, username) async {
    
    String token = await is_logged_in() ?? '';
    final idParam = id ?? '';
    final orderParam = order ?? '';
    return await http.get(
      Uri.parse("http://$HOST/users/$username/tweets?order=$orderParam&id=$idParam"),
      headers: {
        'authorization' : 'Bearer $token',
      }
    );
  }

  static Future likeTweet(int id) async {
    String token = await is_logged_in() ?? '';
    return await http.post(
      Uri.parse("http://$HOST/$TWEET_LIKE$id/"),
      headers: {
        'authorization' : 'Bearer $token',
      }
    );
  }

  static Future unlikeTweet(int id) async {
    String token = await is_logged_in() ?? '';
    return await http.post(
      Uri.parse("http://$HOST/$TWEET_UNLIKE$id/"),
      headers: {
        'authorization' : 'Bearer $token',
      }
    );
  }
}