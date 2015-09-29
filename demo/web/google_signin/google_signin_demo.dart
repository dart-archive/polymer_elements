/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('google_signin_demo.html')
library polymer_elements_demo.web.google_signin.google_signin_demo;

import 'dart:html' as dom;
import 'dart:js' as js;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/google_signin.dart';
import 'package:polymer_elements/google_signin_aware.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [GoogleSignin], [GoogleSigninAware], [DemoElements]
@PolymerRegister('google-signin-demo')
class GoogleSigninDemo extends PolymerElement {
  GoogleSigninDemo.created() : super.created();

  @property var aware = {
    'status': 'Not granted',
    'offlineCode': 'No offline login.',
    'userName': 'N/A'
  };
  @property String scope;
  @property bool offline;
  @property bool signedIn;
  @property bool isAuthorized;
  @property bool needAdditionalAuth;

  js.JsObject get _gapiAuthInstance =>
      js.context['gapi']['auth2'].callMethod('getAuthInstance', []);

  @eventHandler
  void handleSignIn(dom.CustomEvent response, [_]) {
    set('status', 'Signin granted');
    // console.log('[Aware] Signin Response', response);
    set(
        'userName',
        _gapiAuthInstance['currentUser']
            .callMethod('get')
            .callMethod('getBasicProfile', []).callMethod('getName', []));
  }

  @eventHandler
  void handleOffline(dom.CustomEvent response, [_]) {
    set('offlineCode', response.detail.code);
  }

  @eventHandler
  void handleSignOut(dom.CustomEvent response, [_]) {
    set('status', 'Signed out');
    // console.log('[Aware] Signout Response', response);
    set('userName', 'N/A');
  }

  @eventHandler
  void disconnect([_, __]) {
    //var b = document.querySelector('google-signin');
    var currentUser = _gapiAuthInstance['auth2']
        .callMethod('getAuthInstance', [])['currentUser'].callMethod('get', []);
    if (currentUser != null && currentUser.isNotEmpty) {
      currentUser.disconnect();
    }
    _gapiAuthInstance.callMethod('signOut', []);
  }
}
