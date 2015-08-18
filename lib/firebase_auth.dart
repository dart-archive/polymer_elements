// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `firebase_auth`.
@HtmlImport('firebase_auth_nodart.html')
library polymer_elements.lib.src.firebase_element.firebase_auth;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// Element wrapper for the Firebase authentication API (https://www.firebase.com/docs/web/guide/user-auth.html).
@CustomElementProxy('firebase-auth')
class FirebaseAuth extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  FirebaseAuth.created() : super.created();
  factory FirebaseAuth() => new Element.tag('firebase-auth');

  /// When true, login will be attempted if login status check determines no user is
  /// logged in.  Should generally only be used with provider types that do not present
  /// a login UI, such as 'anonymous'.
  bool get autoLogin => jsElement[r'autoLogin'];
  set autoLogin(bool value) { jsElement[r'autoLogin'] = value; }

  /// Firebase location URL (must have simple login enabled via Forge interface).
  String get location => jsElement[r'location'];
  set location(String value) { jsElement[r'location'] = value; }

  /// Provider-specific options to pass to login, for provider types that take a second
  /// object to pass firebase-specific options.  May be overridden at `login()`-time.
  get options => jsElement[r'options'];
  set options(value) { jsElement[r'options'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// Provider-specific parameters to pass to login.  May be overridden at `login()`-time.
  get params => jsElement[r'params'];
  set params(value) { jsElement[r'params'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// Default login provider type.  May be one of: `anonymous`, `custom`, `password`
  /// `facebook`, `github`, `twitter`, `google`.
  String get provider => jsElement[r'provider'];
  set provider(String value) { jsElement[r'provider'] = value; }

  /// When true, authentication will try to redirect instead of using a
  /// popup if possible.
  bool get redirect => jsElement[r'redirect'];
  set redirect(bool value) { jsElement[r'redirect'] = value; }

  /// A pointer to the Firebase instance being used by the firebase-auth element.
  get ref => jsElement[r'ref'];
  set ref(value) { jsElement[r'ref'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// When true, login status can be determined by checking `user` property.
  bool get statusKnown => jsElement[r'statusKnown'];
  set statusKnown(bool value) { jsElement[r'statusKnown'] = value; }

  /// When logged in, this property reflects the firebase user auth object.
  get user => jsElement[r'user'];
  set user(value) { jsElement[r'user'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// Changes the email of a "password provider"-based user account.
  ///
  /// If the operation is successful, the `email-changed` event is fired.
  ///
  /// If the operation fails, the `error` event is fired, with `e.detail`
  /// containing error information supplied from Firebase.
  void changeEmail(String oldEmail, String newEmail, password) =>
      jsElement.callMethod('changeEmail', [oldEmail, newEmail, password]);

  /// Changes the password of a "password provider"-based user account.
  ///
  /// If the operation is successful, the `password-changed` event is fired.
  ///
  /// If the operation fails, the `error` event is fired, with `e.detail`
  /// containing error information supplied from Firebase.
  void changePassword(String email, String oldPassword, String newPassword) =>
      jsElement.callMethod('changePassword', [email, oldPassword, newPassword]);

  /// Creates a "password provider"-based user account.
  ///
  /// If the operation is successful, the `user-created` event is fired.
  ///
  /// If the operation fails, the `error` event is fired, with `e.detail`
  /// containing error information supplied from Firebase.
  void createUser(String email, String password) =>
      jsElement.callMethod('createUser', [email, password]);

  /// Performs a login attempt, using the `provider` specified via attribute/property,
  /// or optionally via `provider` argument to the `login` function.  Optionally,
  /// provider-specific login parameters can be specified via attribute (JSON)/property,
  /// or via the `params` argument to the `login` function.
  ///
  /// If the login is successful, the `login` event is fired, with `e.detail.user`
  /// containing the authenticated user object from Firebase.
  ///
  /// If login fails, the `error` event is fired, with `e.detail` containing error
  /// information supplied from Firebase.
  ///
  /// If the browswer supports `navigator.onLine` network status reporting and the
  /// network is currently offline, the login attempt will be queued until the network
  /// is restored.
  /// [params]: (optional)
  /// [options]: (optional)
  void login(String params, String options) =>
      jsElement.callMethod('login', [params, options]);

  /// Performs a logout attempt.
  ///
  /// If the login is successful, the `logout` event is fired.
  ///
  /// If login fails, the `error` event is fired, with `e.detail` containing error
  /// information supplied from Firebase.
  ///
  /// If the browswer supports `navigator.onLine` network status reporting and the
  /// network is currently offline, the logout attempt will be queued until the network
  /// is restored.
  void logout() =>
      jsElement.callMethod('logout', []);

  /// Removes a "password provider"-based user account.
  ///
  /// If the operation is successful, the `user-removed` event is fired.
  ///
  /// If the operation fails, the `error` event is fired, with `e.detail`
  /// containing error information supplied from Firebase.
  void removeUser(String email, String password) =>
      jsElement.callMethod('removeUser', [email, password]);

  /// Sends a password reset email for a "password provider"-based user account.
  ///
  /// If the operation is successful, the `password-reset` event is fired.
  ///
  /// If the operation fails, the `error` event is fired, with `e.detail`
  /// containing error information supplied from Firebase.
  void sendPasswordResetEmail(String email) =>
      jsElement.callMethod('sendPasswordResetEmail', [email]);
}
