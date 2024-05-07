part of 'tweet_details_bloc.dart';

abstract class TweetDetailsEvent extends Equatable {
  const TweetDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetTweetDetails extends TweetDetailsEvent {
  GetTweetDetails(this.tweetUrl);
  String tweetUrl;
}

class TweetDeleteEvent extends TweetDetailsEvent {
  const TweetDeleteEvent(this.tweetUrl);
  final String tweetUrl;
}
