import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_demo/home/data/repositories/tweet_repository.dart';
import 'package:twitter_demo/tweet/business_logic/delete_tweet_cubit/delete_tweet_cubit.dart';
import 'package:twitter_demo/utils/custom_exceptions.dart';

part 'tweets_list_event.dart';
part 'tweets_list_state.dart';

class TweetsListBloc extends Bloc<TweetsBlocEvent, TweetsBlocState> {
  TweetsListBloc() : super(TweetsListBlocInitial()) {
    on<GetTweets>(getTweets);
    on<TweetDeleteEvent>(removeTweetFromList);
  }


  getTweets(event, emit) async {
    emit(TweetsListLoading());
    try {
      List tweets = await TweetsRepository.getTweets(event.order, event.id, event.username);
      if(event.order == 'newest') {
        emit(NewestTweetsLoaded(tweets));
      } else {
        emit(OldestTweetsLoaded(tweets));
      }
    } on NotAuthenticatedException {
      emit(TweetsListNotAuthenticatedError());
    } catch (e) {
      print(e);
      emit(TweetsListUnknownError());
    }
  }

  removeTweetFromList(event, emit) async {
    emit(TweetsListDeleteTweetState(event.tweetUrl));
  }
}
