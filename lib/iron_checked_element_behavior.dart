// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_checked_element_behavior`.
@HtmlImport('iron_checked_element_behavior_nodart.html')
library polymer_elements.lib.src.iron_checked_element_behavior.iron_checked_element_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_form_element_behavior.dart';
import 'iron_validatable_behavior.dart';

/// Use `Polymer.IronCheckedElementBehavior` to implement a custom element
/// that has a `checked` property, which can be used for validation if the
/// element is also `required`. Element instances implementing this behavior
/// will also be registered for use in an `iron-form` element.
@BehaviorProxy(const ['Polymer', 'IronCheckedElementBehavior'])
abstract class IronCheckedElementBehavior implements CustomElementProxyMixin, IronFormElementBehavior, IronValidatableBehavior {

  /// Gets or sets the state, `true` is checked and `false` is unchecked.
  bool get checked => jsElement[r'checked'];
  set checked(bool value) { jsElement[r'checked'] = value; }

  /// If true, the button toggles the active state with each tap or press
  /// of the spacebar.
  bool get toggles => jsElement[r'toggles'];
  set toggles(bool value) { jsElement[r'toggles'] = value; }

  /// Overriden from Polymer.IronFormElementBehavior
  String get value => jsElement[r'value'];
  set value(String value) { jsElement[r'value'] = value; }
}
