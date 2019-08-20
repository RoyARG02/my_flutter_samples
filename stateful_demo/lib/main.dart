import 'package:flutter/material.dart';
import 'dart:math' as math;
import './ui/legend.dart';

var rnd = new math.Random(88);

void main() {
  String title = 'Stateful Widgets Demo';
  runApp(
    new MaterialApp(
      title: title,
      home: MyApp(title),
      theme: ThemeData.dark(),
    ),
  );
}

// * Checking if a number is prime or not
bool _isPrime(int arg) {
  for (int i = 2; i <= math.sqrt(arg).toInt(); ++i) {
    if (arg % i == 0) {
      return false;
    }
  }
  return true;
}

// * StatefulWidget are the class of widgets that consist of a 'state', which determines the appearance/ behaviour of the widget
// * The said 'state' is implemented by the class extending the 'State<StatefulWidget>' class, and changed invoking the setState() function
// * The setState() can be invoked by another function whenever required

class MyApp extends StatefulWidget {
  final title;

  MyApp(this.title);

  State<StatefulWidget> createState() => new _MyAppState(this.title);
  // * createState() returns a 'state', which is an object of the class extending State<StatefulWidget>
}

// * The definition of the 'state' class is the same as any StatelessWidget
class _MyAppState extends State<MyApp> {
  int _number = 0;
  Color _numberColor = Colors.grey;
  final title;

  _MyAppState(this.title);

  // * This function changes the 'state'
  void _generate() {
    setState(() {
      _number = rnd.nextInt(99); // * generates a random number between 0 and 99
      if (_number > 1) {
        _numberColor = (_isPrime(_number)) ? Colors.pink : Colors.blue;
      } else {
        _numberColor = Colors.grey;
      }
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          this.title,
          style: Theme.of(context).textTheme.title.copyWith(
                color: Colors.black,
              ),
        ),
        backgroundColor: Colors.amber,
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.all(10.0),
              child: new Text(
                'Random Number Generator',
                style: new TextStyle(fontSize: 28.0),
              ),
            ),
            new Expanded(
              child: new Container(
                alignment: Alignment.center,
                child: new Text(
                  '$_number',
                  style: new TextStyle(fontSize: 100.0, color: _numberColor),
                ),
              ),
            ),
            new Container(
              margin: EdgeInsets.all(10.0),
              child: new OutlineButton(
                  // * creates a button having only the outline filed with given color
                  borderSide: new BorderSide(color: Colors.purple, width: 2.0),
                  //elevation: 5.0,
                  child: new Text('Generate New Number'),
                  onPressed: _generate),
            ),
            new Container(
              padding: EdgeInsets.all(10.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Legend(
                      color: Colors.pink,
                      text: 'Prime'), // * Implented user - created widget
                  new Legend(color: Colors.blue, text: 'Composite'),
                  new Legend(color: Colors.grey, text: 'Neither')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
