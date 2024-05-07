import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_demo/password_reset/data/repositories.dart';

part 'password_reset_confirm_state.dart';

class PasswordResetConfirmCubit extends Cubit<PasswordResetConfirmState> {
  PasswordResetConfirmCubit() : super(PasswordResetConfirmInitial());

  password_reset_confirm(email, token, new_password1, new_password2) async {
    emit(PasswordResetConfirmLoading());
    try {
      Map<String, dynamic> response = await PasswordResetRepository.password_reset_confirm(email, token, new_password1, new_password2);
      if(response['status_code'] == 400) {
        emit(PasswordResetConfirmError(jsonDecode(response['content'])));
      } else if(response['status_code'] == 200) {
        emit(PasswordResetConfirmSuccess());
      } else {
        emit(PasswordResetConfirmUnknownError());
      }
 
    } catch(e) {
      emit(PasswordResetConfirmUnknownError());
    }
  }
}
