// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_scroll_target_behavior`.
@HtmlImport('iron_scroll_target_behavior_nodart.html')
library polymer_elements.lib.src.iron_scroll_target_behavior.iron_scroll_target_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// `Polymer.IronScrollTargetBehavior` allows an element to respond to scroll events from a
/// designated scroll target.
///
/// Elements that consume this behavior can override the `_scrollHandler`
/// method to add logic on the scroll event.
@BehaviorProxy(const ['Polymer', 'IronScrollTargetBehavior'])
abstract class IronScrollTargetBehavior implements CustomElementProxyMixin {

  /// Specifies the element that will handle the scroll event
  /// on the behalf of the current element. This is typically a reference to an element,
  /// but there are a few more posibilities:
  ///
  /// ### Elements id
  ///
  /// ```html
  /// <div id="scrollable-element" style="overflow: auto;">
  ///  <x-element scroll-target="scrollable-element">
  ///    <!-- Content-->
  ///  </x-element>
  /// </div>
  /// ```
  /// In this case, the `scrollTarget` will point to the outer div element.
  ///
  /// ### Document scrolling
  ///
  /// For document scrolling, you can use the reserved word `document`:
  ///
  /// ```html
  /// <x-element scroll-target="document">
  ///   <!-- Content -->
  /// </x-element>
  /// ```
  ///
  /// ### Elements reference
  ///
  /// ```js
  /// appHeader.scrollTarget = document.querySelector('#scrollable-element');
  /// ```
  get scrollTarget => jsElement[r'scrollTarget'];
  set scrollTarget(value) { jsElement[r'scrollTarget'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Scrolls the content to a particular place.
  /// [left]: The left position
  /// [top]: The top position
  scroll(num left, num top) =>
      jsElement.callMethod('scroll', [left, top]);
}
