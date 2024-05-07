import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  UserModel(this.id, this.url, this.username, this.email, this.is_following, this.avatar, this.cover, this.bio, this.date_birth, this.date_joined, this.followers, this.following, this.location);
  
  int id;
  String url;
  String username;
  String email;
  String avatar;
  String cover;
  String? bio;
  String date_joined;
  String? date_birth;
  String? location;
  bool? is_following;
  int following;
  int followers;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  @override
  List<Object?> get props => [];

  

}