// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_checkbox`.
@HtmlImport('paper_checkbox_nodart.html')
library polymer_elements.lib.src.paper_checkbox.paper_checkbox;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'paper_inky_focus_behavior.dart';
import 'iron_button_state.dart';
import 'iron_control_state.dart';
import 'paper_ripple.dart';
import 'default_theme.dart';

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
@CustomElementProxy('paper-checkbox')
class PaperCheckbox extends HtmlElement with CustomElementProxyMixin, PolymerBase, PaperInkyFocusBehavior, IronButtonState, IronControlState {
  PaperCheckbox.created() : super.created();
  factory PaperCheckbox() => new Element.tag('paper-checkbox');

  /// Gets or sets the state, `true` is checked and `false` is unchecked.
  bool get checked => jsElement[r'checked'];
  set checked(bool value) { jsElement[r'checked'] = value; }

  /// If true, the button toggles the active state with each tap or press
  /// of the spacebar.
  bool get toggles => jsElement[r'toggles'];
  set toggles(bool value) { jsElement[r'toggles'] = value; }
}
