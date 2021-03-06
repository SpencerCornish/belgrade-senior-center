import 'dart:html' hide History;
import 'dart:async';

import 'package:wui_builder/components.dart';
import 'package:wui_builder/wui_builder.dart';
import 'package:wui_builder/vhtml.dart';

import '../../../constants.dart';

import '../../../state/app.dart';
import '../../../middleware/serverMiddleware.dart';

class HomeProps {
  AppActions actions;
  AuthState authState;
  String redirectCode;
  String emailPrefill;
  String nextUrl;
}

class Home extends PComponent<HomeProps> {
  Home(props) : super(props);

  History _history;

  StreamSubscription keyStream;

  /// Browser history entrypoint, to control page navigation
  History get history => _history ?? findHistoryInContext(context);
  @override
  void componentWillMount() {
    if (props.authState == AuthState.SUCCESS) {
      history.push(props.nextUrl);
    }

    keyStream = window.document.onKeyPress.listen(_onKeySubmitClick);
    super.componentWillMount();
  }

  @override
  void componentWillUpdate(HomeProps nextProps, Null nextState) {
    if (nextProps.authState == AuthState.SUCCESS) {
      history.push(props.nextUrl);
    }
    super.componentWillUpdate(nextProps, nextState);
  }

  @override
  void componentWillUnmount() {
    keyStream.cancel();
    super.componentWillMount();
  }

  @override
  VNode render() => new VDivElement()
    ..className = 'container'
    ..id = 'home-container'
    ..children = [
      new VDivElement()
        ..className = 'columns is-centered margin-top'
        ..children = [
          new VDivElement()
            ..className = 'column is-three-fifths-widescreen is-two-thirds-desktop is-half-tablet'
            ..children = [
              new VDivElement()
                ..className = 'box animated fadeIn faster'
                ..children = [
                  new Vh1()
                    ..className = 'title has-text-centered'
                    ..text = 'Belgrade Senior Center',
                  new Vh1()
                    ..className = 'subtitle has-text-centered'
                    ..text = 'Member Management Portal',
                  props.redirectCode != '' ? _renderNotification(props.redirectCode) : new VDivElement(),
                  props.authState == AuthState.PASS_RESET_SENT
                      ? _renderNotification(
                          "Password reset email sent! Please check your email for further instructions.")
                      : new VDivElement(),
                  _renderSignIn(),
                  // Form Here
                ],
            ],
        ],
      new VDivElement()
        ..className = 'columns is-centered margin-top is-tablet'
        ..children = [
          new VDivElement()
            ..className = 'column is-narrow has-text-centered'
            ..children = [
              new VAnchorElement()
                ..className = 'button is-text has-text-grey is-rounded'
                ..id = 'dev-doc-button'
                ..href = "https://github.com/SpencerCornish/belgrade-senior-center/blob/master/README.md"
                ..text = "Development Documentation",
            ],
          new VDivElement()
            ..className = 'column is-narrow has-text-centered'
            ..children = [
              new VAnchorElement()
                ..className = 'button is-text has-text-grey is-rounded'
                ..id = 'user-doc-button'
                ..href = "https://github.com/SpencerCornish/belgrade-senior-center/blob/master/USERREADME.md"
                ..text = "User Documentation",
            ],
        ],
    ];

  VNode _renderSignIn() => new VDivElement()
    ..children = [
      new VDivElement()
        ..className = 'field'
        ..children = [
          new VLabelElement()
            ..className = 'label'
            ..text = "Email",
          new VDivElement()
            ..className = 'control has-icons-left'
            ..children = [
              new VInputElement()
                ..className = 'input'
                ..type = "email"
                ..id = 'email-input'
                ..placeholder = "me@email.net"
                ..defaultValue = props.emailPrefill
                ..onInput = _onEmailChange,
              new VSpanElement()
                ..className = 'icon is-small is-left'
                ..children = [new Vi()..className = "fas fa-user"],
            ],
          _renderHint(props.authState == AuthState.ERR_EMAIL ? 'Invalid Email' : ''),
          _renderHint(props.authState == AuthState.ERR_NOT_FOUND ? 'Email Not Found' : ''),
          _renderHint(props.authState == AuthState.ERR_OTHER ? 'Unexpected error. Please try again.' : ''),
        ],
      new VDivElement()
        ..className = 'field'
        ..children = [
          new VLabelElement()
            ..className = 'label'
            ..text = "Password",
          new VDivElement()
            ..className = 'control has-icons-left'
            ..children = [
              new VInputElement()
                ..className = 'input'
                ..type = "password"
                ..id = 'pass-input'
                ..placeholder = "Password"
                ..onInput = _onPassChange,
              new VSpanElement()
                ..className = 'icon is-small is-left'
                ..children = [new Vi()..className = "fas fa-lock"],
            ],
          _renderHint(props.authState == AuthState.ERR_PASSWORD ? 'Invalid Password' : ''),
        ],
      new VDivElement()
        ..className = 'field is-grouped is-grouped-right'
        ..children = [
          new VDivElement()
            ..className = 'control'
            ..children = [
              new VButtonElement()
                ..className = 'button is-text'
                ..id = 'reset-pass-button'
                ..onClick = _onResetPasswordClick
                ..text = 'Reset Password',
            ],
          new VDivElement()
            ..className = 'control'
            ..children = [
              new VButtonElement()
                ..className = 'button  is-rounded'
                ..id = 'cancel-button'
                ..onClick = _onCancelClick
                ..text = 'Cancel',
            ],
          new VDivElement()
            ..className = 'control'
            ..children = [
              new VButtonElement()
                ..className = 'button is-link is-rounded ${props.authState == AuthState.LOADING ? 'is-loading' : ''}'
                ..id = 'login-submit-button'
                ..onClick = _onSubmitClick
                ..text = 'Submit',
            ],
        ],
    ];

  _renderHint(String message) => new VParagraphElement()
    ..className = 'help is-danger'
    ..id = 'hint-${message.replaceAll(' ', '').toLowerCase()}'
    ..text = message;

  _renderNotification(String message) => VDivElement()
    ..className = 'notification is-info'
    ..text = message;

  // Clear the correct errors when the user starts typing again
  _onEmailChange(_) {
    if (props.authState == AuthState.ERR_EMAIL || props.authState == AuthState.ERR_NOT_FOUND) {
      props.actions.setAuthState(AuthState.INAUTHENTIC);
    }
  }

  // Clear the correct errors when the user starts typing again
  _onPassChange(_) {
    if (props.authState == AuthState.ERR_PASSWORD) {
      props.actions.setAuthState(AuthState.INAUTHENTIC);
    }
  }

  _onKeySubmitClick(KeyboardEvent e) {
    if (e.charCode != 13) {
      return;
    }
    _onSubmitClick(null);
  }

  _onSubmitClick(_) {
    if (props.authState == AuthState.LOADING) return;
    InputElement email = querySelector('#email-input');
    InputElement pass = querySelector('#pass-input');
    if (!Validator.email(email.value)) {
      props.actions.setAuthState(AuthState.ERR_EMAIL);
      return;
    }
    props.actions.server.signInAdmin(new AdminSignInPayload(email.value, pass.value));
  }

  _onCancelClick(_) {
    if (props.authState == AuthState.LOADING) return;
    InputElement email = querySelector('#email-input');
    InputElement pass = querySelector('#pass-input');
    email.value = '';
    pass.value = '';
  }

  _onResetPasswordClick(_) {
    if (props.authState == AuthState.LOADING) return;
    InputElement email = querySelector('#email-input');
    if (!Validator.email(email.value)) {
      props.actions.setAuthState(AuthState.ERR_EMAIL);
      return;
    }
    props.actions.server.resetPassword(email.value);
  }
}
