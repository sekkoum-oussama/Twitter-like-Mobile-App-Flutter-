part of 'retweet_list_cubit.dart';

class RetweetsListState extends Equatable {
  const RetweetsListState();

  @override
  List<Object> get props => [];
}

class RetweetsListInitial extends RetweetsListState {}

class RetweetsListLoading extends RetweetsListState {}

class RetweetsListError extends RetweetsListState {}

class TweetNotFoundState extends RetweetsListState {}

class RetweetsListLoaded extends RetweetsListState {
  const RetweetsListLoaded(this.users);
  final List users;
}
