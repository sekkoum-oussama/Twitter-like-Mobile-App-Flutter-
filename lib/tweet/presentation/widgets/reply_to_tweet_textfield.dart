import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/tweet/business_logic/add_reply_bloc/add_reply_bloc.dart';

class ReplyToTweet extends StatefulWidget {
  ReplyToTweet(this._scrollController, this.tweet_id, {super.key});
  ScrollController? _scrollController;
  int tweet_id;

  @override
  State<ReplyToTweet> createState() => _ReplyToTweetState();
}

class _ReplyToTweetState extends State<ReplyToTweet> {
  FocusNode _focusNode = FocusNode();
  TextEditingController _textEditingController = TextEditingController();
  bool _isFocused = false;
  bool _isTextFieldEmpty = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusChanged);
  }

  _focusChanged() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  textFieldChanged(String text) {
    if (text.isNotEmpty && _isTextFieldEmpty) {
      setState(() {
        _isTextFieldEmpty = false;
      });
    } else if (text.isEmpty && !_isTextFieldEmpty) {
      setState(() {
        _isTextFieldEmpty = true;
      });
    }
  }

  textFieldTapped() {
    if(widget._scrollController != null) {
      if (widget._scrollController!.offset != 0) {
        widget._scrollController!.animateTo(0,
          duration: Duration(microseconds: 500), curve: Curves.easeIn);
      }
    }
    
  }

  addReply() {
    BlocProvider.of<AddReplyBloc>(context)
        .add(AddReply(widget.tweet_id, text: _textEditingController.text));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 45,
          child: WillPopScope(
            onWillPop: () async {
              if (_focusNode.hasFocus) {
                _focusNode.unfocus();
                return false;
              }
              return true;
            },
            child: BlocListener<AddReplyBloc, AddReplyState>(
              listener: (context, state) {
                if(state is AddReplyLoaded) {
                  _focusNode.unfocus();
                  _textEditingController.text = '';
                }
              },
              child: TextField(
                controller: _textEditingController,
                onTap: textFieldTapped,
                onChanged: textFieldChanged,
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1.5, color: Colors.blue)),
                  hintText: 'Tweet your reply',
                  hintStyle: TextStyle(
                      color: Colors.grey, fontSize: 13.5),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  isCollapsed: true,
                ),
              ),
            ),
          ),
        ),
        _isFocused
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _isTextFieldEmpty ? null : () => addReply(),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          _isTextFieldEmpty
                              ? Colors.blue.withOpacity(0.5)
                              : Colors.blue),
                      minimumSize: MaterialStateProperty.all(Size.zero),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6)),
                      elevation: const MaterialStatePropertyAll<double>(0),
                      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)
                          )
                      )
                   ),
                  child: const Text(
                    "Reply",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }
}
