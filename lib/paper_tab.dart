// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_tab`.
@HtmlImport('paper_tab_nodart.html')
library polymer_elements.lib.src.paper_tabs.paper_tab;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_control_state.dart';
import 'iron_flex_layout/classes/iron_flex_layout.dart';
import 'iron_flex_layout.dart';
import 'paper_ripple.dart';

/// `paper-tab` is styled to look like a tab.  It should be used in conjunction with
/// `paper-tabs`.
///
/// Example:
///
///     <paper-tabs selected="0">
///       <paper-tab>TAB 1</paper-tab>
///       <paper-tab>TAB 2</paper-tab>
///       <paper-tab>TAB 3</paper-tab>
///     </paper-tabs>
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-tab-ink` | Ink color | `--paper-yellow-a100`
/// `--paper-tab` | Mixin applied to the tab | `{}`
/// `--paper-tab-content` | Mixin applied to the tab content | `{}`
@CustomElementProxy('paper-tab')
class PaperTab extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronControlState {
  PaperTab.created() : super.created();
  factory PaperTab() => new Element.tag('paper-tab');

  /// If true, ink ripple effect is disabled.
  bool get noink => jsElement[r'noink'];
  set noink(bool value) { jsElement[r'noink'] = value; }
}
