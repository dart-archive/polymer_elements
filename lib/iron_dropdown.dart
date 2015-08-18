// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_dropdown`.
@HtmlImport('iron_dropdown_nodart.html')
library polymer_elements.lib.src.iron_dropdown.iron_dropdown;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_control_state.dart';
import 'iron_a11y_keys_behavior.dart';
import 'iron_overlay_behavior.dart';
import 'iron_fit_behavior.dart';
import 'iron_resizable_behavior.dart';
import 'neon_animation_runner_behavior.dart';
import 'neon_animatable_behavior.dart';
import 'neon_animation/animations/opaque_animation.dart';

/// `<iron-dropdown>` is a generalized element that is useful when you have
/// hidden content (`.dropdown-content`) that is revealed due to some change in
/// state that should cause it to do so.
///
/// Note that this is a low-level element intended to be used as part of other
/// composite elements that cause dropdowns to be revealed.
///
/// Examples of elements that might be implemented using an `iron-dropdown`
/// include comboboxes, menubuttons, selects. The list goes on.
///
/// The `<iron-dropdown>` element exposes attributes that allow the position
/// of the `.dropdown-content` relative to the `.dropdown-trigger` to be
/// configured.
///
///     <iron-dropdown horizontal-align="right" vertical-align="top">
///       <div class="dropdown-content">Hello!</div>
///     </iron-dropdown>
///
/// In the above example, the `<div>` with class `.dropdown-content` will be
/// hidden until the dropdown element has `opened` set to true, or when the `open`
/// method is called on the element.
@CustomElementProxy('iron-dropdown')
class IronDropdown extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronControlState, IronA11yKeysBehavior, IronOverlayBehavior, IronFitBehavior, IronResizableBehavior, NeonAnimationRunnerBehavior, NeonAnimatableBehavior {
  IronDropdown.created() : super.created();
  factory IronDropdown() => new Element.tag('iron-dropdown');

  /// An animation config. If provided, this will be used to animate the
  /// closing of the dropdown.
  get closeAnimationConfig => jsElement[r'closeAnimationConfig'];
  set closeAnimationConfig(value) { jsElement[r'closeAnimationConfig'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// The element that is contained by the dropdown, if any.
  get containedElement => jsElement[r'containedElement'];

  /// The orientation against which to align the dropdown content
  /// horizontally relative to the dropdown trigger.
  String get horizontalAlign => jsElement[r'horizontalAlign'];
  set horizontalAlign(String value) { jsElement[r'horizontalAlign'] = value; }

  /// A pixel value that will be added to the position calculated for the
  /// given `horizontalAlign`. Use a negative value to offset to the
  /// left, or a positive value to offset to the right.
  num get horizontalOffset => jsElement[r'horizontalOffset'];
  set horizontalOffset(num value) { jsElement[r'horizontalOffset'] = value; }

  /// Set to true to disable animations when opening and closing the
  /// dropdown.
  bool get noAnimations => jsElement[r'noAnimations'];
  set noAnimations(bool value) { jsElement[r'noAnimations'] = value; }

  /// An animation config. If provided, this will be used to animate the
  /// opening of the dropdown.
  get openAnimationConfig => jsElement[r'openAnimationConfig'];
  set openAnimationConfig(value) { jsElement[r'openAnimationConfig'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// The element that should be used to position the dropdown when
  /// it is opened.
  get positionTarget => jsElement[r'positionTarget'];
  set positionTarget(value) { jsElement[r'positionTarget'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// The orientation against which to align the dropdown content
  /// vertically relative to the dropdown trigger.
  String get verticalAlign => jsElement[r'verticalAlign'];
  set verticalAlign(String value) { jsElement[r'verticalAlign'] = value; }

  /// A pixel value that will be added to the position calculated for the
  /// given `verticalAlign`. Use a negative value to offset towards the
  /// top, or a positive value to offset towards the bottom.
  num get verticalOffset => jsElement[r'verticalOffset'];
  set verticalOffset(num value) { jsElement[r'verticalOffset'] = value; }
}
