import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quote_tweet_model.g.dart';

@JsonSerializable()
class QuoteTweetModel extends Equatable {
  QuoteTweetModel({
    this.id,
    this.type,
    this.date,
    this.author,
    this.interactions,
    this.likes,
    required this.is_liked,
    required this.is_retweeted,
    required this.quotes,
    required this.retweets,
    this.media,
    this.replies,
    this.text,
    this.url,
    this.quoted_tweet
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
  QuotedTweetModel? quoted_tweet;

  factory QuoteTweetModel.fromJson(Map<String, dynamic> json) => _$QuoteTweetModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteTweetModelToJson(this);
  @override
  List<Object> get props => [];
}

@JsonSerializable()
class QuotedTweetModel extends Equatable {
  QuotedTweetModel({
    this.id,
    this.author,
    this.date,
    this.media,
    this.text,
    this.url,
    this.reply_to,
  });

  int? id;
  String? url;
  String? text;
  String? date;
  Map<String, dynamic>? author;
  List<Map>? media;
  String? reply_to;

  factory QuotedTweetModel.fromJson(Map<String, dynamic> json) => _$QuotedTweetModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuotedTweetModelToJson(this);
  @override
  List<Object?> get props => [];

}