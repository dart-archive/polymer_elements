// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_validator_behavior`.
@HtmlImport('iron_validator_behavior_nodart.html')
library polymer_elements.lib.src.iron_validator_behavior.iron_validator_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_meta.dart';

/// Use `Polymer.IronValidatorBehavior` to implement a custom input/form validator. Element
/// instances implementing this behavior will be registered for use in elements that implement
/// `Polymer.IronValidatableBehavior`.
@BehaviorProxy(const ['Polymer', 'IronValidatorBehavior'])
abstract class IronValidatorBehavior implements CustomElementProxyMixin {

  /// Name for this validator, used by `Polymer.IronValidatableBehavior` to lookup this element.
  String get validatorName => jsElement[r'validatorName'];
  set validatorName(String value) { jsElement[r'validatorName'] = value; }

  /// Namespace for this validator.
  String get validatorType => jsElement[r'validatorType'];
  set validatorType(String value) { jsElement[r'validatorType'] = value; }

  /// Implement custom validation logic in this function.
  /// [values]: The value to validate. May be any type depending on the validation logic.
  bool validate(values) =>
      jsElement.callMethod('validate', [values]);
}
