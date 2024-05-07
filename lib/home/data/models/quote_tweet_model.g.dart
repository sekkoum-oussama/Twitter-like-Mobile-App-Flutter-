// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_tweet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteTweetModel _$QuoteTweetModelFromJson(Map<String, dynamic> json) =>
    QuoteTweetModel(
      id: json['id'] as int?,
      type: json['type'] as String?,
      date: json['date'] as String?,
      author: json['author'] as Map<String, dynamic>?,
      interactions: json['interactions'] as int?,
      likes: json['likes'] as int?,
      is_liked: json['is_liked'] as bool,
      is_retweeted: json['is_retweeted'] as bool,
      quotes: json['quotes'] as int,
      retweets: json['retweets'] as int,
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      replies: json['replies'] as int?,
      text: json['text'] as String?,
      url: json['url'] as String?,
      quoted_tweet: json['quoted_tweet'] == null
          ? null
          : QuotedTweetModel.fromJson(
              json['quoted_tweet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuoteTweetModelToJson(QuoteTweetModel instance) =>
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
      'quoted_tweet': instance.quoted_tweet,
    };

QuotedTweetModel _$QuotedTweetModelFromJson(Map<String, dynamic> json) =>
    QuotedTweetModel(
      id: json['id'] as int?,
      author: json['author'] as Map<String, dynamic>?,
      date: json['date'] as String?,
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      text: json['text'] as String?,
      url: json['url'] as String?,
      reply_to: json['reply_to'] as String?,
    );

Map<String, dynamic> _$QuotedTweetModelToJson(QuotedTweetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'text': instance.text,
      'date': instance.date,
      'author': instance.author,
      'media': instance.media,
      'reply_to': instance.reply_to,
    };
