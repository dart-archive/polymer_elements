// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_tooltip`.
@HtmlImport('paper_tooltip_nodart.html')
library polymer_elements.lib.src.paper_tooltip.paper_tooltip;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'neon_animation_runner_behavior.dart';
import 'neon_animatable_behavior.dart';
import 'neon_animation/animations/fade_in_animation.dart';
import 'neon_animation/animations/fade_out_animation.dart';

/// `<paper-tooltip>` is a label that appears on hover and focus when the user
/// hovers over an element with the cursor or with the keyboard. It will be centered
/// to an anchor element specified in the `for` attribute, or, if that doesn't exist,
/// centered to the parent node containing it.
///
/// Example:
///
///     <div style="display:inline-block">
///       <button>Click me!</button>
///       <paper-tooltip>Tooltip text</paper-tooltip>
///     </div>
///
///     <div>
///       <button id="btn">Click me!</button>
///       <paper-tooltip for="btn">Tooltip text</paper-tooltip>
///     </div>
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-tooltip-background` | The background color of the tooltip | `#616161`
/// `--paper-tooltip-opacity` | The opacity of the tooltip | `0.9`
/// `--paper-tooltip-text-color` | The text color of the tooltip | `white`
/// `--paper-tooltip` | Mixin applied to the tooltip | `{}`
@CustomElementProxy('paper-tooltip')
class PaperTooltip extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationRunnerBehavior, NeonAnimatableBehavior {
  PaperTooltip.created() : super.created();
  factory PaperTooltip() => new Element.tag('paper-tooltip');

  get animationConfig => jsElement[r'animationConfig'];
  set animationConfig(value) { jsElement[r'animationConfig'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// The id of the element that the tooltip is anchored to. This element
  /// must be a sibling of the tooltip.
  String get forId => jsElement[r'for'];
  set forId(String value) { jsElement[r'for'] = value; }

  /// The spacing between the top of the tooltip and the element it is
  /// anchored to.
  num get marginTop => jsElement[r'marginTop'];
  set marginTop(num value) { jsElement[r'marginTop'] = value; }

  /// Returns the target element that this tooltip is anchored to. It is
  /// either the element given by the `for` attribute, or the immediate parent
  /// of the tooltip.
  get target => jsElement[r'target'];

  void hide() =>
      jsElement.callMethod('hide', []);

  void show() =>
      jsElement.callMethod('show', []);
}
