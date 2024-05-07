import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_demo/register/data/repositories.dart';
import 'package:twitter_demo/register/representation/screens/email_confirmation_screen.dart';

part 'confirm_email_state.dart';

class ConfirmEmailCubit extends Cubit<ConfirmEmailState> {
  ConfirmEmailCubit() : super(ConfirmEmailInitial());
  
  confirm_email(String key) async {
    emit(ConfirmEmailLoading());
    var code = await RegisterRepository.confirm_email(key);
    print("$code");
    if(code == 200) {
      emit(ConfirmEmailSuccess());
    } else if(code == 404) {
      emit(ConfirmEmailWrongKeyError());
    } else {
      emit(ConfirmEmailError());
    }
  }
}
