// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_input_addon_behavior`.
@HtmlImport('paper_input_addon_behavior_nodart.html')
library polymer_elements.lib.src.paper_input.paper_input_addon_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// Use `Polymer.PaperInputAddonBehavior` to implement an add-on for `<paper-input-container>`. A
/// add-on appears below the input, and may display information based on the input value and
/// validity such as a character counter or an error message.
@BehaviorProxy(const ['Polymer', 'PaperInputAddonBehavior'])
abstract class PaperInputAddonBehavior implements CustomElementProxyMixin {

  /// The function called by `<paper-input-container>` when the input value or validity changes.
  /// [state]: inputElement: The input element.
  ///         value: The input value.
  ///         invalid: True if the input value is invalid.
  update(state) =>
      jsElement.callMethod('update', [state]);
}
