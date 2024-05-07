import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_demo/home/data/models/reply_tweet_model.dart';
import 'package:twitter_demo/tweet/data/repositories.dart';

part 'tweet_replies_event.dart';
part 'tweet_replies_state.dart';

class TweetRepliesBloc extends Bloc<TweetRepliesEvent, TweetRepliesState> {
  TweetRepliesBloc() : super(TweetRepliesInitial()) {
    on<GetTweetReplies>(getTweetReplies);
    on<TweetDeleteEvent>(deleteTweetReply);
  }

  getTweetReplies(event, emit) async {
    emit(TweetRepliesLoading());
    try {
      List<ReplyTweetModel> replies = await TweetDetailsRepository.getTweetReplies(event.id);
      emit(TweetRepliesLoaded(replies));
    } catch (e) {
      emit(TweetRepliesError());
    }
  } 

  deleteTweetReply(event, emit) {
    emit(TweetsRepliesDeleteTweetState(event.tweetUrl));
  }
}
