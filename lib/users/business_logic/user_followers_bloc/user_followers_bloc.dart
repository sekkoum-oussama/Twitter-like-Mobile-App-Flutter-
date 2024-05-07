import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_demo/users/data/repositories.dart';
import 'package:twitter_demo/utils/custom_exceptions.dart';

part 'user_followers_event.dart';
part 'user_followers_state.dart';

class UserFollowersBloc extends Bloc<UserFollowersEvent, UserFollowersState> {
  UserFollowersBloc() : super(UserFollowersInitial()) {
    on<UserGetFollowersEvent>(getFollowers);
    on<UserGetFollowingsEvent>(getFollowings);
  }


  getFollowers(event, emit) async {
    try {
      emit(UserFollowersLoading());
      List users = await UsersRepository.getFollowers(event.username);
      emit(UserFollowersLoaded(users));
    } on UserNotFoundException {
      emit(UserNotFound());
    } catch (e) {
      emit(UserFollowersError());
    }
  }

  getFollowings(event, emit) async {
    try {
      emit(UserFollowersLoading());
      List users = await UsersRepository.getFollowings(event.username);
      emit(UserFollowingsLoaded(users));
    } on UserNotFoundException {
      emit(UserNotFound());
    } catch (e) {
      emit(UserFollowersError());
    }
  }
}
