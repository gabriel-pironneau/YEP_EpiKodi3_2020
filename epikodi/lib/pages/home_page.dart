import 'dart:convert';
import 'dart:io';

import 'package:epikodi/pages/music_pages.dart';
import 'package:epikodi/pages/video_page.dart';
import 'package:epikodi/widgets/value_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:weather/weather.dart';

class AccueilPage extends StatefulWidget {
  AccueilPage({Key key}) : super(key: key);

  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _counter;
  Future<Map<String, dynamic>> _musics;
  Future<Map<String, dynamic>> _pictures;
  Future<Map<String, dynamic>> _videos;
  Future<bool> _meteo;
  bool _yt;

  WeatherStation weatherStation;
  Weather weather;

  Map<String, IconData> _icon = {
    "Clouds": WeatherIcons.wiDayCloudy,
    "Rain": WeatherIcons.wiDayRain,
  };

  @override
  void initState() {
    super.initState();
    weatherStation = new WeatherStation("64a1ac19aed98c8f4311503a5470c468");
    _musics = mymusic();
    _pictures = mypictures();
    _videos = myvideo();
    _meteo = mymeteo();
    _getYtSwitch();
  }

  Future<bool> _getYtSwitch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool counter = (prefs.getBool('yt') ?? false);
    
    return counter;
  }

  Future<Weather> getWeather() async {
    weather = await weatherStation.currentWeather();
    print(weather);
    print(weather.weatherMain);
    print(weather.sunrise);
    //print(weather.cityName);
    return weather;
  }

  Future<bool> mymeteo() async {
    final SharedPreferences prefs = await _prefs;
    final bool _data = (prefs.getBool('meteob') ?? false);
    return _data;
  }

  Future<Map<String, dynamic>> myvideo() async {
    final SharedPreferences prefs = await _prefs;
    final String _data = (prefs.getString('video_added') ?? null);
    //print(_data);
    Map<String, dynamic> _mydata = json.decode(_data);
    return _mydata;
  }

  Future<Map<String, dynamic>> mypictures() async {
    final SharedPreferences prefs = await _prefs;
    final String _data = (prefs.getString('picture_added') ?? null);
    //print(_data);
    Map<String, dynamic> _mydata = json.decode(_data);
    return _mydata;
  }

  Future<Map<String, dynamic>> mymusic() async {
    final SharedPreferences prefs = await _prefs;
    final String _data = (prefs.getString('music_added') ?? null);
    //print(_data);
    Map<String, dynamic> _mydata = json.decode(_data);
    return _mydata;
  }

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: Column(children: <Widget>[
        meteoSection(),
        ytSection(),
        serparatorCat('Music', Icons.audiotrack),
        musicSection(),
        serparatorCat('Picture', Icons.collections),
        pictureSection(),
        serparatorCat('Video', Icons.movie),
        videoSection(),
        SizedBox(height: 10),
        SizedBox(height: 20)
      ]),
    );
  }

  Widget ytSection() {
    return new Container(
      child: FutureBuilder(
          future: _getYtSwitch(),
          initialData: false,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Container();
                } else if (snapshot.data == true) {
                  return Column(
                    children: <Widget>[
                      serparatorCatYt("Youtube"),
                      youtubeSection(),
                    ],
                  );
                }
                return Container();
            }
          }),
    );
  }

  Widget serparatorCat(String title, IconData icon) {
    return Container(
      padding: EdgeInsets.all(15.0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blue,
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget serparatorCatYt(String title) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(15.0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          SvgPicture.asset('assets/icons8-lecture-de-youtube.svg'),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Container youtubeSection() {
    return Container(height: 160, color: Colors.black, child: Center(child:CircularProgressIndicator()),);
  }

  Container meteoSection() {
    return new Container(
      child: FutureBuilder(
        future: mymeteo(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Container();
              } else if (snapshot.data == true) {
                return Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [Colors.blue, Colors.red])),
                    height: 160,
                    child: FutureBuilder(
                      future: getWeather(),
                      builder: (BuildContext context,
                          AsyncSnapshot<Weather> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Container();
                          default:
                            if (snapshot.hasError) {
                              return Container();
                            } else {
                              weather = snapshot.data;
                              return Row(children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 15.0, top: 15, bottom: 15),
                                          alignment: Alignment.topLeft,
                                          child: Text('Météo',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white))),
                                      Icon(
                                        _icon[weather.weatherMain],
                                        size: 60,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        '${weather.temperature.celsius.round()}°',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 80,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          ValueTileWhite("max",
                                              '${this.weather.tempMin.celsius.round()}°'),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Center(
                                                child: Container(
                                              width: 1,
                                              height: 30,
                                              color: Colors.white,
                                            )),
                                          ),
                                          ValueTileWhite("min",
                                              '${this.weather.tempMax.celsius.round()}°'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]);
                            }
                        }
                      },
                    ));
              } else {
                return Container();
              }
          }
        },
      ),
    );
  }

  Container videoSection() {
    return new Container(
      //height: 200,
      width: MediaQuery.of(context).size.width,
      //color: Colors.blue,
      child: FutureBuilder<Map<String, dynamic>>(
        future: _videos,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoPage()));
                          },
                          child: Icon(
                            Icons.add_circle,
                            size: 35,
                            color: Colors.blue,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Add videos',
                          style: TextStyle(fontSize: 15),
                        ),
                      )
                    ]));
              } else {
                print(snapshot.data.length);
                if (snapshot.data.length == 0) {
                  return Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MusicPages()));
                            },
                            child: Icon(
                              Icons.add_circle,
                              size: 35,
                              color: Colors.blue,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Add videos',
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      ]));
                } else {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final String name = snapshot.data.keys.toList()[index];
                        final String path =
                            snapshot.data.values.toList()[index].toString();
                        return Card(
                          child: Container(
                            //padding: EdgeInsets.all(10.0),
                            width: 190,
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey[350],
                                  child: Icon(
                                    Icons.movie,
                                    color: Colors.blue,
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Text(name))),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                // return Container();
              }
          }
        },
      ),
    );
  }

  Container pictureSection() {
    return new Container(
      //height: 200,
      width: MediaQuery.of(context).size.width,
      //color: Colors.blue,
      child: FutureBuilder<Map<String, dynamic>>(
        future: _pictures,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Error sharedpref');
              } else {
                print(snapshot.data.length);
                if (snapshot.data.length == 0) {
                  return Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MusicPages()));
                            },
                            child: Icon(
                              Icons.add_circle,
                              size: 35,
                              color: Colors.blue,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Add pictures',
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      ]));
                } else {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final String name = snapshot.data.keys.toList()[index];
                        final String path =
                            snapshot.data.values.toList()[index].toString();
                        return Card(
                          child: Container(
                            //padding: EdgeInsets.all(10.0),
                            width: 190,
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  //    padding: EdgeInsets.all(8.0),
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey[350],
                                  child: Image.file(File(path)),
                                ),
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Text(name))),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                // return Container();
              }
          }
        },
      ),
    );
  }

  Container musicSection() {
    return new Container(
      //height: 200,
      width: MediaQuery.of(context).size.width,
      //color: Colors.blue,
      child: FutureBuilder<Map<String, dynamic>>(
        future: _musics,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Error sharedpref');
              } else {
                print(snapshot.data.length);
                if (snapshot.data.length == 0) {
                  return Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MusicPages()));
                            },
                            child: Icon(
                              Icons.add_circle,
                              size: 35,
                              color: Colors.blue,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Add music',
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      ]));
                } else {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final String name = snapshot.data.keys.toList()[index];
                        final path =
                            snapshot.data.values.toList()[index].toString();
                        return Card(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            width: 190,
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  height: 90,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey[350],
                                  child: Icon(Icons.music_note,
                                      color: Colors.blue),
                                ),
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Text(name))),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                // return Container();
              }
          }
        },
      ),
    );
  }
}
