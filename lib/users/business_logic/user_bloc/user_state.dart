part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserFollowSuccess extends UserState {}

class UserUnfollowSuccess extends UserState {}

class UserFollowError extends UserState {}

class UserUnfollowError extends UserState {}

class UserFollowLoading extends UserState {}

class UserUnfollowLoading extends UserState {}