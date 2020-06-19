// import 'package:flute_music_player/flute_music_player.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';

// const kUrl = "Any Url Here !";

// class MusicPage extends StatefulWidget {
//   MusicPage({Key key, this.counter}) : super(key: key);
//   final Future<int> counter;
//   @override
//   _MusicPageState createState() => _MusicPageState();
// }

// enum PlayerState { stopped, playing, paused }

// class _MusicPageState extends State<MusicPage> {
//   Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//   Future<List<String>> _list;
//   Duration duration;
//   Duration position;

//   MusicFinder audioPlayer;

//   String localFilePath;

//   PlayerState playerState = PlayerState.stopped;

//   get isPlaying => playerState == PlayerState.playing;
//   get isPaused => playerState == PlayerState.paused;

//   get durationText =>
//       duration != null ? duration.toString().split('.').first : '';
//   get positionText =>
//       position != null ? position.toString().split('.').first : '';

//   bool isMuted = false;

//   @override
//   void initState() {
//     super.initState();
//     _list = _prefs.then((SharedPreferences prefs) {
//       return (prefs.getStringList('list_music') ?? List<String>());
//     });
//     initAudioPlayer();
//   }

//   Future initAudioPlayer() async {
//     audioPlayer = new MusicFinder();
//     var songs;
//     try {
//       songs = await MusicFinder.allSongs();
//     } catch (e) {
//       print(e.toString());
//     }

//     print(songs);
//     audioPlayer.setDurationHandler((d) => setState(() {
//           duration = d;
//         }));

//     audioPlayer.setPositionHandler((p) => setState(() {
//           position = p;
//         }));

//     audioPlayer.setCompletionHandler(() {
//       onComplete();
//       setState(() {
//         position = duration;
//       });
//     });

//     audioPlayer.setErrorHandler((msg) {
//       setState(() {
//         playerState = PlayerState.stopped;
//         duration = new Duration(seconds: 0);
//         position = new Duration(seconds: 0);
//       });
//     });

//     setState(() {
//       print(songs.toString());
//     });
//   }

//   void onComplete() {
//     setState(() => playerState = PlayerState.stopped);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     audioPlayer.stop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Music'),),
//       body:  Center(
//         child: new Material(
//             elevation: 2.0,
//             color: Colors.grey[200],
//             child: new Center(
//               child: new Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     new Material(child: _buildPlayer()),
//                     localFilePath != null
//                         ? new Text(localFilePath)
//                         : new Container(),
//                     new Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: new Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             new RaisedButton(
//                               onPressed: () => {},
//                               child: new Text('Download'),
//                             ),
//                             new RaisedButton(
//                               onPressed: () => _playLocal(),
//                               child: new Text('play local'),
//                             ),
//                           ]),
//                     )
//                   ]),
//             ))),
//       // body: Column(
//       //   children: [
//       //     Container(
//       //       height: 200,
//       //       color: Colors.blue,
//       //     ),
//       //     SingleChildScrollView(
//       //       child: Column(
//       //         children: <Widget>[
//       //           FutureBuilder(
//       //             future: _list,
//       //             builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
//       //               switch (snapshot.connectionState) {
//       //                 case ConnectionState.waiting:
//       //                   return Container();
//       //                 default:
//       //                   if (snapshot.hasError) {
//       //                     return Text('Error get music list');
//       //                   } else {
//       //                     if (snapshot.hasData) {
//       //                       return Container(height: 50.0, color: Colors.orange);
//       //                     }
//       //                   }
//       //                   return Container();
//       //               }
//       //             }
//       //           )
//       //         ]
//       //       ),
//       //     ),
//       //     // Container(
//       //     //   height: MediaQuery.of(context).size.height / 2,
//       //     //   color: Colors.orange,
//       //     // ),
//       //   ],
//       // ),
//     );
//   }

// Future play() async {
//     final result = await audioPlayer.play(kUrl);
//     if (result == 1)
//       setState(() {
//         print('_AudioAppState.play... PlayerState.playing');
//         playerState = PlayerState.playing;
//       });
//   }

//   Future _playLocal() async {
//     final result = await audioPlayer.play(localFilePath, isLocal: true);
//     if (result == 1) setState(() => playerState = PlayerState.playing);
//   }

//   Future pause() async {
//     final result = await audioPlayer.pause();
//     if (result == 1) setState(() => playerState = PlayerState.paused);
//   }

//   Future stop() async {
//     final result = await audioPlayer.stop();
//     if (result == 1)
//       setState(() {
//         playerState = PlayerState.stopped;
//         position = new Duration();
//       });
//   }

//   Future mute(bool muted) async {
//     final result = await audioPlayer.mute(muted);
//     if (result == 1)
//       setState(() {
//         isMuted = muted;
//       });
//   }

//   Widget _buildPlayer() => new Container(
//       padding: new EdgeInsets.all(16.0),
//       child: new Column(mainAxisSize: MainAxisSize.min, children: [
//         new Row(mainAxisSize: MainAxisSize.min, children: [
//           new IconButton(
//               onPressed: isPlaying ? null : () => play(),
//               iconSize: 64.0,
//               icon: new Icon(Icons.play_arrow),
//               color: Colors.cyan),
//           new IconButton(
//               onPressed: isPlaying ? () => pause() : null,
//               iconSize: 64.0,
//               icon: new Icon(Icons.pause),
//               color: Colors.cyan),
//           new IconButton(
//               onPressed: isPlaying || isPaused ? () => stop() : null,
//               iconSize: 64.0,
//               icon: new Icon(Icons.stop),
//               color: Colors.cyan),
//         ]),
//         duration == null
//             ? new Container()
//             : new Slider(
//                 value: position?.inMilliseconds?.toDouble() ?? 0,
//                 onChanged: (double value) =>
//                     audioPlayer.seek((value / 1000).roundToDouble()),
//                 min: 0.0,
//                 max: duration.inMilliseconds.toDouble()),
//         new Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             new IconButton(
//                 onPressed: () => mute(true),
//                 icon: new Icon(Icons.headset_off),
//                 color: Colors.cyan),
//             new IconButton(
//                 onPressed: () => mute(false),
//                 icon: new Icon(Icons.headset),
//                 color: Colors.cyan),
//           ],
//         ),
//         new Row(mainAxisSize: MainAxisSize.min, children: [
//           new Padding(
//               padding: new EdgeInsets.all(12.0),
//               child: new Stack(children: [
//                 new CircularProgressIndicator(
//                     value: 1.0,
//                     valueColor: new AlwaysStoppedAnimation(Colors.grey[300])),
//                 new CircularProgressIndicator(
//                   value: position != null && position.inMilliseconds > 0
//                       ? (position?.inMilliseconds?.toDouble() ?? 0.0) /
//                           (duration?.inMilliseconds?.toDouble() ?? 0.0)
//                       : 0.0,
//                   valueColor: new AlwaysStoppedAnimation(Colors.cyan),
//                   backgroundColor: Colors.yellow,
//                 ),
//               ])),
//           new Text(
//               position != null
//                   ? "${positionText ?? ''} / ${durationText ?? ''}"
//                   : duration != null ? durationText : '',
//               style: new TextStyle(fontSize: 24.0))
//         ])
//       ]));
// }