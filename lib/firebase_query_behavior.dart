// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `firebase_query_behavior`.
@HtmlImport('firebase_query_behavior_nodart.html')
library polymer_elements.lib.src.firebase_element.firebase_query_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';


@BehaviorProxy(const ['Polymer', 'FirebaseQueryBehavior'])
abstract class FirebaseQueryBehavior implements CustomElementProxyMixin {

  get dataAsObject => jsElement[r'dataAsObject'];

  /// A Firebase API location that references an accessible document.
  String get location => jsElement[r'location'];
  set location(String value) { jsElement[r'location'] = value; }

  /// If true, verbose debugging information will be printed to the console.
  bool get log => jsElement[r'log'];
  set log(bool value) { jsElement[r'log'] = value; }

  /// Firebase Query object corresponding to `location`.
  get queryObject => jsElement[r'query'];
  set queryObject(value) { jsElement[r'query'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// Disconnects the current Firebase Query instance.
  void disconnect() =>
      jsElement.callMethod('disconnect', []);
}
