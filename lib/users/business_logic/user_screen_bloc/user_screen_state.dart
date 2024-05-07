part of 'user_screen_bloc.dart';

abstract class UserScreenState extends Equatable {
  const UserScreenState();
  
  @override
  List<Object> get props => [];
}

class UserScreenInitial extends UserScreenState {}

class UserInitial extends UserScreenState {}

class UserDetailsLoading extends UserScreenState {}

class UserDetailsLoaded extends UserScreenState {
  UserDetailsLoaded(this.user);
  UserModel user;
}

class UserDetailsError extends UserScreenState {}
