part of 'update_user_cubit.dart';

class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoadingState extends UpdateUserState {}

class UpdateUserSuccessState extends UpdateUserState {
  const UpdateUserSuccessState(this.user);
  final UserModel user;
}

class UpdateUserErrorState extends UpdateUserState {
  const UpdateUserErrorState(this.errors);
  final Map<String, dynamic> errors;
}

class UpdateUserUnknownErrorState extends UpdateUserState {}
