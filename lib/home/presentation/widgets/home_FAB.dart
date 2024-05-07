import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class HomeScreenFAB extends StatelessWidget {
  const HomeScreenFAB(this._showBottomMenu, {super.key});
  final bool? _showBottomMenu;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      clipBehavior: Clip.hardEdge,
      height: _showBottomMenu! ? 50 : 0,
      duration: const Duration(milliseconds: 170),
      curve: Curves.linear,
      decoration: const BoxDecoration(),
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor: Color(0xFF448AFF),
        child: const Icon(Icons.add, color: Colors.white, size: 27,),
        onPressed: () async{
          final addTweetResult = await Navigator.of(context).pushNamed('/addTweet');
          if(addTweetResult == true) {
            // ignore: use_build_context_synchronously
            Flushbar(
                      margin: const EdgeInsets.only(top: 6, left: 2, right: 2),
                      positionOffset: 5,
                      message: "Your Post Was Sent",
                      messageColor: Theme.of(context).textTheme.bodyText1!.color,
                      icon: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.lightBlue,
                          child: Icon(
                            Icons.done_outlined,
                            size: 13,
                            color: Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : Colors.black,
                          )),
                      duration: const Duration(seconds: 3),
                      borderRadius: BorderRadius.circular(8),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(255, 204, 224, 255)
                              : const Color.fromARGB(255, 11, 41, 66),
                      ).show(context);
          }
        }
      )
    );
  }
}