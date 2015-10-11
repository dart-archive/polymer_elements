// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_menubar_behavior`.
@HtmlImport('iron_menubar_behavior_nodart.html')
library polymer_elements.lib.src.iron_menu_behavior.iron_menubar_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_menu_behavior.dart';
import 'iron_multi_selectable.dart';
import 'iron_selectable.dart';
import 'iron_a11y_keys_behavior.dart';

/// `Polymer.IronMenubarBehavior` implements accessible menubar behavior.
@BehaviorProxy(const ['Polymer', 'IronMenubarBehavior'])
abstract class IronMenubarBehavior implements CustomElementProxyMixin, IronMenuBehavior {

  get keyBindings => jsElement[r'keyBindings'];
  set keyBindings(value) { jsElement[r'keyBindings'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}
}
