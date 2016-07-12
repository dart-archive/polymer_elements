// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `gold_cc_input`.
@HtmlImport('gold_cc_input_nodart.html')
library polymer_elements.lib.src.gold_cc_input.gold_cc_input;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'paper_input_behavior.dart';
import 'iron_control_state.dart';
import 'iron_a11y_keys_behavior.dart';
import 'iron_validatable_behavior.dart';
import 'iron_form_element_behavior.dart';
import 'iron_flex_layout.dart';
import 'paper_input_container.dart';
import 'paper_input_error.dart';
import 'iron_input.dart';
import 'iron_icon.dart';

/// `gold-cc-input` is a single-line text field with Material Design styling
/// for entering a credit card number. As the user types, the number will be
/// formatted by adding a space every 4 digits.
///
///     <gold-cc-input></gold-cc-input>
///
/// It may include an optional label, which by default is "Card number".
///
///     <gold-cc-input label="CC"></gold-cc-input>
///
/// ### Validation
///
/// The input can detect whether a credit card number is valid, and the type
/// of credit card it is, using the Luhn checksum. See `http://jquerycreditcardvalidator.com/`
/// for more information.
///
/// The input can be automatically validated as the user is typing by using
/// the `auto-validate` and `required` attributes. For manual validation, the
/// element also has a `validate()` method, which returns the validity of the
/// input as well sets any appropriate error messages and styles.
///
/// See `Polymer.PaperInputBehavior` for more API docs.
///
/// ### Styling
///
/// See `Polymer.PaperInputContainer` for a list of custom properties used to
/// style this element.
@CustomElementProxy('gold-cc-input')
class GoldCcInput extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronControlState, IronA11yKeysBehavior, PaperInputBehavior, IronValidatableBehavior, IronFormElementBehavior {
  GoldCcInput.created() : super.created();
  factory GoldCcInput() => new Element.tag('gold-cc-input');

  /// The type of the credit card, if it is valid. Empty otherwise.
  String get cardType => jsElement[r'cardType'];
  set cardType(String value) { jsElement[r'cardType'] = value; }

  /// The label for this input.
  String get label => jsElement[r'label'];
  set label(String value) { jsElement[r'label'] = value; }

  get value => jsElement[r'value'];
  set value(value) { jsElement[r'value'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Returns true if the element has a valid value, and sets the visual
  /// error state.
  bool validate([_]) => //() =>
      jsElement.callMethod('validate', []);
}
