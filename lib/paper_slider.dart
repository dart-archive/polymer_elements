// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_slider`.
@HtmlImport('paper_slider_nodart.html')
library polymer_elements.lib.src.paper_slider.paper_slider;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_a11y_keys_behavior.dart';
import 'iron_form_element_behavior.dart';
import 'paper_inky_focus_behavior.dart';
import 'iron_button_state.dart';
import 'iron_control_state.dart';
import 'paper_ripple_behavior.dart';
import 'iron_range_behavior.dart';
import 'iron_flex_layout.dart';
import 'paper_input.dart';
import 'paper_progress.dart';
import 'color.dart';

/// Material design: [Sliders](https://www.google.com/design/spec/components/sliders.html)
///
/// `paper-slider` allows user to select a value from a range of values by
/// moving the slider thumb.  The interactive nature of the slider makes it a
/// great choice for settings that reflect intensity levels, such as volume,
/// brightness, or color saturation.
///
/// Example:
///
///     <paper-slider></paper-slider>
///
/// Use `min` and `max` to specify the slider range.  Default is 0 to 100.
///
/// Example:
///
///     <paper-slider min="10" max="200" value="110"></paper-slider>
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-slider-container-color` | The background color of the bar | `--paper-grey-400`
/// `--paper-slider-bar-color` | The background color of the slider | `transparent`
/// `--paper-slider-active-color` | The progress bar color | `--google-blue-700`
/// `--paper-slider-secondary-color` | The secondary progress bar color | `--google-blue-300`
/// `--paper-slider-knob-color` | The knob color | `--google-blue-700`
/// `--paper-slider-disabled-knob-color` | The disabled knob color | `--paper-grey-400`
/// `--paper-slider-pin-color` | The pin color | `--google-blue-700`
/// `--paper-slider-font-color` | The pin's text color | `#fff`
/// `--paper-slider-disabled-active-color` | The disabled progress bar color | `--paper-grey-400`
/// `--paper-slider-disabled-secondary-color` | The disabled secondary progress bar color | `--paper-grey-400`
/// `--paper-slider-knob-start-color` | The fill color of the knob at the far left | `transparent`
/// `--paper-slider-knob-start-border-color` | The border color of the knob at the far left | `--paper-grey-400`
/// `--paper-slider-pin-start-color` | The color of the pin at the far left | `--paper-grey-400`
/// `--paper-slider-height` | Height of the progress bar | `2px`
/// `--paper-slider-input` | Mixin applied to the input in editable mode | `{}`
@CustomElementProxy('paper-slider')
class PaperSlider extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronA11yKeysBehavior, IronFormElementBehavior, IronA11yKeysBehavior, IronButtonState, IronControlState, PaperRippleBehavior, PaperInkyFocusBehavior, IronRangeBehavior {
  PaperSlider.created() : super.created();
  factory PaperSlider() => new Element.tag('paper-slider');

  /// True when the user is dragging the slider.
  bool get dragging => jsElement[r'dragging'];
  set dragging(bool value) { jsElement[r'dragging'] = value; }

  /// If true, an input is shown and user can use it to set the slider value.
  bool get editable => jsElement[r'editable'];
  set editable(bool value) { jsElement[r'editable'] = value; }

  /// If true, the knob is expanded
  bool get expand => jsElement[r'expand'];
  set expand(bool value) { jsElement[r'expand'] = value; }

  /// The immediate value of the slider.  This value is updated while the user
  /// is dragging the slider.
  num get immediateValue => jsElement[r'immediateValue'];
  set immediateValue(num value) { jsElement[r'immediateValue'] = value; }

  get keyBindings => jsElement[r'keyBindings'];
  set keyBindings(value) { jsElement[r'keyBindings'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  List get markers => jsElement[r'markers'];
  set markers(List value) { jsElement[r'markers'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// The maximum number of markers
  num get maxMarkers => jsElement[r'maxMarkers'];
  set maxMarkers(num value) { jsElement[r'maxMarkers'] = value; }

  /// If true, a pin with numeric value label is shown when the slider thumb
  /// is pressed. Use for settings for which users need to know the exact
  /// value of the setting.
  bool get pin => jsElement[r'pin'];
  set pin(bool value) { jsElement[r'pin'] = value; }

  /// The number that represents the current secondary progress.
  num get secondaryProgress => jsElement[r'secondaryProgress'];
  set secondaryProgress(num value) { jsElement[r'secondaryProgress'] = value; }

  /// If true, the slider thumb snaps to tick marks evenly spaced based
  /// on the `step` property value.
  bool get snaps => jsElement[r'snaps'];
  set snaps(bool value) { jsElement[r'snaps'] = value; }

  bool get transiting => jsElement[r'transiting'];
  set transiting(bool value) { jsElement[r'transiting'] = value; }

  /// Decreases value by `step` but not below `min`.
  decrement() =>
      jsElement.callMethod('decrement', []);

  /// Increases value by `step` but not above `max`.
  increment() =>
      jsElement.callMethod('increment', []);
}
