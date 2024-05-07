import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class UsePhoto extends StatefulWidget {
  UsePhoto({this.mediaTaken, this.retakeMedia, this.useMedia, super.key});
  XFile? mediaTaken;
  Function? retakeMedia;
  Function? useMedia;

  @override
  State<UsePhoto> createState() => _UsePhotoState();
}

class _UsePhotoState extends State<UsePhoto> {
  bool? _isMediaAPhoto;
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _isMediaAPhoto = widget.mediaTaken!.path.split(".").last != "mp4";
    if(_isMediaAPhoto! == false) {
      startVideo();
    }
  }

  startVideo() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.mediaTaken!.path));
    await _videoPlayerController!.initialize();
    await _videoPlayerController!.setLooping(true);
    await _videoPlayerController!.play();
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.mediaTaken != null ? WillPopScope(
      onWillPop: () async {
        widget.retakeMedia!();
        return false;
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: _isMediaAPhoto! ? Image.file(File(widget.mediaTaken!.path), fit: BoxFit.cover,)
                          : VideoPlayer(_videoPlayerController!),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: IconButton(
                        icon: const Icon(Icons.close_rounded, color: Colors.white,),
                        onPressed: () => widget.retakeMedia!(),
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 100,
            padding: const EdgeInsets.only(top: 30, right: 15, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () => widget.retakeMedia!(),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 8, horizontal: 15)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    backgroundColor: MaterialStateProperty.all(Colors.white)
                  ), 
                  child: const Text(
                    "Retake", 
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w800, fontSize: 15.5),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => widget.useMedia!(widget.mediaTaken), 
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 4, horizontal: 12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    backgroundColor: MaterialStateProperty.all(Colors.blue)
                  ), 
                  child: Text(
                    _isMediaAPhoto! ? "Use photo" : "Use Video",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15.5),
                  )
                )
              ],
            ),
            )
        ]
      ),
    ) 
    : const SizedBox();
  }
}