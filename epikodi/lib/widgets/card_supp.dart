import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardSupp extends StatefulWidget {
  final Map<String, dynamic> post;
  CardSupp({Key key, this.post}) : super(key: key);

  @override
  _CardSuppState createState() => _CardSuppState();
}

class _CardSuppState extends State<CardSupp> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: GestureDetector(
          onTap: () => saveafterdelete(widget.post),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.delete),
          )),
      leading: Image.network(widget.post['videoThumbnail']),
      // trailing: GestureDetector(
      //   onTap: () => saveafteradd(post),
      //   child: Icon(Icons.star_border)
      // ),
      title: Text(widget.post['title']),
      subtitle: Text(widget.post['description']),
    );
  }

  void saveafterdelete(Map<String, dynamic> post) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final String _data = (prefs.getString('yt4_added') ?? null);
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
        prefs.setString('yt4_added', newlist).then((bool success) {
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
}
