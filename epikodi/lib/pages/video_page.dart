import 'dart:io';

import 'package:epikodi/pages/play_music_page.dart';
import 'package:epikodi/widgets/video_player_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  VideoPage({Key key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _fileName;
  String _path;
  Map<String, String> _paths;
  Map<String, String> _pathsTMP;
  Future<Map<String, String>> _pathsADD;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = true;
  FileType _pickingType = FileType.video;
  TextEditingController _controller = new TextEditingController();

  void saveafterdelete(String name) async {
    final SharedPreferences prefs = await _prefs;
    final String _data = (prefs.getString('video_added') ?? null);
    String lastdata;
    //print(_data);
    Map<String, dynamic> _mydata = json.decode(_data);
    print(_mydata);
    _mydata.remove(name);
    print(_mydata);
    lastdata = json.encode(_mydata);
    prefs.setString('video_added', lastdata).then((bool success) {
      return;
    });
  }

  void _openFileExplorer() async {
    final SharedPreferences prefs = await _prefs;
    final String _pathsTM = prefs.getString('video_added') ?? null;
    Map<String, dynamic> _p;
    String _pf;
    if (_pathsTM != null)
      _p = json.decode(_pathsTM);
    else
      _p = Map();
    setState(() => _loadingPath = true);
    try {
      if (_multiPick) {
        _path = null;
        _paths = await FilePicker.getMultiFilePath(
            type: _pickingType,
            allowedExtensions: (_extension?.isNotEmpty ?? false)
                ? _extension?.replaceAll(' ', '')?.split(',')
                : null);
        print(_p);
        print(json.encode(_paths));
        //_pathsTM = _pathsADD as Map<String, String>;
        for (var i = 0; i < _paths.length; i++) {
          _p[_paths.keys.toList()[i]] = _paths.values.toList()[i];
        }
        _pf = json.encode(_p);
        setState(() {
          _pathsADD = prefs.setString('video_added', _pf).then((bool success) {
            return json.decode(_pf);
          });
        });
        print(_pathsTM);
      } else {
        _paths = null;
        _path = await FilePicker.getFilePath(
            type: _pickingType,
            allowedExtensions: (_extension?.isNotEmpty ?? false)
                ? _extension?.replaceAll(' ', '')?.split(',')
                : null);
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _path != null
          ? _path.split('/').last
          : _paths != null ? _paths.keys.toString() : '...';
    });
  }

  @override
  Widget build(BuildContext context) {
    return // Column(
        //   children: [
        //     Container(
        //       height: 200,
        //       color: Colors.blue,
        //       child: Row(
        //         children: <Widget>[
        //           Container(
        //             color: Colors.orange,
        //             width: MediaQuery.of(context).size.width / 2.5,
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text('3'),
        //                 Text('musiques'),
        //               ],
        //             ),
        //           ),
        //           Text('musiques')
        //         ]
        //       ),
        //     ),
        // new Center(
        //     child: new Padding(
        //   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        //   child:
        //new SingleChildScrollView(
        //child:
        new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 130,
          //color: Colors.blue,
          child: Row(children: <Widget>[
            Container(
              //color: Colors.orange,
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder<Map<String, dynamic>>(
                      future: mydata(),
                      builder: (BuildContext context,
                          AsyncSnapshot<Map<String, dynamic>> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: const CircularProgressIndicator());
                          default:
                            if (snapshot.hasError) {
                              return Container(
                                child: Text(
                                  "0",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            } else {
                              var nb = snapshot.data.length;
                              return Container(
                                child: Text(
                                  "$nb",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }
                        }
                      }),
                  //Text('3', style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Vidéo ajoutées',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              alignment: Alignment.center,
              child: new RaisedButton(
                color: Colors.blue,
                onPressed: () => _openFileExplorer(),
                child: new Text("Add new video",
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ]),
        ),
        // new Padding(
        //   padding: const EdgeInsets.only(top: 30.0),
        //   child: new DropdownButton(
        //       hint: new Text('LOAD PATH FROM'),
        //       value: _pickingType,
        //       items: <DropdownMenuItem>[
        //         new DropdownMenuItem(
        //           child: new Text('FROM AUDIO'),
        //           value: FileType.audio,
        //         ),
        //         new DropdownMenuItem(
        //           child: new Text('FROM IMAGE'),
        //           value: FileType.image,
        //         ),
        //         new DropdownMenuItem(
        //           child: new Text('FROM VIDEO'),
        //           value: FileType.video,
        //         ),
        //         new DropdownMenuItem(
        //           child: new Text('FROM MEDIA'),
        //           value: FileType.media,
        //         ),
        //         new DropdownMenuItem(
        //           child: new Text('FROM ANY'),
        //           value: FileType.any,
        //         ),
        //         new DropdownMenuItem(
        //           child: new Text('CUSTOM FORMAT'),
        //           value: FileType.custom,
        //         ),
        //       ],
        //       onChanged: (value) => setState(() {
        //             _pickingType = value;
        //             if (_pickingType != FileType.custom) {
        //               _controller.text = _extension = '';
        //             }
        //           })),
        // ),
        // new ConstrainedBox(
        //   constraints: BoxConstraints.tightFor(width: 100.0),
        //   child: _pickingType == FileType.custom
        //       ? new TextFormField(
        //           maxLength: 15,
        //           autovalidate: true,
        //           controller: _controller,
        //           decoration:
        //               InputDecoration(labelText: 'File extension'),
        //           keyboardType: TextInputType.text,
        //           textCapitalization: TextCapitalization.none,
        //         )
        //       : new Container(),
        // ),
        // new ConstrainedBox(
        //   constraints: BoxConstraints.tightFor(width: 200.0),
        //   child: new SwitchListTile.adaptive(
        //     title: new Text('Pick multiple files',
        //         textAlign: TextAlign.right),
        //     onChanged: (bool value) =>
        //         setState(() => _multiPick = value),
        //     value: _multiPick,
        //   ),
        // ),
        // new Padding(
        //   padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
        //   child: Column(
        //     children: <Widget>[
        //       new RaisedButton(
        //         onPressed: () => _openFileExplorer(),
        //         child: new Text("Open file picker"),
        //       ),
        //       new RaisedButton(
        //         onPressed: () => _selectFolder(),
        //         child: new Text("Pick folder"),
        //       ),
        //       new RaisedButton(
        //         onPressed: () => _clearCachedFiles(),
        //         child: new Text("Clear temporary files"),
        //       ),
        //     ],
        //   ),
        // ),
        new FutureBuilder<Map<String, dynamic>>(
            future: mydata(),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: const CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Text("error");
                  } else {
                    return Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      height: MediaQuery.of(context).size.height * 0.712,
                      child: new Scrollbar(
                          child: new ListView.separated(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final bool isMultiPath = true;
                          final String name = (isMultiPath
                              ? snapshot.data.keys.toList()[index]
                              : _fileName ?? '...');
                          final path = isMultiPath
                              ? snapshot.data.values.toList()[index].toString()
                              : _paths;
                          return Dismissible(
                             background: Container(
                              color: Colors.red,
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.delete),
                                  )),
                            ),
                            key: Key(name),
                            onDismissed: (direction) {
                              saveafterdelete(name);
                              setState(() {
                                //snapshot.data.remove(snapshot.data[index]);
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("$name supprimé")));
                              });
                            },
                            child: ListTile(
                              leading: Container(
                                  height: 40,
                                  width: 40,
                                  color: Colors.grey[350],
                                  child: Icon(
                                    Icons.movie,
                                    color: Colors.blue,
                                  )),
                              title: new Text(
                                name,
                              ),
                              subtitle: new Text(path),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VideoPlayerPage(
                                        videoPlayerController: VideoPlayerController.file(File(path)),
                                        looping: true,
                                        name: name,
                                )));
                              },
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            new Divider(),
                      )),
                    );
                  }
              }
            }),
      ],
    );
  }

  Future<Map<String, dynamic>> mydata() async {
    final SharedPreferences prefs = await _prefs;
    final String _data = (prefs.getString('video_added') ?? null);
    //print(_data);
    Map<String, dynamic> _mydata = json.decode(_data);
    return _mydata;
  }
}
