import 'package:epikodi/pages/mixcloud_page.dart';
import 'package:epikodi/pages/spotify_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:epikodi/pages/youtube_page.dart';

class AddOnPage extends StatefulWidget {
  AddOnPage({Key key}) : super(key: key);

  @override
  _AddOnPageState createState() => _AddOnPageState();
}

class _AddOnPageState extends State<AddOnPage> {
  //Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool ytIsSwitched;
  bool mcIsSwitched;
  bool spIsSwitched = false;

  @override
  void initState() {
    super.initState();
    _setSwitch();
    _setSwitchMix();
    _setSwitchSp();
  }

  _setSwitch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool counter = (prefs.getBool('yt') ?? false);
    print('Pressed $counter times.');
    setState(() {
      ytIsSwitched = counter;
    });
    //await prefs.setBool('meteob', !counter);
  }

  _setSwitchMix() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool counter = (prefs.getBool('mc') ?? false);
    print('Pressed $counter times.');
    setState(() {
      mcIsSwitched = counter;
    });
    //await prefs.setBool('meteob', !counter);
  }

  _setSwitchSp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool counter = (prefs.getBool('sp') ?? false);
    print('Pressed $counter times.');
    setState(() {
      mcIsSwitched = counter;
    });
    //await prefs.setBool('meteob', !counter);
  }

  Future<bool> _getYtSwitch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool counter = (prefs.getBool('yt') ?? false);
    return counter;
  }

  _changeyt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool counter = (prefs.getBool('yt') ?? false);
    await prefs.setBool('yt', !counter);
  }

  Future<bool> _getMcSwitch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool counter = (prefs.getBool('mc') ?? false);
    return counter;
  }

  _changeMc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool counter = (prefs.getBool('mc') ?? false);
    await prefs.setBool('mc', !counter);
  }

  Future<bool> _getSpSwitch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool counter = (prefs.getBool('sp') ?? false);
    return counter;
  }

  _changeSp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool counter = (prefs.getBool('sp') ?? false);
    await prefs.setBool('sp', !counter);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FutureBuilder(
          future: _getYtSwitch(),
          initialData: ytIsSwitched,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Container(
                    height: 80,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                                'assets/icons8-lecture-de-youtube.svg'),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => YoutubePage()));
                            },
                            child: Text(
                              "Youtube",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ])),
                        Switch(
                          value: ytIsSwitched,
                          onChanged: (value) {
                            setState(() {
                              ytIsSwitched = value;
                              _changeyt();
                              //print(isSwitched);
                            });
                          },
                          activeTrackColor: Colors.lightGreenAccent[400],
                          activeColor: Colors.white,
                        ),
                      ],
                    ),
                  );
                }
            }
          },
        ),
        FutureBuilder(
          future: _getMcSwitch(),
          initialData: mcIsSwitched,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Container(
                    height: 80,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(17.0),
                            child: SvgPicture.asset(
                                'assets/icons8-mixcloud.svg'),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MixcloudPage()));
                            },
                            child: Text(
                              "MixCloud",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ])),
                        Switch(
                          value: mcIsSwitched,
                          onChanged: (value) {
                            setState(() {
                              mcIsSwitched = value;
                              _changeMc();
                              //print(isSwitched);
                            });
                          },
                          activeTrackColor: Colors.lightGreenAccent[400],
                          activeColor: Colors.white,
                        ),
                      ],
                    ),
                  );
                }
            }
          },
        ),
        FutureBuilder(
          future: _getSpSwitch(),
          initialData: spIsSwitched,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Container(
                    height: 80,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                                'assets/icons8-spotify.svg'),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SpotifyPage()));
                            },
                            child: Text(
                              "Spotify",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ])),
                        Switch(
                          value: spIsSwitched,
                          onChanged: (value) {
                            setState(() {
                              spIsSwitched = value;
                              _changeSp();
                            });
                          },
                          activeTrackColor: Colors.lightGreenAccent[400],
                          activeColor: Colors.white,
                        ),
                      ],
                    ),
                  );
                }
            }
          },
        ),
      ],
    );
  }
}
