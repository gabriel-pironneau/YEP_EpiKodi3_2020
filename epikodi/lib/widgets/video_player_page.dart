import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final String name;

  VideoPlayerPage({Key key, @required this.videoPlayerController, this.looping, this.name}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController:  widget.videoPlayerController,
      aspectRatio: 16/9,
      autoPlay: true,
      autoInitialize: true,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.blue,),
          )
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pos = widget.name.lastIndexOf('.');
    String result = (pos != -1)? widget.name.substring(0, pos) : widget.name;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(result, maxLines: 1, overflow: TextOverflow.ellipsis,)),
      body: Center(
        child: Chewie(
          controller: _chewieController,
        )
      ),

    );
  }
}