import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddOnPage extends StatefulWidget {
  AddOnPage({Key key}) : super(key: key);

  @override
  _AddOnPageState createState() => _AddOnPageState();
}

class _AddOnPageState extends State<AddOnPage> {
  //Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool ytIsSwitched;

  @override
  void initState() {
    super.initState();
    _setSwitch();
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

  Future<bool> _getYtSwitch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool counter = (prefs.getBool('yt') ?? false);
    return counter;
  }

  _changeyt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool counter = (prefs.getBool('yt') ?? false);
    print('Pressed $counter times.');
    await prefs.setBool('yt', !counter);
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
                    height: 100,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                                'assets/icons8-lecture-de-youtube.svg'),
                          ),
                          Text(
                            "Youtube",
                            style: TextStyle(fontSize: 15),
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
      ],
    );
  }
}
