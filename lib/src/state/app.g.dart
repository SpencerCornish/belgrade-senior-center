// GENERATED CODE - DO NOT MODIFY BY HAND

part of app;

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: annotate_overrides

class _$AppActions extends AppActions {
  factory _$AppActions() => new _$AppActions._();
  _$AppActions._() : super._();

  final ActionDispatcher<int> increment = new ActionDispatcher<int>('AppActions-increment');
  final ActionDispatcher<int> decrement = new ActionDispatcher<int>('AppActions-decrement');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    increment.setDispatcher(dispatcher);
    decrement.setDispatcher(dispatcher);
  }
}

class AppActionsNames {
  static final ActionName<int> increment = new ActionName<int>('AppActions-increment');
  static final ActionName<int> decrement = new ActionName<int>('AppActions-decrement');
}

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$App extends App {
  @override
  final int count;

  factory _$App([void updates(AppBuilder b)]) => (new AppBuilder()..update(updates)).build();

  _$App._({this.count}) : super._() {
    if (count == null) {
      throw new BuiltValueNullFieldError('App', 'count');
    }
  }

  @override
  App rebuild(void updates(AppBuilder b)) => (toBuilder()..update(updates)).build();

  @override
  AppBuilder toBuilder() => new AppBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is App && count == other.count;
  }

  @override
  int get hashCode {
    return $jf($jc(0, count.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('App')..add('count', count)).toString();
  }
}

class AppBuilder implements Builder<App, AppBuilder> {
  _$App _$v;

  int _count;
  int get count => _$this._count;
  set count(int count) => _$this._count = count;

  AppBuilder();

  AppBuilder get _$this {
    if (_$v != null) {
      _count = _$v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(App other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$App;
  }

  @override
  void update(void updates(AppBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$App build() {
    final _$result = _$v ?? new _$App._(count: count);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
