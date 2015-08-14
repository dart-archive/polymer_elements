// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_control_state`.
@HtmlImport('iron_control_state_nodart.html')
library polymer_elements.lib.src.iron_behaviors.iron_control_state;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';


@BehaviorProxy(const ['Polymer', 'IronControlState'])
abstract class IronControlState implements CustomElementProxyMixin {

  /// If true, the user cannot interact with this element.
  bool get disabled => jsElement[r'disabled'];
  set disabled(bool value) { jsElement[r'disabled'] = value; }

  /// If true, the element currently has focus.
  bool get focused => jsElement[r'focused'];
  set focused(bool value) { jsElement[r'focused'] = value; }
}
