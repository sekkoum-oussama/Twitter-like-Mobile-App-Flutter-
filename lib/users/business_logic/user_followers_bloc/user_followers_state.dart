part of 'user_followers_bloc.dart';

abstract class UserFollowersState extends Equatable {
  const UserFollowersState();
  
  @override
  List<Object> get props => [];
}

class UserFollowersInitial extends UserFollowersState {}

class UserFollowersLoading extends UserFollowersState {}

class UserFollowersLoaded extends UserFollowersState {
  UserFollowersLoaded(this.users);
  List users;
}

class UserFollowingsLoaded extends UserFollowersState {
  UserFollowingsLoaded(this.users);
  List users;
}
class UserNotFound extends UserFollowersState {}

class UserFollowersError extends UserFollowersState {}

