import 'package:flutter/material.dart';

/// General utility widget used to render a cell divided into three rows
/// First row displays [label]
/// second row displays [iconData]
/// third row displays [value]
class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData iconData;

  ValueTile(this.label, this.value, {this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          this.label,
          style: TextStyle(),
        ),
        SizedBox(
          height: 5,
        ),
        this.iconData != null
            ? Icon(
                iconData,
                size: 20,
              )
            :  Container(width: 0, height: 0,),
        SizedBox(
          height: 10,
        ),
        Text(
          this.value,
          style:
              TextStyle(),
        ),
      ],
    );
  }
}

class ValueTileWhite extends StatelessWidget {
  final String label;
  final String value;
  final IconData iconData;

  ValueTileWhite(this.label, this.value, {this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          this.label,
          style: TextStyle( color: Colors.white,),
        ),
        SizedBox(
          height: 5,
        ),
        this.iconData != null
            ? Icon(
                iconData,
                size: 20,
              )
            :  Container(width: 0, height: 0,),
        SizedBox(
          height: 10,
        ),
        Text(
          this.value,
          style:
              TextStyle( color: Colors.white,),
        ),
      ],
    );
  }
}