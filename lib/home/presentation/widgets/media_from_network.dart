import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class MediaFromNetwork extends StatefulWidget {
  MediaFromNetwork(this.media, {this.videoCanBePlayed = false, super.key});
  final Map media;
  bool? videoCanBePlayed;

  @override
  State<MediaFromNetwork> createState() => _MediaFromNetworkState();
}

class _MediaFromNetworkState extends State<MediaFromNetwork> {
  bool _isMediaAPhoto = true;

  @override
  void initState() {
    super.initState();
    _isMediaAPhoto = widget.media["file"].split(".").last != "mp4";
  }

  @override
  Widget build(BuildContext context) {
    return _isMediaAPhoto ? CachedNetworkImage(imageUrl: widget.media["file"], fit: BoxFit.cover,) //Image.network(widget.media["file"], fit: BoxFit.cover,)
            : VideoPreviewFromNetwork(widget.media, videoCanBePlayed: widget.videoCanBePlayed,);
    
  }
}


class VideoPreviewFromNetwork extends StatefulWidget {
  VideoPreviewFromNetwork(this.mediaVideo, {this.videoCanBePlayed = false, super.key});
  final Map mediaVideo;
  bool? videoCanBePlayed;

  @override
  State<VideoPreviewFromNetwork> createState() => _VideoPreviewFromNetworkState();
}

class _VideoPreviewFromNetworkState extends State<VideoPreviewFromNetwork> {
  bool? isVideoPlayerVisible ;
  
  @override
  void initState() {
    super.initState();
    isVideoPlayerVisible = false;
  }
  
  showVideoPlayer() {
    setState(() {
      isVideoPlayerVisible = true; 
    });
  }
  @override
  Widget build(BuildContext context) {
    return isVideoPlayerVisible! ? 
          MediaVideo(widget.mediaVideo["file"]):
          VideoThumbnail(widget.mediaVideo, showVideoPlayer, videoCanBePlayed: widget.videoCanBePlayed);
  }
}


class VideoThumbnail extends StatefulWidget {
  VideoThumbnail(this.mediaVideo, this.showVideoPlayer, {this.videoCanBePlayed = false, super.key});
  final Map mediaVideo;
  Function showVideoPlayer;
  bool? videoCanBePlayed; 

  @override
  State<VideoThumbnail> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
    Duration? _videoDuration;

  @override
  initState() {
    super.initState();
    videoInfo();
  }
  
  formatDuration(Duration duration) {
    return "${duration.inMinutes.toString().padLeft(2,'0')}:${(duration.inSeconds % 60).toString().padLeft(2,'0')}";
  }

  Future videoInfo() async {
    final VideoPlayerController _controller = VideoPlayerController.networkUrl(Uri.parse(widget.mediaVideo["file"]));
    await _controller.initialize();
    _videoDuration = _controller.value.duration;
    _controller.dispose();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CachedNetworkImage(imageUrl: widget.mediaVideo["thumbnail"], fit: BoxFit.cover,),
        ),
        Positioned.fill(
          child: Center(
            child: widget.videoCanBePlayed! ?
              GestureDetector(
                onTap: () => widget.showVideoPlayer(),
                child: Image.asset("assets/icons/twitter-play-video.png", width: 50, fit: BoxFit.cover,),
              )
              : Image.asset("assets/icons/twitter-play-video.png", width: 50, fit: BoxFit.cover,),
          ),
        ),
        Positioned(
          bottom: 5,
          left: 5,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(160),
              borderRadius: BorderRadius.circular(3)
            ),
            child: Text(
              _videoDuration == null ? "00:00" : formatDuration(_videoDuration!),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}


class MediaVideo extends StatefulWidget {
  MediaVideo(this.videoUrl, {super.key});
  String videoUrl;

  @override
  State<MediaVideo> createState() => _MediaVideoState();
}

class _MediaVideoState extends State<MediaVideo> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
    ..initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true
      );
      setState(() { });
    });

  }
  @override
  Widget build(BuildContext context) {
    return _videoPlayerController!.value.isInitialized ? 
          Chewie(controller: _chewieController!)
          : Container(
            color: Colors.black,
            child: const Center(child: CircularProgressIndicator(color: Colors.white,)),
          );
  }
}