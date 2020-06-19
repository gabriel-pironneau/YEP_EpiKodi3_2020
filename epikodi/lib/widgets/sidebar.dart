import 'package:epikodi/pages/music_pages.dart';
import 'package:epikodi/pages/picture_page.dart';
import 'package:epikodi/pages/video_page.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {
  final int selectedPage;
  final Function callBack;
  NavDrawer({Key key, this.selectedPage, this.callBack}) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'EpiKodi',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              // image: DecorationImage(
              //     fit: BoxFit.fill,
              //     image: AssetImage('assets/images/cover.jpg'))
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.blue),
            title: Text('Accueil'),
            onTap: () => {
              widget.callBack(0)
              //Navigator.of(context).pop()
              // if (index == widget.selectedPage) {
              //       widget.callBack(0)
              //     } else {
              //       widget.callBack(0)
              //     }
            // Navigator.of(context).pop()
            },
          ),
          ListTile(
            leading: Icon(Icons.audiotrack, color: Colors.blue),
            title: Text('Musics'),
            onTap: () => {
              widget.callBack(1)
              //Navigator.push(context, MaterialPageRoute(builder: (context) => MusicPages())),
            },
          ),
          ListTile(
            leading: Icon(Icons.collections, color: Colors.blue,),
            title: Text('Pictures'),
            onTap: () => {
              widget.callBack(2)
              //Navigator.push(context, MaterialPageRoute(builder: (context) => PicturePage())),
            },
          ),
          ListTile(
            leading: Icon(Icons.movie, color: Colors.blue),
            title: Text('Videos'),
            onTap: () => {
              widget.callBack(3)
              //Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage())),
            },
          ),
          ListTile(
            leading: Icon(Icons.archive, color: Colors.blue),
            title: Text('Add-ons'),
            onTap: () => {
              widget.callBack(4)
            //  Navigator.of(context).pop()
            },
          ),
          ListTile(
            leading: Icon(Icons.filter_drama, color: Colors.blue),
            title: Text('Weather'),
            onTap: () => {
              widget.callBack(5)
              //Navigator.of(context).pop()
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.blue),
            title: Text('Logout'),
            onTap: () => {
              widget.callBack(6)
            //  Navigator.of(context).pop()
            },
          ),
        ],
      ),
    );
  }
}

// class NavDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
    
//   }
// }
