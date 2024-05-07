part of 'reply_input_cubit.dart';

class ReplyInputState extends Equatable {
  ReplyInputState({this.isTextFilled = false, this.isMediaselected = false});
  bool? isTextFilled;
  bool? isMediaselected;

  @override
  List<Object> get props => [isTextFilled!, isMediaselected!];
}

