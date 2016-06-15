// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_radio_button`.
@HtmlImport('paper_radio_button_nodart.html')
library polymer_elements.lib.src.paper_radio_button.paper_radio_button;

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
import 'default_theme.dart';
import 'iron_flex_layout.dart';

/// Material design: [Radio button](https://www.google.com/design/spec/components/selection-controls.html#selection-controls-radio-button)
///
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
/// `--paper-radio-button-checked-color` | Radio button color when the input is checked | `--primary-color`
/// `--paper-radio-button-checked-ink-color` | Selected/focus ripple color when the input is checked | `--primary-color`
/// `--paper-radio-button-size` | Size of the radio button | `16px`
/// `--paper-radio-button-label-color` | Label color | `--primary-text-color`
/// `--paper-radio-button-label-spacing` | Spacing between the label and the button | `10px`
///
/// This element applies the mixin `--paper-font-common-base` but does not import `paper-styles/typography.html`.
/// In order to apply the `Roboto` font to this element, make sure you've imported `paper-styles/typography.html`.
@CustomElementProxy('paper-radio-button')
class PaperRadioButton extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronA11yKeysBehavior, IronButtonState, IronControlState, PaperRippleBehavior, PaperInkyFocusBehavior, IronFormElementBehavior, IronValidatableBehavior, IronCheckedElementBehavior, PaperCheckedElementBehavior {
  PaperRadioButton.created() : super.created();
  factory PaperRadioButton() => new Element.tag('paper-radio-button');

  /// Fired when the checked state changes.
  String get ariaActiveAttribute => jsElement[r'ariaActiveAttribute'];
  set ariaActiveAttribute(String value) { jsElement[r'ariaActiveAttribute'] = value; }
}
