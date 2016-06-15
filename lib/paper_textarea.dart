// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_textarea`.
@HtmlImport('paper_textarea_nodart.html')
library polymer_elements.lib.src.paper_input.paper_textarea;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'paper_input_behavior.dart';
import 'iron_control_state.dart';
import 'iron_a11y_keys_behavior.dart';
import 'iron_form_element_behavior.dart';
import 'iron_autogrow_textarea.dart';
import 'paper_input_char_counter.dart';
import 'paper_input_container.dart';
import 'paper_input_error.dart';

/// `<paper-textarea>` is a multi-line text field with Material Design styling.
///
///     <paper-textarea label="Textarea label"></paper-textarea>
///
/// See `Polymer.PaperInputBehavior` for more API docs.
///
/// ### Validation
///
/// Currently only `required` and `maxlength` validation is supported.
///
/// ### Styling
///
/// See `Polymer.PaperInputContainer` for a list of custom properties used to
/// style this element.
@CustomElementProxy('paper-textarea')
class PaperTextarea extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronControlState, IronA11yKeysBehavior, PaperInputBehavior, IronFormElementBehavior {
  PaperTextarea.created() : super.created();
  factory PaperTextarea() => new Element.tag('paper-textarea');

  /// The maximum number of rows this element can grow to until it
  /// scrolls. 0 means no maximum.
  num get maxRows => jsElement[r'maxRows'];
  set maxRows(num value) { jsElement[r'maxRows'] = value; }

  /// The initial number of rows.
  num get rows => jsElement[r'rows'];
  set rows(num value) { jsElement[r'rows'] = value; }
}
