// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `gold_phone_input`.
@HtmlImport('gold_phone_input_nodart.html')
library polymer_elements.lib.src.gold_phone_input.gold_phone_input;

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
import 'typography.dart';
import 'iron_input.dart';
import 'iron_flex_layout.dart';

/// `<gold-phone-input>` is a single-line text field with Material Design styling
/// for entering a phone number.
///
///     <gold-phone-input></gold-phone-input>
///
/// It may include an optional label, which by default is "Phone number".
///
///     <gold-phone-input label="call this"></gold-phone-input>
///
/// ### Validation
///
/// By default, the phone number is considered to be a US phone number, and
/// will be validated according to the pattern `XXX-XXX-XXXX`, where `X` is a
/// digit, and `-` is the separating dash. If you want to customize the input
/// for a different area code or number pattern, use the `country-code` and
/// `phone-number-pattern` attributes
///
///     <gold-phone-input
///         country-code="33"
///         phone-number-pattern="X-XX-XX-XX-XX">
///     </gold-phone-input>
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
///
/// `--gold-phone-input-country-code` | Mixin applied to the country code span
@CustomElementProxy('gold-phone-input')
class GoldPhoneInput extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronControlState, IronA11yKeysBehavior, PaperInputBehavior, IronFormElementBehavior {
  GoldPhoneInput.created() : super.created();
  factory GoldPhoneInput() => new Element.tag('gold-phone-input');

  /// The country code that should be recognized and parsed.
  String get countryCode => jsElement[r'countryCode'];
  set countryCode(String value) { jsElement[r'countryCode'] = value; }

  /// The label for this input.
  String get label => jsElement[r'label'];
  set label(String value) { jsElement[r'label'] = value; }

  /// The format of a valid phone number, including formatting but excluding
  /// the country code. Use 'X' to denote the digits separated by dashes.
  String get phoneNumberPattern => jsElement[r'phoneNumberPattern'];
  set phoneNumberPattern(String value) { jsElement[r'phoneNumberPattern'] = value; }

  String get value => jsElement[r'value'];
  set value(String value) { jsElement[r'value'] = value; }

  /// Overidden from Polymer.PaperInputBehavior.
  validate() =>
      jsElement.callMethod('validate', []);
}
