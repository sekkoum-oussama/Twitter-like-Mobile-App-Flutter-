part of 'delete_tweet_cubit.dart';

class DeleteTweetState extends Equatable {
  const DeleteTweetState();

  @override
  List<Object> get props => [];
}

class DeleteTweetInitial extends DeleteTweetState {}

class DeleteTweetLoading extends DeleteTweetState {}

class TweetDeleted extends DeleteTweetState {
  TweetDeleted(this.tweetUrl);
  String tweetUrl;
}

class DeleteTweetError extends DeleteTweetState {}