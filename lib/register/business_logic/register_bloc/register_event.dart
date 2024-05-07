part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}


class Register extends RegisterEvent {
  String? email;
  String? username;
  String? password1;
  String? password2;

  Register({@required this.email, @required this.username, @required this.password1, @required this.password2});
}
