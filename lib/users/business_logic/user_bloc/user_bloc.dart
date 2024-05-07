import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_demo/users/data/models/user_model.dart';
import 'package:twitter_demo/users/data/repositories.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<FollowUserEvent>(followUser);
    on<UnfollowUserEvent>(unfollowUser);
  }

  followUser(event, emit) async {
    try {
      emit(UserFollowLoading());
      bool success = await UsersRepository.followUser(event.username);
      if(success == true) {
        emit(UserFollowSuccess());
      } else {
        emit(UserFollowError());
      }
    } catch(e) {
      emit(UserFollowError());
    }
  }

  unfollowUser(event, emit) async {
    try {
      emit(UserUnfollowLoading());
      bool success = await UsersRepository.unfollowUser(event.username);
      if(success == true) {
        emit(UserUnfollowSuccess());
      } else {
        emit(UserUnfollowError());
      }
    } catch(e) {
      emit(UserUnfollowError());
    }
  }
}
