import 'dart:io';

import 'package:flutter/material.dart';

class DisplayPicturePage extends StatelessWidget {
  const DisplayPicturePage({Key key, this.title, this.path}) : super(key: key);
  final String title;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Image.file(File(path)),
      ),
    );
  }
}