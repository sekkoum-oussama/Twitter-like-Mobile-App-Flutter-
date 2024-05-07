// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retweet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReTweetModel _$ReTweetModelFromJson(Map<String, dynamic> json) => ReTweetModel(
      id: json['id'] as int?,
      type: json['type'] as String?,
      author: json['author'] as String?,
      url: json['url'] as String?,
      related_to: json['related_to'] == null
          ? null
          : RetweetedTweetModel.fromJson(
              json['related_to'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReTweetModelToJson(ReTweetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'author': instance.author,
      'url': instance.url,
      'related_to': instance.related_to,
    };

RetweetedTweetModel _$RetweetedTweetModelFromJson(Map<String, dynamic> json) =>
    RetweetedTweetModel(
      id: json['id'] as int?,
      author: json['author'] as Map<String, dynamic>?,
      date: json['date'] as String?,
      interactions: json['interactions'] as int?,
      likes: json['likes'] as int?,
      is_liked: json['is_liked'] as bool,
      is_retweeted: json['is_retweeted'] as bool,
      quotes: json['quotes'] as int,
      retweets: json['retweets'] as int,
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      quoted_tweet: json['quoted_tweet'] == null
          ? null
          : QuotedTweetModel.fromJson(
              json['quoted_tweet'] as Map<String, dynamic>),
      replies: json['replies'] as int?,
      reply_to: json['reply_to'] as String?,
      text: json['text'] as String?,
      type: json['type'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$RetweetedTweetModelToJson(
        RetweetedTweetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'url': instance.url,
      'text': instance.text,
      'date': instance.date,
      'replies': instance.replies,
      'interactions': instance.interactions,
      'likes': instance.likes,
      'quotes': instance.quotes,
      'retweets': instance.retweets,
      'is_liked': instance.is_liked,
      'is_retweeted': instance.is_retweeted,
      'media': instance.media,
      'author': instance.author,
      'reply_to': instance.reply_to,
      'quoted_tweet': instance.quoted_tweet,
    };
