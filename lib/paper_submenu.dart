// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_submenu`.
@HtmlImport('paper_submenu_nodart.html')
library polymer_elements.lib.src.paper_menu.paper_submenu;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_control_state.dart';
import 'iron_menu_behavior.dart';
import 'iron_collapse.dart';
import 'iron_flex_layout.dart';
import 'default_theme.dart';
import 'color.dart';
import 'paper_menu_shared_styles.dart';

/// `<paper-submenu>` is a nested menu inside of a parent `<paper-menu>`. It
/// consists of a trigger that expands or collapses another `<paper-menu>`:
///
///     <paper-menu>
///       <paper-submenu>
///         <paper-item class="menu-trigger">Topics</paper-item>
///         <paper-menu class="menu-content">
///           <paper-item>Topic 1</paper-item>
///           <paper-item>Topic 2</paper-item>
///           <paper-item>Topic 3</paper-item>
///         </paper-menu>
///       </paper-submenu>
///       <paper-submenu>
///         <paper-item class="menu-trigger">Faves</paper-item>
///         <paper-menu class="menu-content">
///           <paper-item>Fave 1</paper-item>
///           <paper-item>Fave 2</paper-item>
///         </paper-menu>
///       </paper-submenu>
///       <paper-submenu disabled>
///         <paper-item class="menu-trigger">Unavailable</paper-item>
///         <paper-menu class="menu-content">
///           <paper-item>Disabled 1</paper-item>
///           <paper-item>Disabled 2</paper-item>
///         </paper-menu>
///       </paper-submenu>
///     </paper-menu>
///
/// Just like in `<paper-menu>`, the focused item is highlighted, and the selected
/// item has bolded text. Please see the `<paper-menu>` docs for which attributes
/// (such as `multi` and `selected`), and styling options are available for the
/// `menu-content` menu.
@CustomElementProxy('paper-submenu')
class PaperSubmenu extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronControlState {
  PaperSubmenu.created() : super.created();
  factory PaperSubmenu() => new Element.tag('paper-submenu');

  /// Set opened to true to show the collapse element and to false to hide it.
  bool get opened => jsElement[r'opened'];
  set opened(bool value) { jsElement[r'opened'] = value; }

  /// Collapse the submenu content.
  close() =>
      jsElement.callMethod('close', []);

  dettached() =>
      jsElement.callMethod('dettached', []);

  /// Expand the submenu content.
  open() =>
      jsElement.callMethod('open', []);

  /// Toggle the submenu.
  toggle() =>
      jsElement.callMethod('toggle', []);
}
