// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `firebase_common_behavior`.
@HtmlImport('firebase_common_behavior_nodart.html')
library polymer_elements.lib.src.polymerfire.firebase_common_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'app_network_status_behavior.dart';
import 'firebase_common_behavior.dart';


@BehaviorProxy(const ['Polymer', 'FirebaseCommonBehaviorImpl'])
abstract class FirebaseCommonBehaviorImpl implements CustomElementProxyMixin {

  get app => jsElement[r'app'];
  set app(value) { jsElement[r'app'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  String get appName => jsElement[r'appName'];
  set appName(String value) { jsElement[r'appName'] = value; }
}




@BehaviorProxy(const ['Polymer', 'FirebaseCommonBehavior'])
abstract class FirebaseCommonBehavior implements CustomElementProxyMixin, AppNetworkStatusBehavior, FirebaseCommonBehaviorImpl {
}
