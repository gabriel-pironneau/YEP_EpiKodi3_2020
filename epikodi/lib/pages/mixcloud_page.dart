import 'dart:convert';
import 'dart:io';

import 'package:epikodi/widgets/cardAdd.dart';
import 'package:epikodi/widgets/info_card.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class MixcloudPage extends StatefulWidget {
  MixcloudPage({Key key}) : super(key: key);

  @override
  _MixcloudPageState createState() => _MixcloudPageState();
}

class _MixcloudPageState extends State<MixcloudPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Map<String, dynamic> _mydata;
  Widget appBarTitle = new Text("Mixcloud");
  Icon actionIcon = new Icon(Icons.search);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          title: appBarTitle,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.star)),
              Tab(icon: Icon(Icons.search)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            favPage(),
            searchPage(),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> mydata() async {
    final SharedPreferences prefs = await _prefs;
    List<Map<String, dynamic>> _mydata = [];
    final String _data = (prefs.getString('mc_added') ?? null);
    print('data !!! ' + _data);

    List<String> _testdata = _data.split(', ');
    for (int i = 0; i < _testdata.length; i++) {
      _mydata.add(jsonDecode(_testdata[i]));
    }
    return _mydata;
  }

  Widget favPage() {
    return FutureBuilder(
        future: mydata(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: const CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Text("error");
              } else {
                //print("TTEESS = " + test['title']);
                return ListView.separated(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> test = snapshot.data[index];
                      return ListTile(
                        trailing: GestureDetector(
                            onTap: () => saveafterdelete(test),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.delete),
                            )),
                        leading: Image.network(test['videoThumbnail']),
                        // trailing: GestureDetector(
                        //   onTap: () => saveafteradd(post),
                        //   child: Icon(Icons.star_border)
                        // ),
                        title: Text(test['title']),
                        subtitle: Text(test['description']),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider());
                //return Container(height: 100, color: Colors.blue);
              }
          }
        });
  }

  void saveafterdelete(Map<String, dynamic> post) async {
    final SharedPreferences prefs = await _prefs;
    final String _data = (prefs.getString('mc_added') ?? null);
    String title = post['video_id'];
    List<String> listall = _data.split(', ');
    String newlist;
    for (int i = 0; i < listall.length; i++) {
      Map<String, dynamic> single = jsonDecode(listall[i]);
      if (single['video_id'] == title) {
        listall.removeAt(i);
        for (int i = 0; i < listall.length; i++) {
          print("LOOOOL" + listall[i]);

          if (i == listall.length - 1 && i != 0) {
            print(i.toString() + "mdrr" + listall.length.toString());
            newlist += listall[i];
          } else if (i == 0 && listall.length == 1) {
            print("loofl");
            newlist = listall[i];
          } else if (i == 0) {
            print("loofl");
            newlist = listall[i] + ", ";
          } else {
            print("lool");
            newlist += listall[i] + ", ";
          }
        }
        print("LASST = " + newlist);
        prefs.setString('mc_added', newlist).then((bool success) {
          return;
        });
      }
    }
    //String json = jsonEncode(post);
    //print("json!! " + json);
    //Map<String, dynamic> newone = toMap(post);
    //print(Post.fromJson(newone).toJson().toString());
    //String test = Post.fromJson(newone).toJson().toString();
    //print("TEst : " + test);
    //   String newtest;
    //   if (_data != null) {
    //     newtest = _data + ', ' + json;
    //   } else {
    //     newtest = json;
    //   }
    //   print("newwtest : " + newtest);
    //   //lastdata = json.decode(newtest);
    //   //print("last: " + lastdata);
    //   //print(_data);
    //  // List<Map<String, dynamic>> _mydata = json.decode(lastdata);
    //   //print("\ndata::: " + _mydata.toString());
    //   //print(_mydata);
    //   //_mydata.add(name);
    //   //print(_mydata);
    //   //lastdata = json.encode(_mydata);
    //   prefs.setString('yteaaed_added', newtest).then((bool success) {
    //     return;
    //   }
    //   );
  }

  

  Widget searchPage() {
    // Widget appBarTitle = new Text("Youtube");
    // Icon actionIcon = new Icon(Icons.search);
    return Container(
      height: MediaQuery.of(context).size.height - 150,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SearchBar(
          onSearch: search,
          onItemFound: (Post post, int index) {
            return CardAddMix();
          },
        ),
      ),
    );
  }

  static Future<List<Post>> getMc(var url) async {
    print(url);
    List<Map<String, dynamic>> listareturn = [];
    var response = await http.Client().get(url);
    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> list = json.decode(response.body);
      print("mdrrrrrrrrrrr" + list["music1"]["author"]);
      print(list.length.toString());
      return List.generate(list.length, (int index) {
        print("music${index}");
        String title = list["music${index}"]["title"];
        String description = list["music${index}"]["author"];
        String video_id = list["music${index}"]["url"];
        String video_thumbnail = list["music${index}"]["video_thumbnail"];
        return Post(
          "$title",
          "$description",
          "$video_id",
          "$video_thumbnail",
        );
      });
    } else {
      print("Error: failed to post");
      return List.generate(listareturn.length, (int index) {
        return Post(
          "Title : $index",
          "Description : $index",
          "video_id : $index",
          "video_thumbnail : $index",
        );
      });
    }
  }

  Future<List<Post>> search(String search) async {
    Future<List<Map<String, dynamic>>> listareturn;
    await Future.delayed(Duration(seconds: 2));
    if (search == "empty") return [];
    if (search == "error") throw Error();
    String url = 'http://192.168.0.174:5000/mixcloud?name=${search}';
    return getMc(url);
  }

  Map<String, dynamic> toMap(Post post) {
    Map<String, dynamic> returnMap = new Map();
    returnMap['title'] = post.title;
    returnMap['description'] = post.description;
    returnMap['video_id'] = post.videoId;
    returnMap['video_thumbnail'] = post.videoThumbnail;
    return returnMap;
  }
}

class CardAddMix extends StatefulWidget {
  final Post post;
  CardAddMix({Key key, this.post}) : super(key: key);

  @override
  _CardAddMixState createState() => _CardAddMixState();
}

class _CardAddMixState extends State<CardAddMix> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isTap = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(widget.post.videoThumbnail),
      trailing: GestureDetector(
          onTap: (){ saveafteraddmc(widget.post); isTap != isTap; } ,
      child: isTap? Icon(Icons.star, color: Colors.yellow[800],) : Icon(Icons.star_border)),
      title: Text(widget.post.title),
      subtitle: Text(widget.post.description),
    );
  }
  void saveafteraddmc(Post post) async {
    final SharedPreferences prefs = await _prefs;
    final String _data = (prefs.getString('mc_added') ?? null);
    String lastdata;
    String json = jsonEncode(post);
    print("json!! " + json);
    String newtest;
    if (_data != null) {
      newtest = _data + ', ' + json;
    } else {
      newtest = json;
    }
    print("newwtest : " + newtest);
    prefs.setString('mc_added', newtest).then((bool success) {
      return;
    });
  }
}
