part of 'tweet_details_bloc.dart';

abstract class TweetDetailsState extends Equatable {
  const TweetDetailsState();
  
  @override
  List<Object> get props => [];
}

class TweetDetailsInitial extends TweetDetailsState {}

class TweetDetailsLoading extends TweetDetailsState {}

class TweetDetailsLoaded extends TweetDetailsState {
  TweetDetailsLoaded(this.tweet);
  final tweet;
}

class TweetsDetailsDeleteTweetState extends TweetDetailsState {
  const TweetsDetailsDeleteTweetState(this.tweetUrl);
  final String tweetUrl;

  @override
  List<Object> get props => [tweetUrl];
}

class TweetNotFound extends TweetDetailsState {}

class TweetDetailsError extends TweetDetailsState {}