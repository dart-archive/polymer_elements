// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_fit_behavior`.
@HtmlImport('iron_fit_behavior_nodart.html')
library polymer_elements.lib.src.iron_fit_behavior.iron_fit_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// `Polymer.IronFitBehavior` fits an element in another element using `max-height` and `max-width`, and
/// optionally centers it in the window or another element.
///
/// The element will only be sized and/or positioned if it has not already been sized and/or positioned
/// by CSS.
///
/// CSS properties               | Action
/// -----------------------------|-------------------------------------------
/// `position` set               | Element is not centered horizontally or vertically
/// `top` or `bottom` set        | Element is not vertically centered
/// `left` or `right` set        | Element is not horizontally centered
/// `max-height` set             | Element respects `max-height`
/// `max-width` set              | Element respects `max-width`
///
/// `Polymer.IronFitBehavior` can position an element into another element using
/// `verticalAlign` and `horizontalAlign`. This will override the element's css position.
///
///       <div class="container">
///         <iron-fit-impl vertical-align="top" horizontal-align="auto">
///           Positioned into the container
///         </iron-fit-impl>
///       </div>
///
/// Use `noOverlap` to position the element around another element without overlapping it.
///
///       <div class="container">
///         <iron-fit-impl no-overlap vertical-align="auto" horizontal-align="auto">
///           Positioned around the container
///         </iron-fit-impl>
///       </div>
@BehaviorProxy(const ['Polymer', 'IronFitBehavior'])
abstract class IronFitBehavior implements CustomElementProxyMixin {

  /// Set to true to auto-fit on attach.
  bool get autoFitOnAttach => jsElement[r'autoFitOnAttach'];
  set autoFitOnAttach(bool value) { jsElement[r'autoFitOnAttach'] = value; }

  /// If true, it will use `horizontalAlign` and `verticalAlign` values as preferred alignment
  /// and if there's not enough space, it will pick the values which minimize the cropping.
  bool get dynamicAlign => jsElement[r'dynamicAlign'];
  set dynamicAlign(bool value) { jsElement[r'dynamicAlign'] = value; }

  /// The element to fit `this` into.
  get fitInto => jsElement[r'fitInto'];
  set fitInto(value) { jsElement[r'fitInto'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The orientation against which to align the element horizontally
  /// relative to the `positionTarget`. Possible values are "left", "right", "auto".
  String get horizontalAlign => jsElement[r'horizontalAlign'];
  set horizontalAlign(String value) { jsElement[r'horizontalAlign'] = value; }

  /// The same as setting margin-left and margin-right css properties.
  num get horizontalOffset => jsElement[r'horizontalOffset'];
  set horizontalOffset(num value) { jsElement[r'horizontalOffset'] = value; }

  /// Will position the element around the positionTarget without overlapping it.
  bool get noOverlap => jsElement[r'noOverlap'];
  set noOverlap(bool value) { jsElement[r'noOverlap'] = value; }

  /// The element that should be used to position the element. If not set, it will
  /// default to the parent node.
  get positionTarget => jsElement[r'positionTarget'];
  set positionTarget(value) { jsElement[r'positionTarget'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The element that will receive a `max-height`/`width`. By default it is the same as `this`,
  /// but it can be set to a child element. This is useful, for example, for implementing a
  /// scrolling region inside the element.
  get sizingTarget => jsElement[r'sizingTarget'];
  set sizingTarget(value) { jsElement[r'sizingTarget'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The orientation against which to align the element vertically
  /// relative to the `positionTarget`. Possible values are "top", "bottom", "auto".
  String get verticalAlign => jsElement[r'verticalAlign'];
  set verticalAlign(String value) { jsElement[r'verticalAlign'] = value; }

  /// The same as setting margin-top and margin-bottom css properties.
  num get verticalOffset => jsElement[r'verticalOffset'];
  set verticalOffset(num value) { jsElement[r'verticalOffset'] = value; }

  /// Centers horizontally and vertically if not already positioned. This also sets
  /// `position:fixed`.
  center() =>
      jsElement.callMethod('center', []);

  /// Constrains the size of the element to `fitInto` by setting `max-height`
  /// and/or `max-width`.
  constrain() =>
      jsElement.callMethod('constrain', []);

  /// Positions and fits the element into the `fitInto` element.
  fit() =>
      jsElement.callMethod('fit', []);

  /// Positions the element according to `horizontalAlign, verticalAlign`.
  position() =>
      jsElement.callMethod('position', []);

  /// Equivalent to calling `resetFit()` and `fit()`. Useful to call this after
  /// the element or the `fitInto` element has been resized, or if any of the
  /// positioning properties (e.g. `horizontalAlign, verticalAlign`) is updated.
  /// It preserves the scroll position of the sizingTarget.
  refit() =>
      jsElement.callMethod('refit', []);

  /// Resets the target element's position and size constraints, and clear
  /// the memoized data.
  resetFit() =>
      jsElement.callMethod('resetFit', []);
}
