// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `gold_cc_expiration_input`.
@HtmlImport('gold_cc_expiration_input_nodart.html')
library polymer_elements.lib.src.gold_cc_expiration_input.gold_cc_expiration_input;

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
import 'date_input.dart';

/// `gold-cc-expiration-input` is a  single-line text field with Material Design styling
/// for entering a credit card's expiration date
///
///     <gold-cc-expiration-input></gold-cc-expiration-input>
///     <gold-cc-expiration-input value="11/15"></gold-cc-expiration-input>
///
/// It may include an optional label, which by default is "Expiration Date".
///
///     <gold-cc-expiration-input label="Date"></gold-cc-expiration-input>
///
///
/// ### Validation
///
/// The input can check whether the entered date is a valid, future date.
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
@CustomElementProxy('gold-cc-expiration-input')
class GoldCcExpirationInput extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronControlState, IronA11yKeysBehavior, PaperInputBehavior, IronFormElementBehavior {
  GoldCcExpirationInput.created() : super.created();
  factory GoldCcExpirationInput() => new Element.tag('gold-cc-expiration-input');

  /// The label for this input.
  String get label => jsElement[r'label'];
  set label(String value) { jsElement[r'label'] = value; }

  String get value => jsElement[r'value'];
  set value(String value) { jsElement[r'value'] = value; }

  /// Overidden from Polymer.PaperInputBehavior.
  validate() =>
      jsElement.callMethod('validate', []);
}
