// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_tabs`.
@HtmlImport('paper_tabs_nodart.html')
library polymer_elements.lib.src.paper_tabs.paper_tabs;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_resizable_behavior.dart';
import 'iron_menubar_behavior.dart';
import 'iron_menu_behavior.dart';
import 'iron_flex_layout.dart';
import 'iron_flex_layout/classes/iron_flex_layout.dart';
import 'iron_icon.dart';
import 'paper_icon_button.dart';
import 'color.dart';
import 'paper_tabs_icons.dart';
import 'paper_tab.dart';

/// `paper-tabs` makes it easy to explore and switch between different views or functional aspects of
/// an app, or to browse categorized data sets.
///
/// Use `selected` property to get or set the selected tab.
///
/// Example:
///
///     <paper-tabs selected="0">
///       <paper-tab>TAB 1</paper-tab>
///       <paper-tab>TAB 2</paper-tab>
///       <paper-tab>TAB 3</paper-tab>
///     </paper-tabs>
///
/// See <a href="#paper-tab">paper-tab</a> for more information about
/// `paper-tab`.
///
/// A common usage for `paper-tabs` is to use it along with `iron-pages` to switch
/// between different views.
///
///     <paper-tabs selected="{{selected}}">
///       <paper-tab>Tab 1</paper-tab>
///       <paper-tab>Tab 2</paper-tab>
///       <paper-tab>Tab 3</paper-tab>
///     </paper-tabs>
///
///     <iron-pages selected="{{selected}}">
///       <div>Page 1</div>
///       <div>Page 2</div>
///       <div>Page 3</div>
///     </iron-pages>
///
///
/// To use links in tabs, add `link` attribute to `paper-tab` and put an `<a>`
/// element in `paper-tab`.
///
/// Example:
///
///     <paper-tabs selected="0">
///       <paper-tab link>
///         <a href="#link1" class="horizontal center-center layout">TAB ONE</a>
///       </paper-tab>
///       <paper-tab link>
///         <a href="#link2" class="horizontal center-center layout">TAB TWO</a>
///       </paper-tab>
///       <paper-tab link>
///         <a href="#link3" class="horizontal center-center layout">TAB THREE</a>
///       </paper-tab>
///     </paper-tabs>
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-tabs-selection-bar-color` | Color for the selection bar | `--paper-yellow-a100`
/// `--paper-tabs` | Mixin applied to the tabs | `{}`
@CustomElementProxy('paper-tabs')
class PaperTabs extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronResizableBehavior, IronMenubarBehavior, IronMenuBehavior {
  PaperTabs.created() : super.created();
  factory PaperTabs() => new Element.tag('paper-tabs');

  /// If true, the tabs are aligned to bottom (the selection bar appears at the top).
  bool get alignBottom => jsElement[r'alignBottom'];
  set alignBottom(bool value) { jsElement[r'alignBottom'] = value; }

  /// If true, dragging on the tabs to scroll is disabled.
  bool get disableDrag => jsElement[r'disableDrag'];
  set disableDrag(bool value) { jsElement[r'disableDrag'] = value; }

  /// If true, scroll buttons (left/right arrow) will be hidden for scrollable tabs.
  bool get hideScrollButtons => jsElement[r'hideScrollButtons'];
  set hideScrollButtons(bool value) { jsElement[r'hideScrollButtons'] = value; }

  /// If true, the bottom bar to indicate the selected tab will not be shown.
  bool get noBar => jsElement[r'noBar'];
  set noBar(bool value) { jsElement[r'noBar'] = value; }

  /// If true, ink ripple effect is disabled.
  bool get noink => jsElement[r'noink'];
  set noink(bool value) { jsElement[r'noink'] = value; }

  /// If true, the slide effect for the bottom bar is disabled.
  bool get noSlide => jsElement[r'noSlide'];
  set noSlide(bool value) { jsElement[r'noSlide'] = value; }

  /// If true, tabs are scrollable and the tab width is based on the label width.
  bool get scrollable => jsElement[r'scrollable'];
  set scrollable(bool value) { jsElement[r'scrollable'] = value; }

  String get selectable => jsElement[r'selectable'];
  set selectable(String value) { jsElement[r'selectable'] = value; }

  /// Gets or sets the selected element. The default is to use the index of the item.
  get selected => jsElement[r'selected'];
  set selected(value) { jsElement[r'selected'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}
}
