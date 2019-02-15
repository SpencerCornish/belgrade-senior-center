library app;

import 'package:built_value/built_value.dart';
import 'package:built_redux/built_redux.dart';

import '../middleware/serverMiddleware.dart';

import '../model/user.dart';

part 'app.g.dart';

abstract class AppActions extends ReduxActions {
  /// [setUser] sets the current user
  ActionDispatcher<User> get setUser;

  /// [setLoading] sets the UI to a loading state
  ActionDispatcher<bool> get setLoading;

  ServerMiddlewareActions serverActions;

  // factory to create on instance of the generated implementation of AppActions
  AppActions._();
  factory AppActions() => new _$AppActions();
}

/// All app state is stored within this immutable object.
/// When this object is regenerated on a state change, the UI updates.
abstract class App implements Built<App, AppBuilder> {
  /// [user] is the currently signed-in user
  @nullable
  User get user;

  /// [isLoading] is whether or not the UI should be in a loading state
  bool get isLoading;

  // Built value constructor. The factory is returning the default state
  App._();
  factory App() => new _$App._(
        user: null,
        isLoading: false,
      );
}

// Where we map handler functions to their internal functions
final reducerBuilder = new ReducerBuilder<App, AppBuilder>()
  ..add<User>(AppActionsNames.setUser, _setUser)
  ..add<bool>(AppActionsNames.setLoading, _setLoading);

_setUser(App state, Action<User> action, AppBuilder builder) => builder.user = action.payload?.toBuilder();

_setLoading(App state, Action<bool> action, AppBuilder builder) => builder.isLoading = action.payload;
