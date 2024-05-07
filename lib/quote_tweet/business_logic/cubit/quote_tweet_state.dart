part of 'quote_tweet_cubit.dart';

class QuoteTweetState extends Equatable {
  QuoteTweetState();

  @override
  List<Object> get props => [];
}

class QuoteTweetInitial extends QuoteTweetState {}

class QuoteTweetLoading extends QuoteTweetState {}

class TweetQuoted extends QuoteTweetState {}

class QuoteTweetError extends QuoteTweetState {}