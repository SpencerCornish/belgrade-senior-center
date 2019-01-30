import 'dart:html';

import 'package:built_redux/built_redux.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:firebase/firestore.dart' as fs;

import 'middleware/loggingMiddleware.dart';
import 'middleware/serverMiddleware.dart';
import './state/app.dart';
import 'firebase/dbRefs.dart';
import 'firebase/firebaseClient.dart';
import 'firebase/firebaseSubscriber.dart';

class StoreContainer {
  Store<App, AppBuilder, AppActions> store;
  AppActions _actions;
  FirebaseClient _client;
  FirebaseSubscriber _subscriber;
  final firebase.App fb;
  final firebase.Auth _firebaseAuth;
  final fs.Firestore _firebaseDatabase;

  StoreContainer()
      : fb = firebase.initializeApp(
            apiKey: "AIzaSyDgBjQhPeAJG11bDV9QshNaxyU2Nv9qQsI",
            authDomain: "bsc-development.firebaseapp.com",
            databaseURL: "https://bsc-development.firebaseio.com",
            projectId: "bsc-development",
            storageBucket: "bsc-development.appspot.com",
            messagingSenderId: "334955558914"),
        _firebaseAuth = firebase.auth(),
        _firebaseDatabase = firebase.firestore() {
    _actions = new AppActions();

    DbRefs _firebaseDbRefs = new DbRefs(_firebaseDatabase);

    _subscriber = new FirebaseSubscriber();

    _client = new FirebaseClient(_firebaseDbRefs, _firebaseAuth, _actions, _subscriber);

    App app = new App();

    // TODO: Setup server connection Middleware
    List<Middleware<App, AppBuilder, AppActions>> middlewares = []; //createServerMiddleware(_client)];
    if (document.domain.contains("localhost")) middlewares.add(loggingMiddleware);

    store = new Store<App, AppBuilder, AppActions>(reducerBuilder.build(), app, _actions, middleware: middlewares);

    // _subscriber.initialize(_firebaseDbRefs, store);
    // _subscriber.initializeGlobalSubs();
  }
}
