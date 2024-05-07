part of 'tweet_replies_bloc.dart';

abstract class TweetRepliesState extends Equatable {
  const TweetRepliesState();
  
  @override
  List<Object> get props => [];
}

class TweetRepliesInitial extends TweetRepliesState {}

class TweetRepliesLoading extends TweetRepliesState {}

class TweetRepliesLoaded extends TweetRepliesState {
  TweetRepliesLoaded(this.replies);
  List<ReplyTweetModel> replies;
}

class TweetsRepliesDeleteTweetState extends TweetRepliesState {
  const TweetsRepliesDeleteTweetState(this.tweetUrl);
  final String tweetUrl;

  @override
  List<Object> get props => [tweetUrl];
}

class TweetRepliesError extends TweetRepliesState {}