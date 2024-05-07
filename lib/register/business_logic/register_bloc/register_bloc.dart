import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:twitter_demo/register/data/repositories.dart';

part 'register_event.dart';
part 'register_state.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<Register>(registerUser);
  }

  registerUser(event, emit) async {
    emit(RegisterLoading());
    try {
      final response = await RegisterRepository.register(event.email, event.username, event.password1, event.password2);
        if (response["statusCode"] == 201) {
          emit(RegisteredState());
        } else if (response["statusCode"] == 400) {
          emit(RegisterErrorState(jsonDecode(response["body"])));
        } else {
          emit(UnknownRegisterErrorState());
        }
    } catch(e) {
      emit(UnknownRegisterErrorState());
    }
  }
}
