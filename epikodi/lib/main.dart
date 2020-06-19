import 'dart:io';

import 'package:epikodi/pages/add_on_page.dart';
import 'package:epikodi/pages/home_page.dart';
import 'package:epikodi/pages/music_pages.dart';
import 'package:epikodi/pages/picture_page.dart';
import 'package:epikodi/pages/video_page.dart';
import 'package:epikodi/pages/weather_page.dart';
import 'package:epikodi/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EpiKodi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Epikodi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //Future<int> _counter;
  Future<Map<String, dynamic>> _musics;
  Future<Map<String, dynamic>> _pictures;
  Future<Map<String, dynamic>> _videos;

  int _selectedPage = 0;
  final List<Widget> _pageOptions = [
    new AccueilPage(),
    new MusicPages(),
    new PicturePage(),
    new VideoPage(),
    new AddOnPage(),
    new WeatherPage(),
    new PicturePage(),
  ];

  final List<String> title = [
    "Epikodi",
    "Mes musiques",
    "Mes photos",
    "Mes vidéos",
    "Add-ons",
    "Weather",
    "Logout"
  ];

  @override
  void initState() {
    super.initState();
    _musics = mymusic();
    _pictures = mypictures();
    _videos = myvideo();
  }
  callBack(int index) {
    setState(() {
      this._selectedPage = index;
    });
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

  void _incrementCounter() {
    setState(() {
      // _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(selectedPage: _selectedPage, callBack: callBack,), //sidebar
      appBar: AppBar(
        title: Text(title[_selectedPage]),
      ),
      body: _pageOptions[_selectedPage],
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget accueil() {
    return new SingleChildScrollView(
      child: Column(children: <Widget>[
        serparatorCat('Music', Icons.audiotrack),
        musicSection(),
        serparatorCat('Picture', Icons.collections),
        pictureSection(),
        serparatorCat('Video', Icons.movie),
        videoSection()
      ]),
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
