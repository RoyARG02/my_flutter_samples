import 'package:flutter/material.dart';
// * Importing Gesture Button Widget
import './gesture_button/button.dart';

void main() {
  runApp(ScaffoldApp());
}

class ScaffoldApp extends StatelessWidget {
  void _cakeDay() {
    // * An '_' at the beginning of the identifier of any variable/ method makes it private with respect to outside of the library(file)
    print("CAKE DAY!!!");
  }

  void _one() {
    print("Plus one!!");
  }

  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Scaffold Test',
        theme: new ThemeData(
            primarySwatch: Colors.pink), // * Defines the primary theme color
        home: new Scaffold(
          // * Scaffold Widget provides a template for constructing a familiar material Widget
          appBar: new AppBar(
              // * Appbar of the viewable widget
              title: new Text('TESTING SCAFFOLD',
                  style: new TextStyle(fontSize: 18)),
              actions: <Widget>[
                // * Actions are the buttons seen on the right of the title at the appbar
                new IconButton(
                    icon: new Icon(Icons.cake),
                    onPressed: _cakeDay), // * places an icon button
                new IconButton(icon: new Icon(Icons.plus_one), onPressed: _one),
                new IconButton(icon: new Icon(Icons.search), onPressed: null)
              ]),
          body: new Container(
            color: Theme.of(context)
                .scaffoldBackgroundColor, // * provides the appropriate 'scaffoldBackgroundColor' for the defined theme
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(
                      child: new Text(
                        'Lorem ipsum',
                        textAlign: TextAlign.start,
                        style: new TextStyle(fontSize: 20),
                      ),
                    ),
                    new GestureDetector(
                      // * This wigdet provides various interaction facilities to its child
                      child: new Container(child: new Text('Click me!')),
                      onTap: () => print(
                          'Lorem ipsum selected'), // * The FAT ARROW '=>' is essentially making the function execute a single statement
                      onLongPress: () => print(
                          'Lorem ipsum long pressed'), // * these properties take any named/ unnamed function
                    )
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(
                        child: new Text(
                      'The quick brown fox',
                      textAlign: TextAlign.start,
                      style: new TextStyle(
                          fontSize: 20, fontStyle: FontStyle.italic),
                    )),
                    new IconButton(
                        icon: new Icon(Icons.pets),
                        onPressed: () => print('Jumps over the lazy dog'))
                  ],
                ),
                new GestureButton() // * Implemented user-created Widget
              ],
            ),
          ),
          floatingActionButton: new FloatingActionButton(
              // * Implements the floating action button
              mini: true,
              child: new Icon(Icons.donut_large),
              tooltip:
                  'Check out this awesome FAB!', // * Tooltip displays floating text when the FAB is hovered(long pressed)
              onPressed: () => print('FAB!!')),
          floatingActionButtonLocation: // * Location of the FAB
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: new BottomNavigationBar(
            // * Implements bottom navigation bar (Tabs at bottom)
            type: BottomNavigationBarType
                .fixed, // * defines the behaviour of the bottom navigation bar
            items: [
              // * Icon and Label of each of the tabs (indexed from 0)
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.code), title: new Text('Code!')),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.fingerprint), title: new Text('Bruh')),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.poll), title: new Text('Poll')),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.send), title: new Text('puas')),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.party_mode), title: new Text('Party')),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.hot_tub), title: new Text('Bath Water'))
            ],
            onTap: (int i) => print(
                'Item ${i + 1} pressed'), // * The index can be used as such
          ),
        ));
  }
}
