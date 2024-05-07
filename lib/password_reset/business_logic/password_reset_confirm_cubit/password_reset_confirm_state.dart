part of 'password_reset_confirm_cubit.dart';

abstract class PasswordResetConfirmState extends Equatable {
  const PasswordResetConfirmState();

  @override
  List<Object> get props => [];
}

class PasswordResetConfirmInitial extends PasswordResetConfirmState {}

class PasswordResetConfirmLoading extends PasswordResetConfirmState {}

class PasswordResetConfirmSuccess extends PasswordResetConfirmState {}

class PasswordResetConfirmError extends PasswordResetConfirmState {
  Map<String, dynamic> errors;
  PasswordResetConfirmError(this.errors);
}

class PasswordResetConfirmUnknownError extends PasswordResetConfirmState {}