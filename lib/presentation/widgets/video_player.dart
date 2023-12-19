import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatefulWidget {
  final String url;

  const MyVideoPlayer({Key? key, required this.url}) : super(key: key);

  @override
  MyVideoPlayerState createState() => MyVideoPlayerState();
}

class MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController _controller;
  late ChewieController? _chewieController;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      }).catchError((error) {
        // If there's an error, set the error state and rebuild the widget
        setState(() {
          _isError = true;
        });
      });
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: false,
      looping: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) {
      // If there's an error, show an error icon and a message
      return Container(
        height: 300,
        padding: const EdgeInsets.symmetric(vertical: 1.0),
        decoration: BoxDecoration(
            border: Border.all(width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(0))),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.error, color: Colors.red, size: 60),
              Text('Failed to load video'),
            ],
          ),
        ),
      );
    } else {
      return Container(
        height: 300,
        padding: const EdgeInsets.symmetric(vertical: 1.0),
        decoration: BoxDecoration(
            border: Border.all(width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(0))),
        child: Center(
          child: _controller.value.isInitialized
              ? Chewie(
                  controller: _chewieController!,
                )
              : const CircularProgressIndicator(),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
