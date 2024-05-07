import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_demo/password_reset/data/repositories.dart';

part 'password_reset_state.dart';

class PasswordResetCubit extends Cubit<PasswordResetState> {
  PasswordResetCubit() : super(PasswordResetInitial());

  password_reset(String email) async {
    emit(PasswordResetLoading());
    try {
      final status_code = await PasswordResetRepository.password_reset(email);
      if(status_code == 200) {
        emit(PasswordResetSuccess(email));
      } else if(status_code == 404) {
        emit(PasswordResetError('Email does not exist'));
      } else if(status_code == 400) {
        emit(PasswordResetError('Email is not activated'));
      }
    } catch(e) {
      emit(PasswordresetUnknownError());
    }
  }
}
