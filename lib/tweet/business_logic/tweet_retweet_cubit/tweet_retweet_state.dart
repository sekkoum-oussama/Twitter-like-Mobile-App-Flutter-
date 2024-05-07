part of 'tweet_retweet_cubit.dart';

class TweetRetweetState extends Equatable {
  TweetRetweetState();
  int? id;
  @override
  List<Object?> get props => [id];
}

class TweetRetweetInitial extends TweetRetweetState {}

class TweetRetweeted extends TweetRetweetState {
  TweetRetweeted(this.id);
  @override
  final int id;
}

class TweetUnretweeted extends TweetRetweetState {
  TweetUnretweeted(this.id);
  @override
  final int id;
}

class TweetNotFound extends TweetRetweetState {}

class TweetRetweetError extends TweetRetweetState {}
