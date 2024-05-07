// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['id'] as int,
      json['url'] as String,
      json['username'] as String,
      json['email'] as String,
      json['is_following'] as bool?,
      json['avatar'] as String,
      json['cover'] as String,
      json['bio'] as String?,
      json['date_birth'] as String?,
      json['date_joined'] as String,
      json['followers'] as int,
      json['following'] as int,
      json['location'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'username': instance.username,
      'email': instance.email,
      'avatar': instance.avatar,
      'cover': instance.cover,
      'bio': instance.bio,
      'date_joined': instance.date_joined,
      'date_birth': instance.date_birth,
      'location': instance.location,
      'is_following': instance.is_following,
      'following': instance.following,
      'followers': instance.followers,
    };
