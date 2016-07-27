// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `firebase_database_behavior`.
@HtmlImport('firebase_database_behavior_nodart.html')
library polymer_elements.lib.src.polymerfire.firebase_database_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'app_storage_behavior.dart';
import 'firebase_common_behavior.dart';
import 'app_network_status_behavior.dart';


@BehaviorProxy(const ['Polymer', 'FirebaseDatabaseBehavior'])
abstract class FirebaseDatabaseBehavior implements CustomElementProxyMixin, AppStorageBehavior, FirebaseCommonBehavior {

  get db => jsElement[r'db'];
  set db(value) { jsElement[r'db'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Path to a Firebase root or endpoint. N.B. `path` is case sensitive.
  String get path => jsElement[r'path'];
  set path(String value) { jsElement[r'path'] = value; }

  get ref => jsElement[r'ref'];
  set ref(value) { jsElement[r'ref'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}
}
