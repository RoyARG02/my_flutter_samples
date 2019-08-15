import 'package:flutter/material.dart';

class GestureButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        final showTap = new SnackBar(
          // * defined a Snackbar (info bars popping from the bottom of screen)
          content: new Text('You tapped the button'),
          duration: new Duration(
              seconds: 1,
              milliseconds:
                  500), // * the time during which the SnackBar stays on Screen
          action: new SnackBarAction(
              label: 'OK',
              onPressed: () {
                final snackBarCeption = new SnackBar(
                    content: new Text('SNACKBARCEPTION!!!'),
                    duration: new Duration(seconds: 2, microseconds: 500));
                Scaffold.of(context).showSnackBar(
                    snackBarCeption); // * Enabling the SnackBar to be shown at the enclosing Scaffold
              }),
        );
        Scaffold.of(context).showSnackBar(showTap);
      },
      onLongPress: () {
        final showLongPress = new SnackBar(
            content: new Text('You long-pressed the button'),
            duration: new Duration(seconds: 1, microseconds: 900));
        Scaffold.of(context).showSnackBar(showLongPress);
      },
      child: new Container(
        width: 120,
        height: 90,
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(
                5.5), // * curves the corners of the Box defined for the container
            color: Theme.of(context).buttonColor),
        margin: EdgeInsets.all(12.0),
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(Icons.fingerprint),
              new Text('TAP OR LONG PRESS', textAlign: TextAlign.center)
            ]),
      ),
    );
  }
}
