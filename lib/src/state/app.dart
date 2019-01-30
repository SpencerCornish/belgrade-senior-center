library app;

import 'package:built_value/built_value.dart';
import 'package:built_redux/built_redux.dart';

part 'app.g.dart';

abstract class AppActions extends ReduxActions {
  /// [increment] is an example action
  ActionDispatcher<int> get increment;

  /// [decrement] is an example action
  ActionDispatcher<int> get decrement;

  // factory to create on instance of the generated implementation of AppActions
  AppActions._();
  factory AppActions() => new _$AppActions();
}

/// All app state is stored within this immutable object.
/// When this object is regenerated on a state change, the UI updates.
abstract class App implements Built<App, AppBuilder> {
  /// [count] value of the App
  int get count;

  // Built value constructor. The factory is returning the default state
  App._();
  factory App() => new _$App._(count: 0);
}

void increment(App state, Action<int> action, AppBuilder builder) => builder.count = state.count + action.payload;

void decrement(App state, Action<int> action, AppBuilder builder) => builder.count = state.count - action.payload;

// Where we map handler functions to their internal functions
final reducerBuilder = new ReducerBuilder<App, AppBuilder>()
  ..add(AppActionsNames.increment, increment)
  ..add(AppActionsNames.decrement, decrement);
