// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_collapse`.
@HtmlImport('iron_collapse_nodart.html')
library polymer_elements.lib.src.iron_collapse.iron_collapse;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_resizable_behavior.dart';

/// `iron-collapse` creates a collapsible block of content.  By default, the content
/// will be collapsed.  Use `opened` or `toggle()` to show/hide the content.
///
///     <button on-click="toggle">toggle collapse</button>
///
///     <iron-collapse id="collapse">
///       <div>Content goes here...</div>
///     </iron-collapse>
///
///     ...
///
///     toggle: function() {
///       this.$.collapse.toggle();
///     }
///
/// `iron-collapse` adjusts the max-height/max-width of the collapsible element to show/hide
/// the content.  So avoid putting padding/margin/border on the collapsible directly,
/// and instead put a div inside and style that.
///
///     <style>
///       .collapse-content {
///         padding: 15px;
///         border: 1px solid #dedede;
///       }
///     </style>
///
///     <iron-collapse>
///       <div class="collapse-content">
///         <div>Content goes here...</div>
///       </div>
///     </iron-collapse>
@CustomElementProxy('iron-collapse')
class IronCollapse extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronResizableBehavior {
  IronCollapse.created() : super.created();
  factory IronCollapse() => new Element.tag('iron-collapse');

  get dimension => jsElement[r'dimension'];

  /// If true, the orientation is horizontal; otherwise is vertical.
  bool get horizontal => jsElement[r'horizontal'];
  set horizontal(bool value) { jsElement[r'horizontal'] = value; }

  /// Set noAnimation to true to disable animations
  bool get noAnimation => jsElement[r'noAnimation'];
  set noAnimation(bool value) { jsElement[r'noAnimation'] = value; }

  /// Set opened to true to show the collapse element and to false to hide it.
  bool get opened => jsElement[r'opened'];
  set opened(bool value) { jsElement[r'opened'] = value; }

  /// enableTransition() is deprecated, but left over so it doesn't break existing code.
  /// Please use `noAnimation` property instead.
  enableTransition(enabled) =>
      jsElement.callMethod('enableTransition', [enabled]);

  hide() =>
      jsElement.callMethod('hide', []);

  show() =>
      jsElement.callMethod('show', []);

  /// Toggle the opened state.
  toggle() =>
      jsElement.callMethod('toggle', []);

  /// Updates the size of the element.
  /// [size]: The new value for `maxWidth`/`maxHeight` as css property value, usually `auto` or `0px`.
  /// [animated]: if `true` updates the size with an animation, otherwise without.
  updateSize(size, animated) =>
      jsElement.callMethod('updateSize', [size, animated]);
}
