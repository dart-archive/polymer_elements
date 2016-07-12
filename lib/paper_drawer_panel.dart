// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_drawer_panel`.
@HtmlImport('paper_drawer_panel_nodart.html')
library polymer_elements.lib.src.paper_drawer_panel.paper_drawer_panel;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_resizable_behavior.dart';
import 'iron_media_query.dart';
import 'iron_selector.dart';

/// Material design: [Navigation drawer](https://www.google.com/design/spec/patterns/navigation-drawer.html)
///
/// `paper-drawer-panel` contains a drawer panel and a main panel.  The drawer
/// and the main panel are side-by-side with drawer on the left.  When the browser
/// window size is smaller than the `responsiveWidth`, `paper-drawer-panel`
/// changes to narrow layout.  In narrow layout, the drawer will be stacked on top
/// of the main panel.  The drawer will slide in/out to hide/reveal the main
/// panel.
///
/// Use the attribute `drawer` to indicate that the element is the drawer panel and
/// `main` to indicate that the element is the main panel.
///
/// Example:
///
///     <paper-drawer-panel>
///       <div drawer> Drawer panel... </div>
///       <div main> Main panel... </div>
///     </paper-drawer-panel>
///
/// The drawer and the main panels are not scrollable.  You can set CSS overflow
/// property on the elements to make them scrollable or use `paper-header-panel`.
///
/// Example:
///
///     <paper-drawer-panel>
///       <paper-header-panel drawer>
///         <paper-toolbar></paper-toolbar>
///         <div> Drawer content... </div>
///       </paper-header-panel>
///       <paper-header-panel main>
///         <paper-toolbar></paper-toolbar>
///         <div> Main content... </div>
///       </paper-header-panel>
///     </paper-drawer-panel>
///
/// An element that should toggle the drawer will automatically do so if it's
/// given the `paper-drawer-toggle` attribute.  Also this element will automatically
/// be hidden in wide layout.
///
/// Example:
///
///     <paper-drawer-panel>
///       <paper-header-panel drawer>
///         <paper-toolbar>
///           <div>Application</div>
///         </paper-toolbar>
///         <div> Drawer content... </div>
///       </paper-header-panel>
///       <paper-header-panel main>
///         <paper-toolbar>
///           <paper-icon-button icon="menu" paper-drawer-toggle></paper-icon-button>
///           <div>Title</div>
///         </paper-toolbar>
///         <div> Main content... </div>
///       </paper-header-panel>
///     </paper-drawer-panel>
///
/// To position the drawer to the right, add `right-drawer` attribute.
///
///     <paper-drawer-panel right-drawer>
///       <div drawer> Drawer panel... </div>
///       <div main> Main panel... </div>
///     </paper-drawer-panel>
///
/// ### Styling
///
/// To change the main container:
///
///     paper-drawer-panel {
///       --paper-drawer-panel-main-container: {
///         background-color: gray;
///       };
///     }
///
/// To change the drawer container when it's in the left side:
///
///     paper-drawer-panel {
///       --paper-drawer-panel-left-drawer-container: {
///         background-color: white;
///       };
///     }
///
/// To change the drawer container when it's in the right side:
///
///     paper-drawer-panel {
///       --paper-drawer-panel-right-drawer-container: {
///         background-color: white;
///       };
///     }
///
/// To customize the scrim:
///
///     paper-drawer-panel {
///       --paper-drawer-panel-scrim: {
///         background-color: red;
///       };
///     }
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-drawer-panel-scrim-opacity` | Scrim opacity | 1
/// `--paper-drawer-panel-drawer-container` | Mixin applied to drawer container | {}
/// `--paper-drawer-panel-left-drawer-container` | Mixin applied to container when it's in the left side | {}
/// `--paper-drawer-panel-main-container` | Mixin applied to main container | {}
/// `--paper-drawer-panel-right-drawer-container` | Mixin applied to container when it's in the right side | {}
/// `--paper-drawer-panel-scrim` | Mixin applied to scrim | {}
@CustomElementProxy('paper-drawer-panel')
class PaperDrawerPanel extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronResizableBehavior {
  PaperDrawerPanel.created() : super.created();
  factory PaperDrawerPanel() => new Element.tag('paper-drawer-panel');

  /// The panel to be selected when `paper-drawer-panel` changes to narrow
  /// layout.
  String get defaultSelected => jsElement[r'defaultSelected'];
  set defaultSelected(String value) { jsElement[r'defaultSelected'] = value; }

  /// If true, swipe from the edge is disabled.
  bool get disableEdgeSwipe => jsElement[r'disableEdgeSwipe'];
  set disableEdgeSwipe(bool value) { jsElement[r'disableEdgeSwipe'] = value; }

  /// If true, swipe to open/close the drawer is disabled.
  bool get disableSwipe => jsElement[r'disableSwipe'];
  set disableSwipe(bool value) { jsElement[r'disableSwipe'] = value; }

  /// Whether the user is dragging the drawer interactively.
  bool get dragging => jsElement[r'dragging'];
  set dragging(bool value) { jsElement[r'dragging'] = value; }

  /// The CSS selector for the element that should receive focus when the drawer is open.
  /// By default, when the drawer opens, it focuses the first tabbable element. That is,
  /// the first element that can receive focus.
  ///
  /// To disable this behavior, you can set `drawerFocusSelector` to `null` or an empty string.
  String get drawerFocusSelector => jsElement[r'drawerFocusSelector'];
  set drawerFocusSelector(String value) { jsElement[r'drawerFocusSelector'] = value; }

  /// The attribute on elements that should toggle the drawer on tap, also elements will
  /// automatically be hidden in wide layout.
  String get drawerToggleAttribute => jsElement[r'drawerToggleAttribute'];
  set drawerToggleAttribute(String value) { jsElement[r'drawerToggleAttribute'] = value; }

  /// Width of the drawer panel.
  String get drawerWidth => jsElement[r'drawerWidth'];
  set drawerWidth(String value) { jsElement[r'drawerWidth'] = value; }

  /// How many pixels on the side of the screen are sensitive to edge
  /// swipes and peek.
  num get edgeSwipeSensitivity => jsElement[r'edgeSwipeSensitivity'];
  set edgeSwipeSensitivity(num value) { jsElement[r'edgeSwipeSensitivity'] = value; }

  /// If true, ignore `responsiveWidth` setting and force the narrow layout.
  bool get forceNarrow => jsElement[r'forceNarrow'];
  set forceNarrow(bool value) { jsElement[r'forceNarrow'] = value; }

  /// Whether the browser has support for the transform CSS property.
  bool get hasTransform => jsElement[r'hasTransform'];
  set hasTransform(bool value) { jsElement[r'hasTransform'] = value; }

  /// Whether the browser has support for the will-change CSS property.
  bool get hasWillChange => jsElement[r'hasWillChange'];
  set hasWillChange(bool value) { jsElement[r'hasWillChange'] = value; }

  /// Returns true if the panel is in narrow layout.  This is useful if you
  /// need to show/hide elements based on the layout.
  bool get narrow => jsElement[r'narrow'];
  set narrow(bool value) { jsElement[r'narrow'] = value; }

  /// Whether the drawer is peeking out from the edge.
  bool get peeking => jsElement[r'peeking'];
  set peeking(bool value) { jsElement[r'peeking'] = value; }

  /// Max-width when the panel changes to narrow layout.
  String get responsiveWidth => jsElement[r'responsiveWidth'];
  set responsiveWidth(String value) { jsElement[r'responsiveWidth'] = value; }

  /// If true, position the drawer to the right.
  bool get rightDrawer => jsElement[r'rightDrawer'];
  set rightDrawer(bool value) { jsElement[r'rightDrawer'] = value; }

  /// The panel that is being selected. `drawer` for the drawer panel and
  /// `main` for the main panel.
  get selected => jsElement[r'selected'];
  set selected(value) { jsElement[r'selected'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Closes the drawer.
  closeDrawer() =>
      jsElement.callMethod('closeDrawer', []);

  /// Opens the drawer.
  openDrawer() =>
      jsElement.callMethod('openDrawer', []);

  /// Toggles the panel open and closed.
  togglePanel() =>
      jsElement.callMethod('togglePanel', []);
}
