import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_demo/tweet/data/repositories.dart';

part 'delete_tweet_state.dart';

class DeleteTweetCubit extends Cubit<DeleteTweetState> {
  DeleteTweetCubit() : super(DeleteTweetInitial());

  deleteTweet(String tweetUrl) async {
    try {
      emit(DeleteTweetLoading());
      final statusCode = await TweetDetailsRepository.deleteTweet(tweetUrl);
      if(statusCode == 204 || statusCode == 404) {
        emit(TweetDeleted(tweetUrl));
      } else {
        emit(DeleteTweetError());
      } 
    } catch (e) {
      emit(DeleteTweetError());
    }
  }
}
