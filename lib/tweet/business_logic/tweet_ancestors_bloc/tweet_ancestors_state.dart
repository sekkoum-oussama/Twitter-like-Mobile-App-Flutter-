part of 'tweet_ancestors_bloc.dart';

abstract class TweetAncestorsState extends Equatable {
  const TweetAncestorsState();
  
  @override
  List<Object> get props => [];
}

class TweetAncestorsInitial extends TweetAncestorsState {}

class TweetAncestorsLoaded extends TweetAncestorsState {
  TweetAncestorsLoaded(this.tweets);
  List tweets;
}

class TweetAncestorsError extends TweetAncestorsState {}
