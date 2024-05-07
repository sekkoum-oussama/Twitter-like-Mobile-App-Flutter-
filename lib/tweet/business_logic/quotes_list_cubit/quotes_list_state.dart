part of 'quotes_list_cubit.dart';

class QuotesListState extends Equatable {
  const QuotesListState();

  @override
  List<Object> get props => [];
}


class QuotesListInitial extends QuotesListState {}

class QuotesListLoading extends QuotesListState {}

class TweetNotFoundState extends QuotesListState {}

class QuotesListErrorState extends QuotesListState {}

class QuotesListLoaded extends QuotesListState {
  const QuotesListLoaded(this.quotes);
  final List<QuoteTweetModel> quotes;
}
