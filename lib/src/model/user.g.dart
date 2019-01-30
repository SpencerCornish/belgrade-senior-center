// GENERATED CODE - DO NOT MODIFY BY HAND

part of user;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$User extends User {
  @override
  final String uid;

  factory _$User([void updates(UserBuilder b)]) => (new UserBuilder()..update(updates)).build();

  _$User._({this.uid}) : super._() {
    if (uid == null) {
      throw new BuiltValueNullFieldError('User', 'uid');
    }
  }

  @override
  User rebuild(void updates(UserBuilder b)) => (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User && uid == other.uid;
  }

  @override
  int get hashCode {
    return $jf($jc(0, uid.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')..add('uid', uid)).toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User _$v;

  String _uid;
  String get uid => _$this._uid;
  set uid(String uid) => _$this._uid = uid;

  UserBuilder();

  UserBuilder get _$this {
    if (_$v != null) {
      _uid = _$v.uid;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$User;
  }

  @override
  void update(void updates(UserBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    final _$result = _$v ?? new _$User._(uid: uid);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
