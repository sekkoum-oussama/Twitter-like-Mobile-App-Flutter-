part of 'add_reply_bloc.dart';

abstract class AddReplyEvent extends Equatable {
  const AddReplyEvent();

  @override
  List<Object> get props => [];
}

class AddReply extends AddReplyEvent {
  AddReply(this.related_to, {this.text = '', this.files = const []});
  int related_to;
  String? text;
  List files;
}
