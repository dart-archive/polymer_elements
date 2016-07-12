// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_input_error`.
@HtmlImport('paper_input_error_nodart.html')
library polymer_elements.lib.src.paper_input.paper_input_error;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'paper_input_addon_behavior.dart';
import 'default_theme.dart';
import 'typography.dart';

/// `<paper-input-error>` is an error message for use with `<paper-input-container>`. The error is
/// displayed when the `<paper-input-container>` is `invalid`.
///
///     <paper-input-container>
///       <input is="iron-input" pattern="[0-9]*">
///       <paper-input-error>Only numbers are allowed!</paper-input-error>
///     </paper-input-container>
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-input-container-invalid-color` | The foreground color of the error | `--error-color`
/// `--paper-input-error`                   | Mixin applied to the error        | `{}`
@CustomElementProxy('paper-input-error')
class PaperInputError extends HtmlElement with CustomElementProxyMixin, PolymerBase, PaperInputAddonBehavior {
  PaperInputError.created() : super.created();
  factory PaperInputError() => new Element.tag('paper-input-error');

  /// True if the error is showing.
  bool get invalid => jsElement[r'invalid'];
  set invalid(bool value) { jsElement[r'invalid'] = value; }

  /// This overrides the update function in PaperInputAddonBehavior.
  /// [state]: inputElement: The input element.
  ///         value: The input value.
  ///         invalid: True if the input value is invalid.
  update(state) =>
      jsElement.callMethod('update', [state]);
}
