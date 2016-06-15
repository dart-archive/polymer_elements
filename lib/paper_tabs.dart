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
import 'iron_multi_selectable.dart';
import 'iron_selectable.dart';
import 'iron_a11y_keys_behavior.dart';
import 'iron_flex_layout.dart';
import 'iron_icon.dart';
import 'paper_icon_button.dart';
import 'color.dart';
import 'paper_tabs_icons.dart';
import 'paper_tab.dart';

/// Material design: [Tabs](https://www.google.com/design/spec/components/tabs.html)
///
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
/// See <a href="?active=paper-tab">paper-tab</a> for more information about
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
/// element in `paper-tab` with a `tabindex` of -1.
///
/// Example:
///
/// <pre><code>
/// &lt;style is="custom-style">
///   .link {
///     &#64;apply(--layout-horizontal);
///     &#64;apply(--layout-center-center);
///   }
/// &lt;/style>
///
/// &lt;paper-tabs selected="0">
///   &lt;paper-tab link>
///     &lt;a href="#link1" class="link" tabindex="-1">TAB ONE&lt;/a>
///   &lt;/paper-tab>
///   &lt;paper-tab link>
///     &lt;a href="#link2" class="link" tabindex="-1">TAB TWO&lt;/a>
///   &lt;/paper-tab>
///   &lt;paper-tab link>
///     &lt;a href="#link3" class="link" tabindex="-1">TAB THREE&lt;/a>
///   &lt;/paper-tab>
/// &lt;/paper-tabs>
/// </code></pre>
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-tabs-selection-bar-color` | Color for the selection bar | `--paper-yellow-a100`
/// `--paper-tabs-selection-bar` | Mixin applied to the selection bar | `{}`
/// `--paper-tabs` | Mixin applied to the tabs | `{}`
@CustomElementProxy('paper-tabs')
class PaperTabs extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronResizableBehavior, IronSelectableBehavior, IronMultiSelectableBehavior, IronA11yKeysBehavior, IronMenuBehavior, IronMenubarBehavior {
  PaperTabs.created() : super.created();
  factory PaperTabs() => new Element.tag('paper-tabs');

  /// If true, the tabs are aligned to bottom (the selection bar appears at the top).
  bool get alignBottom => jsElement[r'alignBottom'];
  set alignBottom(bool value) { jsElement[r'alignBottom'] = value; }

  /// If true, tabs are automatically selected when focused using the
  /// keyboard.
  bool get autoselect => jsElement[r'autoselect'];
  set autoselect(bool value) { jsElement[r'autoselect'] = value; }

  /// The delay (in milliseconds) between when the user stops interacting
  /// with the tabs through the keyboard and when the focused item is
  /// automatically selected (if `autoselect` is true).
  num get autoselectDelay => jsElement[r'autoselectDelay'];
  set autoselectDelay(num value) { jsElement[r'autoselectDelay'] = value; }

  /// If true, dragging on the tabs to scroll is disabled.
  bool get disableDrag => jsElement[r'disableDrag'];
  set disableDrag(bool value) { jsElement[r'disableDrag'] = value; }

  /// If true, tabs expand to fit their container. This currently only applies when
  /// scrollable is true.
  bool get fitContainer => jsElement[r'fitContainer'];
  set fitContainer(bool value) { jsElement[r'fitContainer'] = value; }

  /// If true, scroll buttons (left/right arrow) will be hidden for scrollable tabs.
  bool get hideScrollButtons => jsElement[r'hideScrollButtons'];
  set hideScrollButtons(bool value) { jsElement[r'hideScrollButtons'] = value; }

  get keyBindings => jsElement[r'keyBindings'];
  set keyBindings(value) { jsElement[r'keyBindings'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// If true, the bottom bar to indicate the selected tab will not be shown.
  bool get noBar => jsElement[r'noBar'];
  set noBar(bool value) { jsElement[r'noBar'] = value; }

  /// If true, the slide effect for the bottom bar is disabled.
  bool get noSlide => jsElement[r'noSlide'];
  set noSlide(bool value) { jsElement[r'noSlide'] = value; }

  /// If true, ink ripple effect is disabled. When this property is changed,
  /// all descendant `<paper-tab>` elements have their `noink` property
  /// changed to the new value as well.
  bool get noink => jsElement[r'noink'];
  set noink(bool value) { jsElement[r'noink'] = value; }

  /// If true, tabs are scrollable and the tab width is based on the label width.
  bool get scrollable => jsElement[r'scrollable'];
  set scrollable(bool value) { jsElement[r'scrollable'] = value; }

  String get selectable => jsElement[r'selectable'];
  set selectable(String value) { jsElement[r'selectable'] = value; }
}
