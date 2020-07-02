import 'dart:convert';

import 'package:epikodi/widgets/cardAdd.dart';
import 'package:epikodi/widgets/card_supp.dart';
import 'package:epikodi/widgets/info_card.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class YoutubePage extends StatefulWidget {
  YoutubePage({Key key}) : super(key: key);

  @override
  _YoutubePageState createState() => _YoutubePageState();
}

class _YoutubePageState extends State<YoutubePage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Map<String, dynamic> _mydata;
  Widget appBarTitle = new Text("Youtube");
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
    final String _data = (prefs.getString('yt4_added') ?? null);
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
                return ListView.separated(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> test = snapshot.data[index];
                      return CardSupp(post: test);
                      // return ListTile(
                      //   trailing: GestureDetector(
                      //       onTap: () => saveafterdelete(test),
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Icon(Icons.delete),
                      //       )),
                      //   leading: Image.network(test['video_thumbnail']),
                      //   // trailing: GestureDetector(
                      //   //   onTap: () => saveafteradd(post),
                      //   //   child: Icon(Icons.star_border)
                      //   // ),
                      //   title: Text(test['title']),
                      //   subtitle: Text(test['description']),
                      // );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider());
                //return Container(height: 100, color: Colors.blue);
              }
          }
        });
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
            return CardAdd(post: post,);
          },
        ),
      ),
    );
  }

  static Future<List<Post>> getYt(var url) async {
    print(url);
    List<Map<String, dynamic>> listareturn = [];
    var response = await http.Client().get(url);
    if (response.statusCode == 200) {
      //final responseJson = json.decode(response.body);
      // print(response.body);
      List<String> tmp = [];
      String newe = response.body.substring(0 + 1, response.body.length - 1);
      newe = newe.replaceAll(": '", ': "');
      newe = newe.replaceAll("',", '",');
      newe = newe.replaceAll("':", '":');
      newe = newe.replaceAll(", '", ', "');
      newe = newe.replaceAll("{'", '{"');
      newe = newe.replaceAll("None", '"None"');
      newe = newe.replaceAll(RegExp(r"datetime.datetime"), '"');
      newe = newe.replaceAll(RegExp(r"[0-9]\)"), ')"');
      tmp = newe.split('}, {');
      for (var i = 0; i < tmp.length; i++) {
        if (i == 0) {
          String test = tmp[i];
          test = "$test}";
          listareturn.add(json.decode(test));
        } else if (i == tmp.length - 1) {
          String test = tmp[i];
          test = "{$test";
          listareturn.add(json.decode(test));
        } else if (i != 0) {
          String test = tmp[i];
          test = "{$test}";
          listareturn.add(json.decode(test));
        }
      }
      return List.generate(listareturn.length, (int index) {
        String title = listareturn[index]["video_title"];
        String description = listareturn[index]["video_description"];
        String video_id = listareturn[index]["video_id"];
        String video_thumbnail = listareturn[index]["video_thumbnail"];
        return Post(
          "$title",
          "$description",
          "$video_id",
          "$video_thumbnail",
        );
      });
    } else {
      print("Error: failed to load post");
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
    String url = 'http://192.168.0.174:5000/youtube?name=${search}';
    return getYt(url);
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
