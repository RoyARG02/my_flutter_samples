import 'package:flutter/material.dart';
// * following package enables Widget/ Layout Grids at runtime
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = true; // * Enables Layout Grids
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Container Demo',
      home: new Container(
        color:
            Colors.teal[700], // * index value defines the darkness of the shade
        alignment: Alignment.topRight,
        child: new Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // * Main Axis => vertically
          children: <Widget>[
            new Text('Item 1',
                style: new TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight
                        .w200 // * The greater the fontWeight, the bolder the text
                    ),
                textDirection: TextDirection.ltr // ! important
                ),
            new Text('Item 2',
                style: new TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w400),
                textDirection: TextDirection.ltr),
            new Stack(
              alignment: Alignment(0.2, -0.2), // * Defining Alignment
              // * Alignment(0, 0) is the center of the screen with either of the opposite edges
              // * being at positions '1' and '-1' respectively in the coordinate system
              children: <Widget>[
                new Text(
                  'Item 3',
                  textDirection: TextDirection.ltr,
                  style: new TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan[400],
                      fontSize: 40),
                ),
                new Text(
                  'Top 4',
                  textDirection: TextDirection.ltr,
                  style: new TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 50,
                      color: Colors.amberAccent,
                      letterSpacing: 3.0),
                ),
                new Text(
                  'Top 5',
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.end,
                  style: new TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 80,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            new Container(
              color: Colors.blue,
              padding: EdgeInsets.all(10.0),
              // * padding: the spacing in logical pixels to be provided between the border of the widget and its child
              child: new Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // * Main Axis => horizontally
                children: <Widget>[
                  new Expanded(
                    // * Expanded: Functions similar to Container but expands to take all of the space available
                    child: new Text(
                      'OPTION 1',
                      textDirection: TextDirection.ltr,
                      style: new TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  new Text(
                    'OPTION 2',
                    textDirection: TextDirection.ltr,
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
