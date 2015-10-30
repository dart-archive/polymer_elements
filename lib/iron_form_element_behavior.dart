// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_form_element_behavior`.
@HtmlImport('iron_form_element_behavior_nodart.html')
library polymer_elements.lib.src.iron_form_element_behavior.iron_form_element_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// Polymer.IronFormElementBehavior enables a custom element to be included
///   in an `iron-form`.
@BehaviorProxy(const ['Polymer', 'IronFormElementBehavior'])
abstract class IronFormElementBehavior implements CustomElementProxyMixin {

  /// The name of this element.
  String get name => jsElement[r'name'];
  set name(String value) { jsElement[r'name'] = value; }

  /// Set to true to mark the input as required. If used in a form, a
  /// custom element that uses this behavior should also use
  /// Polymer.IronValidatableBehavior and define a custom validation method.
  /// Otherwise, a `required` element will always be considered valid.
  /// It's also strongly recommended to provide a visual style for the element
  /// when its value is invalid.
  bool get required => jsElement[r'required'];
  set required(bool value) { jsElement[r'required'] = value; }

  /// The value for this element.
  String get value => jsElement[r'value'];
  set value(String value) { jsElement[r'value'] = value; }
}
