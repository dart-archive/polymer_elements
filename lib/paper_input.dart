// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_input`.
@HtmlImport('paper_input_nodart.html')
library polymer_elements.lib.src.paper_input.paper_input;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_form_element_behavior.dart';
import 'paper_input_behavior.dart';
import 'iron_control_state.dart';
import 'iron_input.dart';
import 'paper_input_container.dart';
import 'paper_input_error.dart';
import 'paper_input_char_counter.dart';

/// `<paper-input>` is a single-line text field with Material Design styling.
///
///     <paper-input label="Input label"></paper-input>
///
/// It may include an optional error message or character counter.
///
///     <paper-input error-message="Invalid input!" label="Input label"></paper-input>
///     <paper-input char-counter label="Input label"></paper-input>
///
/// It can also include custom prefix or suffix elements, which are displayed
/// before or after the text input itself. In order for an element to be
/// considered as a prefix, it must have the `prefix` attribute (and similarly
/// for `suffix`).
///
///     <paper-input label="total">
///       <div prefix>$</div>
///       <paper-icon-button suffix icon="clear"></paper-icon-button>
///     </paper-input>
///
/// See `Polymer.PaperInputBehavior` for more API docs.
///
/// ### Styling
///
/// See `Polymer.PaperInputContainer` for a list of custom properties used to
/// style this element.
@CustomElementProxy('paper-input')
class PaperInput extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronFormElementBehavior, PaperInputBehavior, IronControlState, IronControlState {
  PaperInput.created() : super.created();
  factory PaperInput() => new Element.tag('paper-input');
}
