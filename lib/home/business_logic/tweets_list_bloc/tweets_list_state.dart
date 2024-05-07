part of 'tweets_bloc.dart';

abstract class TweetsBlocState extends Equatable {
  const TweetsBlocState();
  
  @override
  List<Object> get props => [];
}

class TweetsListBlocInitial extends TweetsBlocState {}

class TweetsListLoading extends TweetsBlocState {}

class TweetsListNotAuthenticatedError extends TweetsBlocState {}

class NewestTweetsLoaded extends TweetsBlocState {
  List tweets;
  NewestTweetsLoaded(this.tweets);
}

class OldestTweetsLoaded extends TweetsBlocState {
  List tweets;
  OldestTweetsLoaded(this.tweets);
}

class TweetsListDeleteTweetState extends TweetsBlocState {
  const TweetsListDeleteTweetState(this.tweetUrl);
  final String tweetUrl;

  @override
  List<Object> get props => [tweetUrl];
}

class TweetsListUnknownError extends TweetsBlocState {}
