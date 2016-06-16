// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_input`.
@HtmlImport('iron_input_nodart.html')
library polymer_elements.lib.src.iron_input.iron_input;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_validatable_behavior.dart';
import 'iron_a11y_announcer.dart';

/// `<iron-input>` adds two-way binding and custom validators using `Polymer.IronValidatorBehavior`
/// to `<input>`.
///
/// ### Two-way binding
///
/// By default you can only get notified of changes to an `input`'s `value` due to user input:
///
///     <input value="{{myValue::input}}">
///
/// `iron-input` adds the `bind-value` property that mirrors the `value` property, and can be used
/// for two-way data binding. `bind-value` will notify if it is changed either by user input or by script.
///
///     <input is="iron-input" bind-value="{{myValue}}">
///
/// ### Custom validators
///
/// You can use custom validators that implement `Polymer.IronValidatorBehavior` with `<iron-input>`.
///
///     <input is="iron-input" validator="my-custom-validator">
///
/// ### Stopping invalid input
///
/// It may be desirable to only allow users to enter certain characters. You can use the
/// `prevent-invalid-input` and `allowed-pattern` attributes together to accomplish this. This feature
/// is separate from validation, and `allowed-pattern` does not affect how the input is validated.
///
///     <!-- only allow characters that match [0-9] -->
///     <input is="iron-input" prevent-invalid-input allowed-pattern="[0-9]">
@CustomElementProxy('iron-input', extendsTag: 'input')
class IronInput extends InputElement with CustomElementProxyMixin, PolymerBase, IronValidatableBehavior {
  IronInput.created() : super.created();
  factory IronInput() => new Element.tag('input', 'iron-input');

  /// Regular expression that list the characters allowed as input.
  /// This pattern represents the allowed characters for the field; as the user inputs text,
  /// each individual character will be checked against the pattern (rather than checking
  /// the entire value as a whole). The recommended format should be a list of allowed characters;
  /// for example, `[a-zA-Z0-9.+-!;:]`
  String get allowedPattern => jsElement[r'allowedPattern'];
  set allowedPattern(String value) { jsElement[r'allowedPattern'] = value; }

  /// Use this property instead of `value` for two-way data binding.
  String get bindValue => jsElement[r'bindValue'];
  set bindValue(String value) { jsElement[r'bindValue'] = value; }

  /// Set to true to prevent the user from entering invalid input. If `allowedPattern` is set,
  /// any character typed by the user will be matched against that pattern, and rejected if it's not a match.
  /// Pasted input will have each character checked individually; if any character
  /// doesn't match `allowedPattern`, the entire pasted string will be rejected.
  /// If `allowedPattern` is not set, it will use the `type` attribute (only supported for `type=number`).
  bool get preventInvalidInput => jsElement[r'preventInvalidInput'];
  set preventInvalidInput(bool value) { jsElement[r'preventInvalidInput'] = value; }

  /// Returns true if `value` is valid. The validator provided in `validator` will be used first,
  /// then any constraints.
  bool validate([_]) => //() =>
      jsElement.callMethod('validate', []);

  registered() =>
      jsElement.callMethod('registered', []);
}
