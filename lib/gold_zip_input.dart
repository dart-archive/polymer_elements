// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `gold_zip_input`.
@HtmlImport('gold_zip_input_nodart.html')
library polymer_elements.lib.src.gold_zip_input.gold_zip_input;

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
import 'zip_validator.dart';

/// `gold-zip-input` is a single-line text field with Material Design styling
/// for entering a US zip code.
///
///     <gold-zip-input></gold-zip-input>
///
/// It may include an optional label, which by default is "Zip Code".
///
///     <gold-zip-input label="Mailing zip code"></gold-zip-input>
///
/// ### Validation
///
/// The input supports both 5 digit zip codes (90210) or the full 9 digit ones,
/// separated by a dash (90210-9999).
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
@CustomElementProxy('gold-zip-input')
class GoldZipInput extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronControlState, IronA11yKeysBehavior, PaperInputBehavior, IronFormElementBehavior {
  GoldZipInput.created() : super.created();
  factory GoldZipInput() => new Element.tag('gold-zip-input');

  /// The label for this input.
  String get label => jsElement[r'label'];
  set label(String value) { jsElement[r'label'] = value; }
}
