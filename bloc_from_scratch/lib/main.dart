import 'package:flutter/material.dart';

import 'package:bloc_from_scratch/theme_bloc.dart';
import 'package:bloc_from_scratch/theme_toggle_event.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _bloc = ThemeBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.outDarkThemeState,
      initialData: false,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: snapshot.data ? ThemeData.dark() : ThemeData.light(),
          home: MyHomePage(
              title: 'Flutter Demo Home Page',
              toggleEventSink: _bloc.inToggleThemeEvent),
        );
      },
    );
  }
  void dispose(){
    _bloc.dispose();
    super.dispose();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title, this.toggleEventSink});

  final String title;
  final Sink<ThemeToggleEvent> toggleEventSink;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.palette),
              onPressed: () => widget.toggleEventSink.add(ThemeToggleEvent()))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
