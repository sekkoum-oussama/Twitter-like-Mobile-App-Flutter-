part of 'tweet_bloc.dart';

abstract class TweetEvent extends Equatable {
  const TweetEvent();

  @override
  List<Object> get props => [];
}


class TweetLikeEvent extends TweetEvent {
  TweetLikeEvent(this.id);
  int? id;
}


class TweetUnLikeEvent extends TweetEvent {
  TweetUnLikeEvent(this.id);
  int? id;
}