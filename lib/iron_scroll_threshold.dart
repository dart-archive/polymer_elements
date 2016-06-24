// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_scroll_threshold`.
@HtmlImport('iron_scroll_threshold_nodart.html')
library polymer_elements.lib.src.iron_scroll_threshold.iron_scroll_threshold;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_scroll_target_behavior.dart';

/// `iron-scroll-threshold` is a utility element that listens for `scroll` events from a
/// scrollable region and fires events to indicate when the scroller has reached a pre-defined
/// limit, specified in pixels from the upper and lower bounds of the scrollable region.
/// This element may wrap a scrollable region and will listen for `scroll` events bubbling
/// through it from its children.  In this case, care should be taken that only one scrollable
/// region with the same orientation as this element is contained within. Alternatively,
/// the `scrollTarget` property can be set/bound to a non-child scrollable region, from which
/// it will listen for events.
///
/// Once a threshold has been reached, a `lower-threshold` or `upper-threshold` event will
/// be fired, at which point the user may perform actions such as lazily-loading more data
/// to be displayed. After any work is done, the user must then clear the threshold by
/// calling the `clearTriggers` method on this element, after which it will
/// begin listening again for the scroll position to reach the threshold again assuming
/// the content in the scrollable region has grown. If the user no longer wishes to receive
/// events (e.g. all data has been exhausted), the threshold property in question (e.g.
/// `lowerThreshold`) may be set to a falsy value to disable events and clear the associated
/// triggered property.
///
/// ### Example
///
/// ```html
/// <iron-scroll-threshold on-lower-threshold="loadMoreData">
///   <div>content</div>
/// </iron-scroll-threshold>
/// ```
///
/// ```js
///   loadMoreData: function() {
///     // load async stuff. e.g. XHR
///     asyncStuff(function done() {
///       ironScrollTheshold.clearTriggers();
///     });
///   }
/// ```
///
/// ### Using dom-repeat
///
/// ```html
/// <iron-scroll-threshold on-lower-threshold="loadMoreData">
///   <dom-repeat items="[[items]]">
///     <template>
///       <div>[[index]]</div>
///     </template>
///   </dom-repeat>
/// </iron-scroll-threshold>
/// ```
///
/// ### Using iron-list
///
/// ```html
/// <iron-scroll-threshold on-lower-threshold="loadMoreData" id="threshold">
///   <iron-list scroll-target="threshold" items="[[items]]">
///     <template>
///       <div>[[index]]</div>
///     </template>
///   </iron-list>
/// </iron-scroll-threshold>
/// ```
@CustomElementProxy('iron-scroll-threshold')
class IronScrollThreshold extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronScrollTargetBehavior {
  IronScrollThreshold.created() : super.created();
  factory IronScrollThreshold() => new Element.tag('iron-scroll-threshold');

  /// True if the orientation of the scroller is horizontal.
  bool get horizontal => jsElement[r'horizontal'];
  set horizontal(bool value) { jsElement[r'horizontal'] = value; }

  /// Distance from the bottom (or right, for horizontal) bound of the scroller
  /// where the "lower trigger" will fire.
  num get lowerThreshold => jsElement[r'lowerThreshold'];
  set lowerThreshold(num value) { jsElement[r'lowerThreshold'] = value; }

  /// Read-only value that tracks the triggered state of the lower threshold.
  bool get lowerTriggered => jsElement[r'lowerTriggered'];
  set lowerTriggered(bool value) { jsElement[r'lowerTriggered'] = value; }

  /// Distance from the top (or left, for horizontal) bound of the scroller
  /// where the "upper trigger" will fire.
  num get upperThreshold => jsElement[r'upperThreshold'];
  set upperThreshold(num value) { jsElement[r'upperThreshold'] = value; }

  /// Read-only value that tracks the triggered state of the upper threshold.
  bool get upperTriggered => jsElement[r'upperTriggered'];
  set upperTriggered(bool value) { jsElement[r'upperTriggered'] = value; }

  /// Checks the scroll thresholds.
  /// This method is automatically called by iron-scroll-threshold.
  checkScrollThesholds() =>
      jsElement.callMethod('checkScrollThesholds', []);

  /// Clear the upper and lower threshold states.
  clearTriggers() =>
      jsElement.callMethod('clearTriggers', []);
}
