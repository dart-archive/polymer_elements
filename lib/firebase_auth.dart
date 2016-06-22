// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `firebase_auth`.
@HtmlImport('firebase_auth_nodart.html')
library polymer_elements.lib.src.polymerfire.firebase_auth;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'firebase_common_behavior.dart';
import 'app_network_status_behavior.dart';

/// `firebase-auth` is a wrapper around the Firebase authentication API. It notifies
/// successful authentication, provides user information, and handles different
/// types of authentication including anonymous, email / password, and several OAuth
/// workflows.
///
/// Example Usage:
/// ```html
/// <firebase-app auth-domain="polymerfire-test.firebaseapp.com"
///   database-url="https://polymerfire-test.firebaseio.com/"
///   api-key="AIzaSyDTP-eiQezleFsV2WddFBAhF_WEzx_8v_g">
/// </firebase-app>
/// <firebase-auth id="auth" user="{{user}}" provider="google" on-error="handleError">
/// </firebase-auth>
/// ```
///
/// The `firebase-app` element initializes `app` in `firebase-auth` (see
/// `firebase-app` documentation for more information), but an app name can simply
/// be specified at `firebase-auth`'s `app-name` property instead.
///
/// JavaScript sign-in calls can then be made to the `firebase-auth` object to
/// attempt authentication, e.g.:
///
/// ```javascript
/// this.$.signInWithPopup()
///     .then(function(response) {// successful authentication response here})
///     .catch(function(error) {// unsuccessful authentication response here});
/// ```
///
/// This popup sign-in will then attempt to sign in using Google as an OAuth
/// provider since there was no provider argument specified and since `"google"` was
/// defined as the default provider.
@CustomElementProxy('firebase-auth')
class FirebaseAuth extends HtmlElement with CustomElementProxyMixin, PolymerBase, AppNetworkStatusBehavior, FirebaseCommonBehaviorImpl, FirebaseCommonBehavior {
  FirebaseAuth.created() : super.created();
  factory FirebaseAuth() => new Element.tag('firebase-auth');

  /// [`firebase.Auth`](https://firebase.google.com/docs/reference/js/firebase.auth.Auth) service interface.
  get auth => jsElement[r'auth'];
  set auth(value) { jsElement[r'auth'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Default auth provider OAuth flow to use when attempting provider
  /// sign in. This property can remain undefined when attempting to sign
  /// in anonymously, using email and password, or when specifying a
  /// provider in the provider sign-in function calls (i.e.
  /// `signInWithPopup` and `signInWithRedirect`).
  ///
  /// Current accepted providers are:
  ///
  /// ```
  /// 'facebook'
  /// 'github'
  /// 'google'
  /// 'twitter'
  /// ```
  String get provider => jsElement[r'provider'];
  set provider(String value) { jsElement[r'provider'] = value; }

  /// True if the client is authenticated, and false if the client is not
  /// authenticated.
  bool get signedIn => jsElement[r'signedIn'];
  set signedIn(bool value) { jsElement[r'signedIn'] = value; }

  /// The currently-authenticated user with user-related metadata. See
  /// the [`firebase.User`](https://firebase.google.com/docs/reference/js/firebase.User)
  /// documentation for the spec.
  get user => jsElement[r'user'];
  set user(value) { jsElement[r'user'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Creates a new user account using an email / password combination.
  /// [email]: Email address corresponding to the user account.
  /// [password]: Password corresponding to the user account.
  createUserWithEmailAndPassword(email, password) =>
      jsElement.callMethod('createUserWithEmailAndPassword', [email, password]);

  /// Authenticates a Firebase client using a new, temporary guest account.
  signInAnonymously() =>
      jsElement.callMethod('signInAnonymously', []);

  /// Authenticates a Firebase client using an email / password combination.
  /// [email]: Email address corresponding to the user account.
  /// [password]: Password corresponding to the user account.
  signInWithEmailAndPassword(email, password) =>
      jsElement.callMethod('signInWithEmailAndPassword', [email, password]);

  /// Authenticates a Firebase client using a popup-based OAuth flow.
  /// [provider]: Provider OAuth flow to follow. If no
  ///     provider is specified, it will default to the element's `provider`
  ///     property's OAuth flow (See the `provider` property's documentation
  ///     for supported providers).
  signInWithPopup(provider) =>
      jsElement.callMethod('signInWithPopup', [provider]);

  /// Authenticates a firebase client using a redirect-based OAuth flow.
  /// [provider]: Provider OAuth flow to follow. If no
  ///     provider is specified, it will default to the element's `provider`
  ///     property's OAuth flow (See the `provider` property's documentation
  ///     for supported providers).
  signInWithRedirect(provider) =>
      jsElement.callMethod('signInWithRedirect', [provider]);

  /// Unauthenticates a Firebase client.
  signOut() =>
      jsElement.callMethod('signOut', []);
}
