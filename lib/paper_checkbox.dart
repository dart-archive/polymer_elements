// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_checkbox`.
@HtmlImport('paper_checkbox_nodart.html')
library polymer_elements.lib.src.paper_checkbox.paper_checkbox;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'paper_checked_element_behavior.dart';
import 'paper_inky_focus_behavior.dart';
import 'iron_button_state.dart';
import 'iron_a11y_keys_behavior.dart';
import 'iron_control_state.dart';
import 'paper_ripple_behavior.dart';
import 'iron_checked_element_behavior.dart';
import 'iron_form_element_behavior.dart';
import 'iron_validatable_behavior.dart';
import 'paper_ripple.dart';
import 'default_theme.dart';
import 'color.dart';

/// Material design: [Checkbox](https://www.google.com/design/spec/components/selection-controls.html#selection-controls-checkbox)
///
/// `paper-checkbox` is a button that can be either checked or unchecked.  User
/// can tap the checkbox to check or uncheck it.  Usually you use checkboxes
/// to allow user to select multiple options from a set.  If you have a single
/// ON/OFF option, avoid using a single checkbox and use `paper-toggle-button`
/// instead.
///
/// Example:
///
///     <paper-checkbox>label</paper-checkbox>
///
///     <paper-checkbox checked> label</paper-checkbox>
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-checkbox-unchecked-background-color` | Checkbox background color when the input is not checked | `transparent`
/// `--paper-checkbox-unchecked-color` | Checkbox border color when the input is not checked | `--primary-text-color`
/// `--paper-checkbox-unchecked-ink-color` | Selected/focus ripple color when the input is not checked | `--primary-text-color`
/// `--paper-checkbox-checked-color` | Checkbox color when the input is checked | `--default-primary-color`
/// `--paper-checkbox-checked-ink-color` | Selected/focus ripple color when the input is checked | `--default-primary-color`
/// `--paper-checkbox-checkmark-color` | Checkmark color | `white`
/// `--paper-checkbox-label-color` | Label color | `--primary-text-color`
/// `--paper-checkbox-label-spacing` | Spacing between the label and the checkbox | `8px`
/// `--paper-checkbox-error-color` | Checkbox color when invalid | `--google-red-500`
/// `--paper-checkbox-size` | Size of the checkbox | `18px`
@CustomElementProxy('paper-checkbox')
class PaperCheckbox extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronA11yKeysBehavior, IronButtonState, IronControlState, PaperRippleBehavior, PaperInkyFocusBehavior, IronFormElementBehavior, IronValidatableBehavior, IronCheckedElementBehavior, PaperCheckedElementBehavior {
  PaperCheckbox.created() : super.created();
  factory PaperCheckbox() => new Element.tag('paper-checkbox');

  /// Fired when the checked state changes.
  String get ariaActiveAttribute => jsElement[r'ariaActiveAttribute'];
  set ariaActiveAttribute(String value) { jsElement[r'ariaActiveAttribute'] = value; }
}
