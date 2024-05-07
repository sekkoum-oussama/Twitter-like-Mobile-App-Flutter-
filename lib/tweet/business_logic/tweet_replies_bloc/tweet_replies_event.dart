part of 'tweet_replies_bloc.dart';

abstract class TweetRepliesEvent extends Equatable {
  const TweetRepliesEvent();

  @override
  List<Object> get props => [];
}

class GetTweetReplies extends TweetRepliesEvent {
  GetTweetReplies(this.id);
  int id;
}

class TweetDeleteEvent extends TweetRepliesEvent {
  const TweetDeleteEvent(this.tweetUrl);
  final String tweetUrl;
}