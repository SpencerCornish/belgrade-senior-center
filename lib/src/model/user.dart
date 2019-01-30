library user;

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:firebase/firebase.dart' as fb;

part 'user.g.dart';

/// [User]
abstract class User implements Built<User, UserBuilder> {
  String get uid;

  User._();
  factory User([updates(UserBuilder b)]) = _$User;

  factory User.fromFirebase(fb.User fbUser, fb.UserInfo additionalInfo, ListBuilder<String> trackedSections) =>
      new User((UserBuilder builder) => builder..uid = fbUser.uid);
}
