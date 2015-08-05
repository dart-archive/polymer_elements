// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_validatable_behavior`.
@HtmlImport('iron_validatable_behavior_nodart.html')
library polymer_elements.lib.src.iron_validatable_behavior.iron_validatable_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_meta.dart';

/// Use `Polymer.IronValidatableBehavior` to implement an element that validates user input.
///
/// ### Accessiblity
///
/// Changing the `invalid` property, either manually or by calling `validate()` will update the
/// `aria-invalid` attribute.
abstract class IronValidatableBehavior implements CustomElementProxyMixin {

  /// True if the last call to `validate` is invalid.
  bool get invalid => jsElement[r'invalid'];
  set invalid(bool value) { jsElement[r'invalid'] = value; }

  /// Name of the validator to use.
  String get validator => jsElement[r'validator'];
  set validator(String value) { jsElement[r'validator'] = value; }

  /// Namespace for this validator.
  String get validatorType => jsElement[r'validatorType'];
  set validatorType(String value) { jsElement[r'validatorType'] = value; }

  bool hasValidator() =>
      jsElement.callMethod('hasValidator', []);

  /// [values]: Passed to the validator's `validate()` function.
  bool validate(values) =>
      jsElement.callMethod('validate', [values]);
}
