part of 'tweet_ancestors_bloc.dart';

abstract class TweetAncestorsEvent extends Equatable {
  const TweetAncestorsEvent();

  @override
  List<Object> get props => [];
}

class GetTweetAncestors extends TweetAncestorsEvent {
  GetTweetAncestors(this.id);
  int id;
}
