part of 'password_reset_cubit.dart';

abstract class PasswordResetState extends Equatable {
  const PasswordResetState();

  @override
  List<Object> get props => [];
}

class PasswordResetInitial extends PasswordResetState {}

class PasswordResetLoading extends PasswordResetState {}

class PasswordResetSuccess extends PasswordResetState {
  PasswordResetSuccess(this.email);
  String? email;
}

class PasswordResetError extends PasswordResetState {
  String? error;
  PasswordResetError(this.error);
}

class PasswordresetUnknownError extends PasswordResetState {}