// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_toggle_button`.
@HtmlImport('paper_toggle_button_nodart.html')
library polymer_elements.lib.src.paper_toggle_button.paper_toggle_button;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'paper_inky_focus_behavior.dart';
import 'iron_button_state.dart';
import 'iron_control_state.dart';
import 'color.dart';
import 'default_theme.dart';
import 'paper_ripple.dart';

/// `paper-toggle-button` provides a ON/OFF switch that user can toggle the state
/// by tapping or by dragging the switch.
///
/// Example:
///
///     <paper-toggle-button></paper-toggle-button>
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-toggle-button-unchecked-bar-color` | Slider color when the input is not checked | `#000000`
/// `--paper-toggle-button-unchecked-button-color` | Button color when the input is not checked | `--paper-grey-50`
/// `--paper-toggle-button-unchecked-ink-color` | Selected/focus ripple color when the input is not checked | `--dark-primary-color`
/// `--paper-toggle-button-checked-bar-color` | Slider button color when the input is checked | `--google-green-500`
/// `--paper-toggle-button-checked-button-color` | Button color when the input is checked | `--google-green-500`
/// `--paper-toggle-button-checked-ink-color` | Selected/focus ripple color when the input is checked | `--google-green-500`
/// `--paper-toggle-button-unchecked-bar` | Mixin applied to the slider when the input is not checked | `{}`
/// `--paper-toggle-button-unchecked-button` | Mixin applied to the slider button when the input is not checked | `{}`
/// `--paper-toggle-button-checked-bar` | Mixin applied to the slider when the input is checked | `{}`
/// `--paper-toggle-button-checked-button` | Mixin applied to the slider button when the input is checked | `{}`
@CustomElementProxy('paper-toggle-button')
class PaperToggleButton extends HtmlElement with CustomElementProxyMixin, PolymerBase, PaperInkyFocusBehavior, IronButtonState, IronControlState {
  PaperToggleButton.created() : super.created();
  factory PaperToggleButton() => new Element.tag('paper-toggle-button');

  /// Gets or sets the state, `true` is checked and `false` is unchecked.
  bool get checked => jsElement[r'checked'];
  set checked(bool value) { jsElement[r'checked'] = value; }

  /// If true, the button toggles the active state with each tap or press
  /// of the spacebar.
  bool get toggles => jsElement[r'toggles'];
  set toggles(bool value) { jsElement[r'toggles'] = value; }
}
