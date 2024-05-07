part of 'user_screen_bloc.dart';

abstract class UserScreenEvent extends Equatable {
  const UserScreenEvent();

  @override
  List<Object> get props => [];
}

class GetUserDetailsEvent extends UserScreenEvent {
  GetUserDetailsEvent(this.userUrl);
  var userUrl;
}
