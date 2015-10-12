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
library polymer_elements.demo.web.firebase_element.x_login;

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

  @reflectable
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

    //_firebaseLogin.login(parameters, null);
    _firebaseLogin.jsElement.callMethod('login', [parameters, null]);
  }

  FirebaseAuth get _firebaseLogin => $['firebaseLogin'];

  @reflectable
  void logout([_, __]) => _firebaseLogin.logout();

  @reflectable
  errorHandler(dom.Event e, var detail) =>
      set('message', 'Error: ${detail['message']}');

  @reflectable
  userSuccessHandler(dom.Event e, [_]) => set('message', '${e.type} success!');

  @reflectable
  createUserHandler(dom.Event e, [_]) =>
      _firebaseLogin.createUser(email, password);

  @reflectable
  changePasswordHandler(dom.Event e, [_]) =>
      _firebaseLogin.changePassword(email, password, newPassword);

  @reflectable
  resetPasswordHandler(dom.Event e, [_]) =>
      _firebaseLogin.sendPasswordResetEmail(email);

  @reflectable
  bool computePasswordHidden(String provider) => provider != 'password';

  @reflectable
  bool computeCreateUserDisabled(String email, String password) =>
      email == null || email.isEmpty || password == null || password.isEmpty;

  @reflectable
  bool computeChangePasswordDisabled(
          String email, String password, String newPassword) =>
      email == null ||
          email.isEmpty ||
          password == null ||
          password.isEmpty ||
          newPassword == null ||
          newPassword.isEmpty;

  @reflectable
  bool computeResetPasswordDisabled(String email, String password) =>
      email == null || email.isEmpty || password == null || password.isEmpty;

  @reflectable
  bool computeRemoveUserDisabled(String email, String password) =>
      email == null || email.isEmpty || password == null || password.isEmpty;

  @reflectable
  bool computeLoginHidden(bool statusKnown, Map user) =>
      !statusKnown || user != null;

  @reflectable
  bool computeLogoutHidden(bool statusKnown, Map user) =>
      !statusKnown || user == null;

  @reflectable
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
