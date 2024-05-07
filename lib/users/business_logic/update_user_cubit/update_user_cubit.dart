import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:twitter_demo/users/data/models/user_model.dart';
import 'package:twitter_demo/users/data/repositories.dart';
import 'package:twitter_demo/utils/custom_exceptions.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit() : super(UpdateUserInitial());

  void updateUser(String username, Map<String, String> newValues, {List? files}) async {
    try {
      emit(UpdateUserLoadingState());
      final UserModel updatedUser = await UsersRepository.updateUser(username, newValues, files: files);
      emit(UpdateUserSuccessState(updatedUser));
    } on UpdateUserFieldErrorException catch(error) {
      emit(UpdateUserErrorState(error.errors));
    }
    catch(e) {
      emit(UpdateUserUnknownErrorState());
    }
  }
}
