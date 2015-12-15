// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_listbox`.
@HtmlImport('paper_listbox_nodart.html')
library polymer_elements.lib.src.paper_listbox.paper_listbox;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_menu_behavior.dart';
import 'iron_multi_selectable.dart';
import 'iron_selectable.dart';
import 'iron_a11y_keys_behavior.dart';
import 'default_theme.dart';

/// Material design: [Menus](https://www.google.com/design/spec/components/menus.html)
///
/// `<paper-listbox>` implements an accessible listbox control with Material Design styling. The focused item
/// is highlighted, and the selected item has bolded text.
///
///     <paper-listbox>
///       <paper-item>Item 1</paper-item>
///       <paper-item>Item 2</paper-item>
///     </paper-listbox>
///
/// An initial selection can be specified with the `selected` attribute.
///
///     <paper-listbox selected="0">
///       <paper-item>Item 1</paper-item>
///       <paper-item>Item 2</paper-item>
///     </paper-listbox>
///
/// Make a multi-select listbox with the `multi` attribute. Items in a multi-select listbox can be deselected,
/// and multiple item can be selected.
///
///     <paper-listbox multi>
///       <paper-item>Item 1</paper-item>
///       <paper-item>Item 2</paper-item>
///     </paper-listbox>
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-listbox-background-color`   | Menu background color                                            | `--primary-background-color`
/// `--paper-listbox-color`              | Menu foreground color                                            | `--primary-text-color`
/// `--paper-listbox`                    | Mixin applied to the listbox                                        | `{}`
///
/// ### Accessibility
///
/// `<paper-listbox>` has `role="listbox"` by default. A multi-select listbox will also have
/// `aria-multiselectable` set. It implements key bindings to navigate through the listbox with the up and
/// down arrow keys, esc to exit the listbox, and enter to activate a listbox item. Typing the first letter
/// of a listbox item will also focus it.
@CustomElementProxy('paper-listbox')
class PaperListbox extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronSelectableBehavior, IronMultiSelectableBehavior, IronA11yKeysBehavior, IronMenuBehavior {
  PaperListbox.created() : super.created();
  factory PaperListbox() => new Element.tag('paper-listbox');
}
