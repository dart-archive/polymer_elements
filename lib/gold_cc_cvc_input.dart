// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `gold_cc_cvc_input`.
@HtmlImport('gold_cc_cvc_input_nodart.html')
library polymer_elements.lib.src.gold_cc_cvc_input.gold_cc_cvc_input;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'paper_input_behavior.dart';
import 'iron_control_state.dart';
import 'iron_a11y_keys_behavior.dart';
import 'iron_form_element_behavior.dart';
import 'paper_input_container.dart';
import 'paper_input_error.dart';
import 'iron_input.dart';
import 'iron_icon.dart';
import 'iron_flex_layout.dart';

/// `gold-cc-cvc-input` is a single-line text field with Material Design styling
/// for entering a credit card's CVC (Card Verification Code). It supports both
/// 4-digit Amex CVCs and non-Amex 3-digit CVCs
///
///     <gold-cc-cvc-input></gold-cc-cvc-input>
///
///     <gold-cc-cvc-input card-type="amex"></gold-cc-cvc-input>
///
/// It may include an optional label, which by default is "CVC".
///
///     <gold-cc-cvc-input label="Card Verification Value"></gold-cc-cvc-input>
///
/// It can be used together with a `gold-cc-input` by binding the `cardType` property:
///
///     <gold-cc-input card-type="{{cardType}}"></gold-cc-input>
///     <gold-cc-cvc-input card-type="[[cardType]]"></gold-cc-cvc-input>
///
/// ### Validation
///
/// The input considers a valid amex CVC to be 4 digits long, and 3 digits otherwise.
/// The `amex` attribute can also be bound to a `gold-cc-input`'s `card-type` attribute.
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
@CustomElementProxy('gold-cc-cvc-input')
class GoldCcCvcInput extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronControlState, IronA11yKeysBehavior, PaperInputBehavior, IronFormElementBehavior {
  GoldCcCvcInput.created() : super.created();
  factory GoldCcCvcInput() => new Element.tag('gold-cc-cvc-input');

  /// The type of card that the CVC is for.
  String get cardType => jsElement[r'cardType'];
  set cardType(String value) { jsElement[r'cardType'] = value; }

  /// The label for this input.
  String get label => jsElement[r'label'];
  set label(String value) { jsElement[r'label'] = value; }

  String get value => jsElement[r'value'];
  set value(String value) { jsElement[r'value'] = value; }

  /// Returns true if the element has a valid value, and sets the visual
  /// error state.
  bool validate() =>
      jsElement.callMethod('validate', []);
}
