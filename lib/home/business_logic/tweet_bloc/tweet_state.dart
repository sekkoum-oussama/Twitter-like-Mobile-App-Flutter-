part of 'tweet_bloc.dart';

abstract class TweetState extends Equatable {
  int? id;
  @override
  List<Object?> get props => [id];
}


class TweetInitial extends TweetState {
  
}


class TweetLikedState extends TweetState {
  TweetLikedState(this.id);
  @override
  int? id;
}


class TweetUnlikedState extends TweetState {
  TweetUnlikedState(this.id);
  @override
  int? id;
}


class TweetLikeNotFoundState extends TweetState {}


class TweetLikeErrorState extends TweetState {}