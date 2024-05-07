part of 'add_reply_bloc.dart';

abstract class AddReplyState extends Equatable {
  const AddReplyState();
  
  @override
  List<Object> get props => [];
}

class AddReplyInitial extends AddReplyState {}

class AddReplyLoading extends AddReplyState {}

class AddReplyLoaded extends AddReplyState {
  AddReplyLoaded(this.reply);
  ReplyTweetModel reply;
}

class AddReplyTweetNotFound extends AddReplyState {}

class AddReplyError extends AddReplyState {}