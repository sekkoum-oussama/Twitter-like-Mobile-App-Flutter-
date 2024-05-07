import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part 'tweet_model.g.dart';

@JsonSerializable()
class TweetModel extends Equatable {
  TweetModel({
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

  factory TweetModel.fromJson(Map<String, dynamic> json) => _$TweetModelFromJson(json);

  Map<String, dynamic> toJson() => _$TweetModelToJson(this);

  @override
  List<Object> get props => [];
}