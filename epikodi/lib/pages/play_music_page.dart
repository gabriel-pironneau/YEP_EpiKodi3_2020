import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:epikodi/widgets/player_widget.dart';
import 'package:flutter/material.dart';

class PlayMusicPage extends StatefulWidget {
  final String title;
  final String path;
  PlayMusicPage({Key key, this.title, this.path}) : super(key: key);

  @override
  _PlayMusicPageState createState() => _PlayMusicPageState();
}

class _PlayMusicPageState extends State<PlayMusicPage> {
  Duration _duration = Duration();
  Duration _position = Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  String localFilePath;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    advancedPlayer.durationHandler = (p) => setState(() {
          _position = p;
        });
  }
// Future _loadFile() async {
//     //final bytes = await readBytes(kUrl1);
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File('${dir.path}/audio.mp3');

//     await file.writeAsBytes(bytes);
//     if (await file.exists()) {
//       setState(() {
//         localFilePath = file.path;
//       });
//     }
//   }

  Widget localFile() {
    var test = widget.path;
    return _Tab(children: [
      //_Btn(txt: 'Download File to your Device', onPressed: () => _loadFile()),
      test == null
          ? Container()
          : PlayerWidget(
              url: test,
            ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    //print(this.title);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.navigate_before,
            color: Colors.blue,
            size: 42,
          ),
        ),
      ),
      body: Column(children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height / 2,
          color: Colors.blue,
          child: Text(widget.title),
        ),
        localFile()
      ]),
    );
  }
}
class _Tab extends StatelessWidget {
  final List<Widget> children;

  const _Tab({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: children
                .map((w) => Container(child: w, padding: EdgeInsets.all(6.0)))
                .toList(),
          ),
        ),
      ),
    );
  }
}
class _Btn extends StatelessWidget {
  final String txt;
  final VoidCallback onPressed;

  const _Btn({Key key, this.txt, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: 48.0,
        child: RaisedButton(child: Text(txt), onPressed: onPressed));
  }
}