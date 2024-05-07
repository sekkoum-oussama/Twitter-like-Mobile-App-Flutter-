part of 'user_followers_bloc.dart';

abstract class UserFollowersEvent extends Equatable {
  const UserFollowersEvent();

  @override
  List<Object> get props => [];
}

class UserGetFollowersEvent extends UserFollowersEvent {
  UserGetFollowersEvent(this.username);
  String username;
}

class UserGetFollowingsEvent extends UserFollowersEvent {
  UserGetFollowingsEvent(this.username);
  String username;
}