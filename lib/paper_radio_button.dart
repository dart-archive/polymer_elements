// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_radio_button`.
@HtmlImport('paper_radio_button_nodart.html')
library polymer_elements.lib.src.paper_radio_button.paper_radio_button;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'paper_inky_focus_behavior.dart';
import 'iron_button_state.dart';
import 'iron_control_state.dart';
import 'paper_ripple.dart';
import 'default_theme.dart';

/// `paper-radio-button` is a button that can be either checked or unchecked.
/// User can tap the radio button to check or uncheck it.
///
/// Use a `<paper-radio-group>` to group a set of radio buttons.  When radio buttons
/// are inside a radio group, exactly one radio button in the group can be checked
/// at any time.
///
/// Example:
///
///     <paper-radio-button></paper-radio-button>
///     <paper-radio-button>Item label</paper-radio-button>
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-radio-button-unchecked-background-color` | Radio button background color when the input is not checked | `transparent`
/// `--paper-radio-button-unchecked-color` | Radio button color when the input is not checked | `--primary-text-color`
/// `--paper-radio-button-unchecked-ink-color` | Selected/focus ripple color when the input is not checked | `--primary-text-color`
/// `--paper-radio-button-checked-color` | Radio button color when the input is checked | `--default-primary-color`
/// `--paper-radio-button-checked-ink-color` | Selected/focus ripple color when the input is checked | `--default-primary-color`
/// `--paper-radio-button-label-color` | Label color | `--primary-text-color`
@CustomElementProxy('paper-radio-button')
class PaperRadioButton extends HtmlElement with CustomElementProxyMixin, PolymerBase, PaperInkyFocusBehavior, IronButtonState, IronControlState {
  PaperRadioButton.created() : super.created();
  factory PaperRadioButton() => new Element.tag('paper-radio-button');

  /// Gets or sets the state, `true` is checked and `false` is unchecked.
  bool get checked => jsElement[r'checked'];
  set checked(bool value) { jsElement[r'checked'] = value; }

  /// If true, the button toggles the active state with each tap or press
  /// of the spacebar.
  bool get toggles => jsElement[r'toggles'];
  set toggles(bool value) { jsElement[r'toggles'] = value; }
}
