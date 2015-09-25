/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
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
      set('message', 'Error: ${detail['message']}');

  @eventHandler
  userSuccessHandler(dom.Event e, [_]) => set('message', '${e.type} success!');

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
  bool computeRemoveUserDisabled(String email, String password) =>
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
