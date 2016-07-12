// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `firebase_app`.
@HtmlImport('firebase_app_nodart.html')
library polymer_elements.lib.src.polymerfire.firebase_app;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// The firebase-app element is used for initializing and configuring your
/// connection to firebase.
@CustomElementProxy('firebase-app')
class FirebaseApp extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  FirebaseApp.created() : super.created();
  factory FirebaseApp() => new Element.tag('firebase-app');

  /// Your API key.
  ///
  /// Get this from the Auth > Web Setup panel of the new
  /// Firebase Console at https://console.firebase.google.com
  ///
  /// It looks like this: 'AIzaSyDTP-eiQezleFsV2WddFBAhF_WEzx_8v_g'
  String get apiKey => jsElement[r'apiKey'];
  set apiKey(String value) { jsElement[r'apiKey'] = value; }

  /// The Firebase app object constructed from the other fields of
  /// this element.
  get app => jsElement[r'app'];
  set app(value) { jsElement[r'app'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The domain name to authenticate with.
  ///
  /// The same as your Firebase Hosting subdomain or custom domain.
  /// Available on the Firebase Console.
  ///
  /// For example: 'polymerfire-test.firebaseapp.com'
  String get authDomain => jsElement[r'authDomain'];
  set authDomain(String value) { jsElement[r'authDomain'] = value; }

  /// The URL of your Firebase Realtime Database. You can find this
  /// URL in the Database panel of the Firebase Console.
  /// Available on the Firebase Console.
  ///
  /// For example: 'https://polymerfire-test.firebaseio.com/'
  String get databaseUrl => jsElement[r'databaseUrl'];
  set databaseUrl(String value) { jsElement[r'databaseUrl'] = value; }

  /// The name of your app. Optional.
  ///
  /// You can use this with the `appName` property of other Polymerfire elements
  /// in order to use multiple firebase configurations on a page at once.
  /// In that case the name is used as a key to lookup the configuration.
  String get name => jsElement[r'name'];
  set name(String value) { jsElement[r'name'] = value; }
}
