// * Flutter libraries
import 'package:flutter/material.dart';

// * The following class creates a Stateless Widget by inheriting the same, which are a class of Widgets that do not contain a
// * mutable 'State', i.e., they never change their configuration/ appearance throughout the execution of the App.
class MyApp extends StatelessWidget {
  // * Widget classes inheriting StatelessWidget has to provide a 'build' function, which returns a created Widget
  // * In Flutter, almost everything is a Widget, including:
  // * Container: provides a padding/ margin/ color/ alignment to the Widget it contains as a 'child'
  // * Column or Row: Takes mutiple 'children' Widgets and displays them horizontally or vertically
  // * Text: Displays stylized text with better control over its properties
  // * Stack: Similar to Row or Column, but displays Widgets on top on one another according to a specified alignment
  Widget build(BuildContext context) {
    return new MaterialApp(
        // * MaterialApp denotes an application which follows the Material Design
        title: 'Class App',
        home: new Material(
            // * 'home' property takes a Widget which will be displayed first when the app is run
            // * Material provides properties to wrap Widgets following the Material Design
            color: Colors
                .black, // * Colors in Flutter are part of the 'Colors' class
            child: new Center(
                // * Center Widget forces its child widget to be positioned at the center of the screen
                child: new Text('Hello_world.txt',
                    textDirection: TextDirection.ltr, // * ltr -> left to right
                    // ! In case of using a 'Material' widget, the text direction is mandatory for proper functioning of the Text Widget
                    style: new TextStyle(
                        // * TextStyle class provides properties for stylizing the text
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepPurple)))));
  }
}
