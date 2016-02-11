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
  /// on the behalf of the current element. This is typically a reference to an `Element`,
  /// but there are a few more posibilities:
  ///
  /// ### Elements id
  ///
  /// ```html
  /// <div id="scrollable-element" style="overflow-y: auto;">
  ///  <x-element scroll-target="scrollable-element">
  ///    Content
  ///  </x-element>
  /// </div>
  /// ```
  /// In this case, `scrollTarget` will point to the outer div element. Alternatively,
  /// you can set the property programatically:
  ///
  /// ```js
  /// appHeader.scrollTarget = document.querySelector('#scrollable-element');
  /// ```
  get scrollTarget => jsElement[r'scrollTarget'];
  set scrollTarget(value) { jsElement[r'scrollTarget'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Scrolls the content to a particular place.
  /// [top]: The top position
  /// [left]: The left position
  scroll(num top, num left) =>
      jsElement.callMethod('scroll', [top, left]);
}
