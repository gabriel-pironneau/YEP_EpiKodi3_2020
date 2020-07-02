import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SpotifyPage extends StatefulWidget {
  SpotifyPage({Key key}) : super(key: key);

  @override
  _SpotifyPageState createState() => _SpotifyPageState();
}

class _SpotifyPageState extends State<SpotifyPage> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    test();
  }

  test() async {
    //var keyJson = await File('example/.apikeys').readAsString();
  print("Username : "+"Password : ");
   // isAuthenticating = true;
    //notifyListeners();
    try{
      FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: "", password: "");
      print(user.uid);
     // isAuthenticating = false;
    //  /
    
    }catch(e){
      // final ShowCustomAlertDialog showCustomAlertDialog = ShowCustomAlertDialog();
      print("Catch Error : "+e.message);
      // showCustomAlertDialog.showCustomDialog(context, e.message);
      // isAuthenticating = false;
      // loginButton = false;
     // notifyListeners();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue);
  }
}
