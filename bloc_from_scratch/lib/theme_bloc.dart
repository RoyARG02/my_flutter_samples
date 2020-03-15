import 'dart:async';

import 'package:bloc_from_scratch/theme_toggle_event.dart';

class ThemeBloc{
  bool isDarkTheme;
  /*
   * A BLoC maps(converts) an event to a state through the use of streams.
   * As data passing through the stream cannot magically change as it travels across
   * the stream, we need to define two streams each carrying an event object and the state
   * object respectively, to be somehow converted in between.
   * Here we use two streams:
   * One for passing the toggle 'event' another for passing the state(bool) 
   * The way we wish to implement the BLoC is as follows:
   * EventInput => [EventStream] => EventOutput => [Mapping/Converter Function] => StateInput => [StateStream] => StateOutput
   * The Mapping/Converter function is responsible for mapping the Event to the State for BLoC purposes
   */

  // * Defining the EventStream
  // * The UI needs to interact with the sink/input of the stream, which is why it is public
  final StreamController<ThemeToggleEvent> _toggleThemeEventController = StreamController<ThemeToggleEvent>();
  Sink<ThemeToggleEvent> get inToggleThemeEvent => _toggleThemeEventController.sink;

  // * Defining the StateStream
  // * The UI needs to interact with the output/stream only
  final StreamController _darkThemeStateController = StreamController<bool>();
  StreamSink<bool> get _inDarkThemeState => _darkThemeStateController.sink;
  Stream<bool> get outDarkThemeState => _darkThemeStateController.stream;

  // * Default constructor initializes the state and attaches the Mapping/Converter function
  // * to the output of the EventStream as listener
  ThemeBloc():isDarkTheme = false{
    _toggleThemeEventController.stream.listen(_mapEventToState);
  }

  // * Converter Function
  void _mapEventToState(ThemeToggleEvent event){
    isDarkTheme = !isDarkTheme;
    // * Dump the changed state into the sink/input of the StateStream
    _inDarkThemeState.add(isDarkTheme);
  }

  // * For memory leak safety
  void dispose(){
    _darkThemeStateController.close();
    _toggleThemeEventController.close();
  }
}