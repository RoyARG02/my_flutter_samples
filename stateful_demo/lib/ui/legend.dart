import 'package:flutter/material.dart';

class Legend extends StatelessWidget {
  String _text;
  Color _color;

  Legend({Color color, String text}) {
    this._text = text;
    this._color = color;
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Container(
            margin: EdgeInsets.all(5.0),
            height: 15.0,
            width: 15.0,
            color: this._color),
        new Text(
          this._text,
          textAlign: TextAlign.start,
          style: new TextStyle(fontSize: 18),
        )
      ],
    );
  }
}
