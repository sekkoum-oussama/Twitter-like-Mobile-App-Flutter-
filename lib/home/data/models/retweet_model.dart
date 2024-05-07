import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twitter_demo/home/data/models/quote_tweet_model.dart';

part 'retweet_model.g.dart';

@JsonSerializable()
class ReTweetModel extends Equatable {
  ReTweetModel({
    this.id,
    this.type,
    this.author,
    this.url,
    this.related_to,
  });
  
  int? id;
  String? type;
  String? author;
  String? url;
  RetweetedTweetModel? related_to;
  
  factory ReTweetModel.fromJson(Map<String, dynamic> json) => _$ReTweetModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReTweetModelToJson(this);

  @override
  List<Object> get props => [];
}

@JsonSerializable()
class RetweetedTweetModel extends Equatable {
  RetweetedTweetModel({
    this.id,
    this.author,
    this.date,
    this.interactions,
    this.likes,
    required this.is_liked,
    required this.is_retweeted,
    required this.quotes,
    required this.retweets,
    this.media,
    this.quoted_tweet,
    this.replies,
    this.reply_to,
    this.text,
    this.type,
    this.url,
  });

  int? id;
  String? type;
  String? url;
  String? text;
  String? date;
  int? replies;
  int? interactions;
  int? likes;
  int quotes;
  int retweets;
  bool is_liked;
  bool is_retweeted;
  List<Map>? media;
  Map<String, dynamic>? author;

  @JsonKey(defaultValue: null)
  String? reply_to;

  @JsonKey(defaultValue: null)
  QuotedTweetModel? quoted_tweet;

  factory RetweetedTweetModel.fromJson(Map<String, dynamic> json) => _$RetweetedTweetModelFromJson(json);

  Map<String, dynamic> toJson() => _$RetweetedTweetModelToJson(this);

  @override
  List<Object?> get props => [];

}