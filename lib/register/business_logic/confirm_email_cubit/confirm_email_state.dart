part of 'confirm_email_cubit.dart';

abstract class ConfirmEmailState extends Equatable {
  const ConfirmEmailState();

  @override
  List<Object> get props => [];
}

class ConfirmEmailInitial extends ConfirmEmailState {}

class ConfirmEmailLoading extends ConfirmEmailState {}

class ConfirmEmailSuccess extends ConfirmEmailState {}

class ConfirmEmailWrongKeyError extends ConfirmEmailState {}

class ConfirmEmailError extends ConfirmEmailState {}