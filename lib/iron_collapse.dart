// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_collapse`.
@HtmlImport('iron_collapse_nodart.html')
library polymer_elements.lib.src.iron_collapse.iron_collapse;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

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
/// `iron-collapse` adjusts the height/width of the collapsible element to show/hide
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
class IronCollapse extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronCollapse.created() : super.created();
  factory IronCollapse() => new Element.tag('iron-collapse');

  /// If true, the orientation is horizontal; otherwise is vertical.
  bool get horizontal => jsElement[r'horizontal'];
  set horizontal(bool value) { jsElement[r'horizontal'] = value; }

  /// Set opened to true to show the collapse element and to false to hide it.
  bool get opened => jsElement[r'opened'];
  set opened(bool value) { jsElement[r'opened'] = value; }

  void enableTransition(enabled) =>
      jsElement.callMethod('enableTransition', [enabled]);

  void hide() =>
      jsElement.callMethod('hide', []);

  void show() =>
      jsElement.callMethod('show', []);

  /// Toggle the opened state.
  void toggle() =>
      jsElement.callMethod('toggle', []);

  void updateSize(size, animated) =>
      jsElement.callMethod('updateSize', [size, animated]);
}
