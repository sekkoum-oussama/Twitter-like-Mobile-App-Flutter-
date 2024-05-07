part of 'tweets_bloc.dart';

abstract class TweetsBlocEvent extends Equatable {
  const TweetsBlocEvent();

  @override
  List<Object> get props => [];
}

class GetTweets extends TweetsBlocEvent {
  String? order;
  int? id;
  String? username;

  GetTweets({this.order, this.id, this.username});
}

class TweetDeleteEvent extends TweetsBlocEvent {
  const TweetDeleteEvent(this.tweetUrl);
  final String tweetUrl;
}
