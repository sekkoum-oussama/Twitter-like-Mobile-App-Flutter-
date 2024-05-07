part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}


class FollowUserEvent extends UserEvent {
  FollowUserEvent(this.username);
  String username;
}

class UnfollowUserEvent extends UserEvent {
  UnfollowUserEvent(this.username);
  String username;
}
