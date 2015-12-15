// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `gold_email_input`.
@HtmlImport('gold_email_input_nodart.html')
library polymer_elements.lib.src.gold_email_input.gold_email_input;

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

/// `<gold-email-input>` is a single-line text field with Material Design styling
/// for entering an email address.
///
///     <gold-email-input></gold-email-input>
///
/// It may include an optional label, which by default is "Email".
///
///     <gold-email-input label="your email address"></gold-email-input>
///
/// ### Validation
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
@CustomElementProxy('gold-email-input')
class GoldEmailInput extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronControlState, IronA11yKeysBehavior, PaperInputBehavior, IronFormElementBehavior {
  GoldEmailInput.created() : super.created();
  factory GoldEmailInput() => new Element.tag('gold-email-input');

  /// The label for this input.
  String get label => jsElement[r'label'];
  set label(String value) { jsElement[r'label'] = value; }

  /// The regular expression used to validate the email. By default, the
  /// input is of type=email and uses the native input regex, as defined in
  /// the spec: http://www.w3.org/TR/html-markup/input.email.html#input.email.attrs.value.single.
  /// You can override this if you want your email to be validated against
  /// a custom regex. If the empty string, then no validation will be applied.
  String get regex => jsElement[r'regex'];
  set regex(String value) { jsElement[r'regex'] = value; }

  get value => jsElement[r'value'];
  set value(value) { jsElement[r'value'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Returns true if the element has a valid value, and sets the visual error
  /// state.
  bool validate() =>
      jsElement.callMethod('validate', []);
}
