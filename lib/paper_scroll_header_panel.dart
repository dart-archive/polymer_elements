// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_scroll_header_panel`.
@HtmlImport('paper_scroll_header_panel_nodart.html')
library polymer_elements.lib.src.paper_scroll_header_panel.paper_scroll_header_panel;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_resizable_behavior.dart';

/// Material design: [Scrolling techniques](https://www.google.com/design/spec/patterns/scrolling-techniques.html)
///
/// `paper-scroll-header-panel` contains a header section and a content section.  The
/// header is initially on the top part of the view but it scrolls away with the
/// rest of the scrollable content.  Upon scrolling slightly up at any point, the
/// header scrolls back into view.  This saves screen space and allows users to
/// access important controls by easily moving them back to the view.
///
/// __Important:__ The `paper-scroll-header-panel` will not display if its parent does not have a height.
///
/// Using [layout classes](https://www.polymer-project.org/1.0/docs/migration.html#layout-attributes) or custom properties, you can easily make the `paper-scroll-header-panel` fill the screen
///
/// ```html
/// <body class="fullbleed layout vertical">
///   <paper-scroll-header-panel class="flex">
///     <paper-toolbar>
///       <div>Hello World!</div>
///     </paper-toolbar>
///   </paper-scroll-header-panel>
/// </body>
/// ```
///
/// or, if you would prefer to do it in CSS, just give `html`, `body`, and `paper-scroll-header-panel` a height of 100%:
///
/// ```css
/// html, body {
///   height: 100%;
///   margin: 0;
/// }
/// paper-scroll-header-panel {
///   height: 100%;
/// }
/// ```
///
/// `paper-scroll-header-panel` works well with `paper-toolbar` but can use any element
/// that represents a header by adding a `paper-header` class to it.
///
/// ```html
/// <paper-scroll-header-panel>
///   <div class="paper-header">Header</div>
///   <div>Content goes here...</div>
/// </paper-scroll-header-panel>
/// ```
///
/// ### Styling
/// =======
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// --paper-scroll-header-panel-full-header | To change background for toolbar when it is at its full size | {}
/// --paper-scroll-header-panel-condensed-header | To change the background for toolbar when it is condensed | {}
/// --paper-scroll-header-container | To override or add container styles | {}
@CustomElementProxy('paper-scroll-header-panel')
class PaperScrollHeaderPanel extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronResizableBehavior {
  PaperScrollHeaderPanel.created() : super.created();
  factory PaperScrollHeaderPanel() => new Element.tag('paper-scroll-header-panel');

  /// The height of the header when it is condensed.
  ///
  /// By default, `condensedHeaderHeight` is 1/3 of `headerHeight` unless
  /// this is specified.
  num get condensedHeaderHeight => jsElement[r'condensedHeaderHeight'];
  set condensedHeaderHeight(num value) { jsElement[r'condensedHeaderHeight'] = value; }

  /// If true, the header's height will condense to `condensedHeaderHeight`
  /// as the user scrolls down from the top of the content area.
  bool get condenses => jsElement[r'condenses'];
  set condenses(bool value) { jsElement[r'condenses'] = value; }

  /// Returns the content element.
  get content => jsElement[r'content'];

  /// If true, the header is fixed to the top and never moves away.
  bool get fixed => jsElement[r'fixed'];
  set fixed(bool value) { jsElement[r'fixed'] = value; }

  /// Returns the header element.
  get header => jsElement[r'header'];

  /// The height of the header when it is at its full size.
  ///
  /// By default, the height will be measured when it is ready.  If the height
  /// changes later the user needs to either set this value to reflect the
  /// new height or invoke `measureHeaderHeight()`.
  num get headerHeight => jsElement[r'headerHeight'];
  set headerHeight(num value) { jsElement[r'headerHeight'] = value; }

  /// The state of the header. Depending on the configuration and the `scrollTop` value,
  /// the header state could change to
  ///      Polymer.PaperScrollHeaderPanel.HEADER_STATE_EXPANDED
  ///      Polymer.PaperScrollHeaderPanel.HEADER_STATE_HIDDEN
  ///      Polymer.PaperScrollHeaderPanel.HEADER_STATE_CONDENSED
  ///      Polymer.PaperScrollHeaderPanel.HEADER_STATE_INTERPOLATED
  num get headerState => jsElement[r'headerState'];
  set headerState(num value) { jsElement[r'headerState'] = value; }

  /// If true, the condensed header is always shown and does not move away.
  bool get keepCondensedHeader => jsElement[r'keepCondensedHeader'];
  set keepCondensedHeader(bool value) { jsElement[r'keepCondensedHeader'] = value; }

  /// If true, no cross-fade transition from one background to another.
  bool get noDissolve => jsElement[r'noDissolve'];
  set noDissolve(bool value) { jsElement[r'noDissolve'] = value; }

  /// If true, the header doesn't slide back in when scrolling back up.
  bool get noReveal => jsElement[r'noReveal'];
  set noReveal(bool value) { jsElement[r'noReveal'] = value; }

  /// By default, the top part of the header stays when the header is being
  /// condensed.  Set this to true if you want the top part of the header
  /// to be scrolled away.
  bool get scrollAwayTopbar => jsElement[r'scrollAwayTopbar'];
  set scrollAwayTopbar(bool value) { jsElement[r'scrollAwayTopbar'] = value; }

  /// Returns the scrollable element.
  get scroller => jsElement[r'scroller'];

  /// Condense the header.
  /// [smooth]: true if the scroll position should be smoothly adjusted.
  condense(bool smooth) =>
      jsElement.callMethod('condense', [smooth]);

  /// Invoke this to tell `paper-scroll-header-panel` to re-measure the header's
  /// height.
  measureHeaderHeight() =>
      jsElement.callMethod('measureHeaderHeight', []);

  /// Scroll to a specific y coordinate.
  /// [top]: The coordinate to scroll to, along the y-axis.
  /// [smooth]: true if the scroll position should be smoothly adjusted.
  scrollAt(num top, bool smooth) =>
      jsElement.callMethod('scroll', [top, smooth]);

  /// Scroll to the top of the content.
  /// [smooth]: true if the scroll position should be smoothly adjusted.
  scrollToTop(bool smooth) =>
      jsElement.callMethod('scrollToTop', [smooth]);
}
