import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_demo/home/data/repositories/tweet_repository.dart';
import 'package:twitter_demo/utils/custom_exceptions.dart';

part 'tweet_event.dart';
part 'tweet_state.dart';

class TweetLikedBloc extends Bloc<TweetEvent, TweetState> {
  TweetLikedBloc() : super(TweetInitial()) {
    on<TweetLikeEvent>(likeTweet);
    on<TweetUnLikeEvent>(unlikeTweet);
  }

  likeTweet(event, emit) async {
    try {
      int id = await TweetsRepository.likeTweet(event.id);
      emit(TweetLikedState(id));
    } on TweetNotFoundException {
      emit(TweetLikeNotFoundState());
    } catch (e) {
      emit(TweetLikeErrorState());
    }
  }

  unlikeTweet(event, emit) async {
    try {
      int id = await TweetsRepository.unlikeTweet(event.id);
      emit(TweetUnlikedState(id));
    } on TweetNotFoundException {
      emit(TweetLikeNotFoundState());
    } catch (e) {
      emit(TweetLikeErrorState());
    }
  }

}
