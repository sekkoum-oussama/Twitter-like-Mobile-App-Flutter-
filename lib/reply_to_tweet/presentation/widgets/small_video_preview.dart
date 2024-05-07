import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:video_thumbnail/video_thumbnail.dart';


class VideoPreviewInMediaSelection extends StatefulWidget {
  VideoPreviewInMediaSelection(this.videoFile, {super.key});
  final File videoFile;

  @override
  State<VideoPreviewInMediaSelection> createState() => VideoPreviewInMediaSelectionState();
}

class VideoPreviewInMediaSelectionState extends State<VideoPreviewInMediaSelection> {
  Duration? _videoDuration;
  Uint8List? _videoThumbnail;
  bool _isMediaInfoReady = false;

  @override
  initState() {
    super.initState();
    videoInfo();
  }
  
  formatDuration(Duration duration) {
    return "${duration.inMinutes.toString().padLeft(2,'0')}:${(duration.inSeconds % 60).toString().padLeft(2,'0')}";
  }

  Future videoInfo() async {
    _videoThumbnail = await VideoThumbnail.thumbnailData(
      video:  widget.videoFile.path,
      imageFormat: ImageFormat.JPEG,
    );
    
    final flutterFfmpeg = FlutterFFprobe();
    final mediaInfo = await flutterFfmpeg.getMediaInformation(widget.videoFile.path);
    final props = mediaInfo.getMediaProperties();
    _videoDuration = Duration(seconds: double.parse(props!["duration"]).toInt());
    setState(() {
      _isMediaInfoReady = true;
    });
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_isMediaInfoReady) {
      return Stack(
        children: [
          Positioned.fill(
            child: Image.memory(_videoThumbnail!, fit: BoxFit.cover,),
          ),
          Positioned(
            bottom: 5,
            left: 5,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(160),
                borderRadius: BorderRadius.circular(3)
              ),
              child: Text(
                formatDuration(_videoDuration!),
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      );
    } else  {
      return  const Icon(Icons.video_file);
    }
  }
    
  
}