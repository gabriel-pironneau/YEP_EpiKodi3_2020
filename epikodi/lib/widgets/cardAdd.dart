import 'dart:convert';

import 'package:epikodi/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardAdd extends StatefulWidget {
  final Post post;
  CardAdd({Key key, this.post}) : super(key: key);

  @override
  _CardAddState createState() => _CardAddState();
}

class _CardAddState extends State<CardAdd> {
  bool isAdd = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(widget.post.videoThumbnail),
      trailing: GestureDetector(
        onTap: () {
          saveafteradd(widget.post);
          setState(() {
            isAdd = !isAdd;
            if (isAdd) {
              Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("${widget.post.title} ajouté")));
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("${widget.post.title} supprimé")));
            }
          });
        },
        child: isAdd? Icon(Icons.star, color: Colors.yellow[700],)
        : Icon(Icons.star_border),
      ),
      title: Text(widget.post.title),
      subtitle: Text(widget.post.description),
    );
  }

  void saveafteradd(Post post) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final String _data = (prefs.getString('yt4_added') ?? null);
    //String lastdata;
    String json = jsonEncode(post);
    print("json!! " + json);
    //Map<String, dynamic> newone = toMap(post);
    //print(Post.fromJson(newone).toJson().toString());
    //String test = Post.fromJson(newone).toJson().toString();
    //print("TEst : " + test);
    String newtest;
    if (_data != null) {
      newtest = _data + ', ' + json;
    } else {
      newtest = json;
    }
    print("newwtest : " + newtest);
    //lastdata = json.decode(newtest);
    //print("last: " + lastdata);
    //print(_data);
    // List<Map<String, dynamic>> _mydata = json.decode(lastdata);
    //print("\ndata::: " + _mydata.toString());
    //print(_mydata);
    //_mydata.add(name);
    //print(_mydata);
    //lastdata = json.encode(_mydata);
    prefs.setString('yt4_added', newtest).then((bool success) {
      return;
    });
  }
}
