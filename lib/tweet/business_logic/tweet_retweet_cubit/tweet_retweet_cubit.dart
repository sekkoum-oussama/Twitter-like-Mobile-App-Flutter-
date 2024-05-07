import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_demo/tweet/data/repositories.dart';

part 'tweet_retweet_state.dart';

class TweetRetweetCubit extends Cubit<TweetRetweetState> {
  TweetRetweetCubit() : super(TweetRetweetInitial());

  tweetRetweet(int related_to) async {
    try {
      final int responseCode = await TweetDetailsRepository.retweetTweet(related_to);
      if(responseCode == 201) {
        emit(TweetRetweeted(related_to));
      } else if(responseCode == 404) {
        emit(TweetNotFound());
      } else {
        emit(TweetRetweetError());
      }
    } catch(e) {
      TweetRetweetError();
    }
  }

  deleteRetweet(int related_to) async {
    try {
      final int responseCode = await TweetDetailsRepository.deleteRetweet(related_to);
      if(responseCode == 204) {
        emit(TweetUnretweeted(related_to));
      } else {
        emit(TweetRetweetError());
      }
    } catch(e) {
      emit(TweetRetweetError());
    }
  }
}
