import 'package:flutter/material.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class VideoPlayerNetPage extends StatefulWidget {
  final String id;
  final bool looping;
  final String name;

  VideoPlayerNetPage({Key key, @required this.id, this.looping, this.name}) : super(key: key);

  @override
  _VideoPlayerNetPageState createState() => _VideoPlayerNetPageState();
}

class _VideoPlayerNetPageState extends State<VideoPlayerNetPage> {
  ChewieController _chewieController;
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    // _chewieController = ChewieController(
    //   videoPlayerController:  widget.videoPlayerController,
    //   aspectRatio: 16/9,
    //   autoPlay: true,
    //   autoInitialize: true,
    //   looping: widget.looping,
    //   errorBuilder: (context, errorMessage) {
    //     return Center(
    //       child: Text(
    //         errorMessage,
    //         style: TextStyle(color: Colors.blue,),
    //       )
    //     );
    //   },
    // );
    _controller = YoutubePlayerController(
    initialVideoId: widget.id,
    flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
    ),
);
  }

// YoutubePlayer(
//     controller: _controller,
//     showVideoProgressIndicator: true,
//     videoProgressIndicatorColor: Colors.amber,
//     progressColors: ProgressColors(
//         playedColor: Colors.amber,
//         handleColor: Colors.amberAccent,
//     ),
//     onReady () {
//         _controller.addListener(listener);
//     },
// ),

  @override
  void dispose() {
    super.dispose();
    //widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pos = widget.name.lastIndexOf('.');
    String result = (pos != -1)? widget.name.substring(0, pos) : widget.name;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(result, maxLines: 1, overflow: TextOverflow.ellipsis,)),
      body:YoutubePlayerBuilder(
    player: YoutubePlayer(
        controller: _controller,
    ),
    builder: (context, player){
        return Column(
            children: [
                // some widgets
                player,
                //some other widgets
            ],
        );}
    ),
//),
      // body: Center(
      //   child: Chewie(
      //     controller: _chewieController,
      //   )
      // ),

    );
  }
}