import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_demo/login/data/repositories.dart';
import 'package:twitter_demo/utils/current_user_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  login(String email, String password) async {
    emit(LoginLoading());
    try {
      Map<String, dynamic> data = await LoginRepository.login(email, password);
      if(data["statuscode"] == 400) {
        final error = jsonDecode(data["body"]);
        emit(LoginError(error["non_field_errors"][0]));
      } else if(data["statuscode"]==200) {
        final userData = jsonDecode(data["body"]);
        const secureStorage = FlutterSecureStorage();
        await secureStorage.write(key: "token", value: userData["access"]);
        await secureStorage.write(key: "refresh_token", value: userData["refresh"]);
        await GetIt.I<CurrentUserService>().saveCurrentUser(userData["user"]);
        emit(LoginSuccess());
      } else {
        emit(LoginUnknownError());
      }
    } catch(e) {
      emit(LoginUnknownError());
    }
  }
}
