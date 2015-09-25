@HtmlImport('x_login.html')
library x_login;

import 'dart:html' as dom;
import 'dart:convert' show JSON;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/firebase_auth.dart';

/// Silence analyzer [FirebaseAuth]
@PolymerRegister('x-login')
class XLogin extends PolymerElement {
  XLogin.created() : super.created();

  @property String provider = 'anonymous';
  @property String message = '';
  @property String email = '';
  @property String password = '';
  @property String newPassword = ''; //
  @property Map user;
  @property bool statusKnown = false;
  @property String params; //

  @eventHandler
  void login([_, __]) {
    String params;
    Map parameters;
    try {
      parameters = JSON.decode(params);
    } catch (e) {
      parameters = null;
    }

    if (provider == 'password') {
      parameters = parameters ?? {};
      parameters['email'] = email;
      parameters['password'] = password;
    }

    _firebaseLogin.login(parameters, null);
  }

  FirebaseAuth get _firebaseLogin => $['firebaseLogin'];

  @eventHandler
  void logout([_, __]) => _firebaseLogin.logout();

  @eventHandler
  errorHandler(dom.Event e, var detail) =>
      message = 'Error: ${detail['message']}';

  @eventHandler
  userSuccessHandler(dom.Event e, [_]) => message = '${e.type} success!';

  @eventHandler
  createUserHandler(dom.Event e, [_]) =>
      _firebaseLogin.createUser(email, password);

  @eventHandler
  changePasswordHandler(dom.Event e, [_]) =>
      _firebaseLogin.changePassword(email, password, newPassword);

  @eventHandler
  resetPasswordHandler(dom.Event e, [_]) =>
      _firebaseLogin.sendPasswordResetEmail(email);

  @eventHandler
  bool computePasswordHidden(String provider) => provider != 'password';

  @eventHandler
  bool computeCreateUserDisabled(String email, String password) =>
      email == null || email.isEmpty || password == null || password.isEmpty;

  @eventHandler
  bool computeChangePasswordDisabled(
          String email, String password, String newPassword) =>
      email == null ||
          email.isEmpty ||
          password == null ||
          password.isEmpty ||
          newPassword == null ||
          newPassword.isEmpty;

  @eventHandler
  bool computeResetPasswordDisabled(String email, String password) =>
      email == null || email.isEmpty || password == null || password.isEmpty;

  @eventHandler
  bool computeRemoveUserDisabled(email, password) =>
      email == null || email.isEmpty || password == null || password.isEmpty;

  @eventHandler
  bool computeLoginHidden(bool statusKnown, Map user) =>
      !statusKnown || user != null;

  @eventHandler
  bool computeLogoutHidden(bool statusKnown, Map user) =>
      !statusKnown || user == null;

  @eventHandler
  String computeLoginStatus(bool statusKnown, Map user) {
    if (statusKnown && user != null) {
      return 'Logged in';
    }

    if (statusKnown) {
      return 'Logged out';
    }

    return 'Unknown (checking status...)';
  }
}
