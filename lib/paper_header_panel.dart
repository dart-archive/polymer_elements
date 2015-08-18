// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_header_panel`.
@HtmlImport('paper_header_panel_nodart.html')
library polymer_elements.lib.src.paper_header_panel.paper_header_panel;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_flex_layout.dart';

/// `paper-header-panel` contains a header section and a content panel section.
///
/// __Important:__ The `paper-header-panel` will not display if its parent does not have a height.
///
/// Using layout classes, you can make the `paper-header-panel` fill the screen
///
///     <body class="fullbleed layout vertical">
///       <paper-header-panel class="flex">
///         <paper-toolbar>
///           <div>Hello World!</div>
///         </paper-toolbar>
///       </paper-header-panel>
///     </body>
///
/// Special support is provided for scrolling modes when one uses a paper-toolbar or equivalent for the
/// header section.
///
/// Example:
///
///     <paper-header-panel>
///       <paper-toolbar>Header</paper-toolbar>
///       <div>Content goes here...</div>
///     </paper-header-panel>
///
/// If you want to use other than `paper-toolbar` for the header, add `paper-header` class to that
/// element.
///
/// Example:
///
///     <paper-header-panel>
///       <div class="paper-header">Header</div>
///       <div>Content goes here...</div>
///     </paper-header-panel>
///
/// To have the content fit to the main area, use the `fit` class.
///
///     <paper-header-panel>
///       <div class="paper-header">standard</div>
///       <div class="fit">content fits 100% below the header</div>
///     </paper-header-panel>
///
/// Modes
///
/// Controls header and scrolling behavior. Options are `standard`, `seamed`, `waterfall`, `waterfall-tall`, `scroll` and
/// `cover`. Default is `standard`.
///
/// Mode | Description
/// ----------------|-------------
/// `standard` | The header is a step above the panel. The header will consume the panel at the point of entry, preventing it from passing through to the opposite side.
/// `seamed` | The header is presented as seamed with the panel.
/// `waterfall` | Similar to standard mode, but header is initially presented as seamed with panel, but then separates to form the step.
/// `waterfall-tall` | The header is initially taller (`tall` class is added to the header). As the user scrolls, the header separates (forming an edge) while condensing (`tall` class is removed from the header).
/// `scroll` | The header keeps its seam with the panel, and is pushed off screen.
/// `cover` | The panel covers the whole `paper-header-panel` including the header. This allows user to style the panel in such a way that the panel is partially covering the header.
///
/// Example:
///
///     <paper-header-panel mode="waterfall">
///       <div class="paper-header">standard</div>
///       <div class="content fit">content fits 100% below the header</div>
///     </paper-header-panel>
///
///
/// Styling header panel:
///
/// To change the shadow that shows up underneath the header:
///
///     paper-header-panel {
///       --paper-header-panel-shadow: {
///           height: 6px;
///           bottom: -6px;
///           box-shadow: inset 0px 5px 6px -3px rgba(0, 0, 0, 0.4);
///       };
///     }
///
/// To change the panel container in different modes:
///
///     paper-slider {
///       --paper-header-panel-standard-container: {
///         border: 1px solid gray;
///       };
///
///       --paper-header-panel-cover-container: {
///         border: 1px solid gray;
///       };
///
///       --paper-header-panel-waterfall-container: {
///         border: 1px solid gray;
///       };
///
///       --paper-header-panel-waterfall-tall-container: {
///         border: 1px solid gray;
///       };
///     }
@CustomElementProxy('paper-header-panel')
class PaperHeaderPanel extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  PaperHeaderPanel.created() : super.created();
  factory PaperHeaderPanel() => new Element.tag('paper-header-panel');

  /// If true, the scroller is at the top
  bool get atTop => jsElement[r'atTop'];
  set atTop(bool value) { jsElement[r'atTop'] = value; }

  /// Returns the header element
  get header => jsElement[r'header'];

  /// Controls header and scrolling behavior. Options are
  /// `standard`, `seamed`, `waterfall`, `waterfall-tall`, `scroll` and
  /// `cover`. Default is `standard`.
  ///
  /// `standard`: The header is a step above the panel. The header will consume the
  /// panel at the point of entry, preventing it from passing through to the
  /// opposite side.
  ///
  /// `seamed`: The header is presented as seamed with the panel.
  ///
  /// `waterfall`: Similar to standard mode, but header is initially presented as
  /// seamed with panel, but then separates to form the step.
  ///
  /// `waterfall-tall`: The header is initially taller (`tall` class is added to
  /// the header).  As the user scrolls, the header separates (forming an edge)
  /// while condensing (`tall` class is removed from the header).
  ///
  /// `scroll`: The header keeps its seam with the panel, and is pushed off screen.
  ///
  /// `cover`: The panel covers the whole `paper-header-panel` including the
  /// header. This allows user to style the panel in such a way that the panel is
  /// partially covering the header.
  ///
  ///     <paper-header-panel mode="cover">
  ///       <paper-toolbar class="tall">
  ///         <core-icon-button icon="menu"></core-icon-button>
  ///       </paper-toolbar>
  ///       <div class="content"></div>
  ///     </paper-header-panel>
  String get mode => jsElement[r'mode'];
  set mode(String value) { jsElement[r'mode'] = value; }

  /// Returns the scrollable element.
  get scroller => jsElement[r'scroller'];

  /// If true, the drop-shadow is always shown no matter what mode is set to.
  bool get shadow => jsElement[r'shadow'];
  set shadow(bool value) { jsElement[r'shadow'] = value; }

  /// The class used in waterfall-tall mode.  Change this if the header
  /// accepts a different class for toggling height, e.g. "medium-tall"
  String get tallClass => jsElement[r'tallClass'];
  set tallClass(String value) { jsElement[r'tallClass'] = value; }

  /// Returns true if the scroller has a visible shadow.
  get visibleShadow => jsElement[r'visibleShadow'];
}
