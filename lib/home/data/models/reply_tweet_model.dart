import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reply_tweet_model.g.dart';

@JsonSerializable()
class ReplyTweetModel extends Equatable {
  ReplyTweetModel({
    this.id,
    this.type,
    this.date,
    this.author,
    this.interactions,
    this.likes,
    required this.is_liked,
    required this.is_retweeted,
    this.quotes = 0,
    this.retweets = 0,
    this.media,
    this.replies,
    this.text,
    this.url,
    this.reply_to,
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
  String? reply_to;

  factory ReplyTweetModel.fromJson(Map<String, dynamic> json) => _$ReplyTweetModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReplyTweetModelToJson(this);

  @override
  List<Object> get props => [];
}