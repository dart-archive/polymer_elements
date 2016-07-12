// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_toggle_button`.
@HtmlImport('paper_toggle_button_nodart.html')
library polymer_elements.lib.src.paper_toggle_button.paper_toggle_button;

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
import 'iron_flex_layout.dart';
import 'color.dart';
import 'default_theme.dart';

/// Material design: [Switch](https://www.google.com/design/spec/components/selection-controls.html#selection-controls-switch)
///
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
/// `--paper-toggle-button-checked-bar-color` | Slider button color when the input is checked | `--primary-color`
/// `--paper-toggle-button-checked-button-color` | Button color when the input is checked | `--primary-color`
/// `--paper-toggle-button-checked-ink-color` | Selected/focus ripple color when the input is checked | `--primary-color`
/// `--paper-toggle-button-unchecked-bar` | Mixin applied to the slider when the input is not checked | `{}`
/// `--paper-toggle-button-unchecked-button` | Mixin applied to the slider button when the input is not checked | `{}`
/// `--paper-toggle-button-checked-bar` | Mixin applied to the slider when the input is checked | `{}`
/// `--paper-toggle-button-checked-button` | Mixin applied to the slider button when the input is checked | `{}`
/// `--paper-toggle-button-label-color` | Label color | `--primary-text-color`
/// `--paper-toggle-button-label-spacing` | Spacing between the label and the button | `8px`
///
/// This element applies the mixin `--paper-font-common-base` but does not import `paper-styles/typography.html`.
/// In order to apply the `Roboto` font to this element, make sure you've imported `paper-styles/typography.html`.
@CustomElementProxy('paper-toggle-button')
class PaperToggleButton extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronA11yKeysBehavior, IronButtonState, IronControlState, PaperRippleBehavior, PaperInkyFocusBehavior, IronFormElementBehavior, IronValidatableBehavior, IronCheckedElementBehavior, PaperCheckedElementBehavior {
  PaperToggleButton.created() : super.created();
  factory PaperToggleButton() => new Element.tag('paper-toggle-button');
}
