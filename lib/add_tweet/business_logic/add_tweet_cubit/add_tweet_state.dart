part of 'add_tweet_cubit.dart';

class AddTweetState extends Equatable {
  const AddTweetState();

  @override
  List<Object> get props => [];
}

class AddTweetInitial extends AddTweetState {}

class AddTweetLoading extends AddTweetState {}

class TweetAddedState extends AddTweetState {}

class AddTweetError extends AddTweetState {
  const AddTweetError(this.errorMsg);
  final String errorMsg;
}

class AddTweetUnknownError extends AddTweetState {}