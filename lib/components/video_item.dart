import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'fade_animation.dart';

class VideoItem extends StatefulWidget {
  final video;
  VideoItem({@required this.video});
  @override
  createState() => VideoItemState();
}

class VideoItemState extends State<VideoItem> {
  var _controller;
  bool _isPlaying = false;
  var _videoStatusAnimation;

  @override
  initState() {
    super.initState();
    _videoStatusAnimation = Container();
    _controller = VideoPlayerController.network(widget.video)
      ..addListener(() {
        bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() => _isPlaying = isPlaying);
        }
      })
      ..initialize().then((_) {
        Timer(Duration(milliseconds: 1500), () {
          if (!mounted) return;
          setState(() {});
          // _controller.play();
        });
      });
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AspectRatio(
      aspectRatio: 16 / 9,
      child: _controller.value.initialized
          ? _videoPlayer()
          : Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () => _controller.play(),
                  child: Icon(
                    Icons.play_circle_outline,
                    color: Colors.white54,
                    size: 50.0,
                  ),
                )
              ],
            ));

  _videoPlayer() => Stack(
        children: [
          _video(),
          Align(
            alignment: Alignment.bottomCenter,
            child: VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              colors: VideoProgressColors(playedColor: Colors.white),
            ),
          ),
          Center(child: _videoStatusAnimation),
        ],
      );

  _video() => GestureDetector(
        child: VideoPlayer(_controller),
        onTap: () {
          if (!_controller.value.initialized) return;
          if (_controller.value.isPlaying) {
            _videoStatusAnimation = FadeAnimation(
                child: Icon(Icons.pause, size: 48.0, color: Colors.white));
            _controller.pause();
          } else {
            _videoStatusAnimation = FadeAnimation(
                child: Icon(Icons.play_arrow, size: 48.0, color: Colors.white));
            _controller.play();
          }
        },
      );
}
