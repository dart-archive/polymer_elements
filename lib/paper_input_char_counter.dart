// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_input_char_counter`.
@HtmlImport('paper_input_char_counter_nodart.html')
library polymer_elements.lib.src.paper_input.paper_input_char_counter;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'paper_input_addon_behavior.dart';
import 'typography.dart';

/// `<paper-input-char-counter>` is a character counter for use with `<paper-input-container>`. It
/// shows the number of characters entered in the input and the max length if it is specified.
///
///     <paper-input-container>
///       <input is="iron-input" maxlength="20">
///       <paper-input-char-counter></paper-input-char-counter>
///     </paper-input-container>
///
/// ### Styling
///
/// The following mixin is available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-input-char-counter` | Mixin applied to the element | `{}`
@CustomElementProxy('paper-input-char-counter')
class PaperInputCharCounter extends HtmlElement with CustomElementProxyMixin, PolymerBase, PaperInputAddonBehavior {
  PaperInputCharCounter.created() : super.created();
  factory PaperInputCharCounter() => new Element.tag('paper-input-char-counter');

  /// This overrides the update function in PaperInputAddonBehavior.
  /// [state]: inputElement: The input element.
  ///         value: The input value.
  ///         invalid: True if the input value is invalid.
  update(state) =>
      jsElement.callMethod('update', [state]);
}
