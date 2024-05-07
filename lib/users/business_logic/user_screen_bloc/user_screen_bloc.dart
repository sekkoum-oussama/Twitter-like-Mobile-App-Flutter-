import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_demo/users/data/models/user_model.dart';
import 'package:twitter_demo/users/data/repositories.dart';

part 'user_screen_event.dart';
part 'user_screen_state.dart';

class UserScreenBloc extends Bloc<UserScreenEvent, UserScreenState> {
  UserScreenBloc() : super(UserScreenInitial()) {
    on<GetUserDetailsEvent>(getUserDetails);
  }

  getUserDetails(event, emit) async {
    try {
      emit(UserDetailsLoading());
      UserModel user = await UsersRepository.getUser(event.userUrl);
      emit(UserDetailsLoaded(user));
    } catch(e) {
      emit(UserDetailsError());
    }
  }
}
