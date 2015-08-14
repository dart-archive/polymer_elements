// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_fit_behavior`.
@HtmlImport('iron_fit_behavior_nodart.html')
library polymer_elements.lib.src.iron_fit_behavior.iron_fit_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// Polymer.IronFitBehavior fits an element in another element using `max-height` and `max-width`, and
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
/// `max-height` or `height` set | Element respects `max-height` or `height`
/// `max-width` or `width` set   | Element respects `max-width` or `width`
@BehaviorProxy(const ['Polymer', 'IronFitBehavior'])
abstract class IronFitBehavior implements CustomElementProxyMixin {

  /// Set to true to auto-fit on attach.
  bool get autoFitOnAttach => jsElement[r'autoFitOnAttach'];
  set autoFitOnAttach(bool value) { jsElement[r'autoFitOnAttach'] = value; }

  /// The element to fit `this` into.
  get fitInto => jsElement[r'fitInto'];
  set fitInto(value) { jsElement[r'fitInto'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// The element that will receive a `max-height`/`width`. By default it is the same as `this`,
  /// but it can be set to a child element. This is useful, for example, for implementing a
  /// scrolling region inside the element.
  get sizingTarget => jsElement[r'sizingTarget'];
  set sizingTarget(value) { jsElement[r'sizingTarget'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// Centers horizontally and vertically if not already positioned. This also sets
  /// `position:fixed`.
  void center() =>
      jsElement.callMethod('center', []);

  /// Constrains the size of the element to the window or `fitInfo` by setting `max-height`
  /// and/or `max-width`.
  void constrain() =>
      jsElement.callMethod('constrain', []);

  /// Fits and optionally centers the element into the window, or `fitInfo` if specified.
  void fit() =>
      jsElement.callMethod('fit', []);

  /// Equivalent to calling `resetFit()` and `fit()`. Useful to call this after the element,
  /// the window, or the `fitInfo` element has been resized.
  void refit() =>
      jsElement.callMethod('refit', []);

  /// Resets the target element's position and size constraints, and clear
  /// the memoized data.
  void resetFit() =>
      jsElement.callMethod('resetFit', []);
}
