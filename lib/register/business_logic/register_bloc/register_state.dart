part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
  
  @override
  List<Object> get props => [];
}


class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}


class RegisterErrorState extends RegisterState {
  Map<String, dynamic>? errors;
  
  RegisterErrorState(this.errors);
}

class UnknownRegisterErrorState extends RegisterState {}


class RegisteredState extends RegisterState {}



