import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_demo/tweet/data/repositories.dart';
import 'package:twitter_demo/utils/custom_exceptions.dart';

part 'tweet_details_event.dart';
part 'tweet_details_state.dart';

class TweetDetailsBloc extends Bloc<TweetDetailsEvent, TweetDetailsState> {
  TweetDetailsBloc() : super(TweetDetailsInitial()) {
    on<TweetDetailsEvent>(getTweetDetails);
    on<TweetDeleteEvent>(emitTweetDeleted);
  }

  getTweetDetails(event, emit) async {
    try {
      emit(TweetDetailsLoading());
      final tweet = await TweetDetailsRepository.getTweetDetails(event.tweetUrl);
      emit(TweetDetailsLoaded(tweet));
    } on TweetNotFoundException {
      emit(TweetNotFound());
    } catch (e) {
      emit(TweetDetailsError());
    }
    
  }

  emitTweetDeleted(event, emit) {
    emit(TweetsDetailsDeleteTweetState(event.tweetUrl));
  }


}
