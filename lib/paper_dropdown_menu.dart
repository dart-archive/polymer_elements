// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_dropdown_menu`.
@HtmlImport('paper_dropdown_menu_nodart.html')
library polymer_elements.lib.src.paper_dropdown_menu.paper_dropdown_menu;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_control_state.dart';
import 'iron_button_state.dart';
import 'iron_a11y_keys_behavior.dart';
import 'default_theme.dart';
import 'paper_input.dart';
import 'paper_menu_button.dart';
import 'paper_ripple.dart';
import 'iron_icons.dart';
import 'iron_icon.dart';
import 'iron_selectable.dart';

/// `paper-dropdown-menu` is similar to a native browser select element.
/// `paper-dropdown-menu` works with selectable content. The currently selected
/// item is displayed in the control. If no item is selected, the `label` is
/// displayed instead.
///
/// The child element with the class `dropdown-content` will be used as the dropdown
/// menu. It could be a `paper-menu` or element that triggers `iron-activate` when
/// selecting its children.
///
/// Example:
///
///     <paper-dropdown-menu label="Your favourite pastry">
///       <paper-menu class="dropdown-content">
///         <paper-item>Croissant</paper-item>
///         <paper-item>Donut</paper-item>
///         <paper-item>Financier</paper-item>
///         <paper-item>Madeleine</paper-item>
///       </paper-menu>
///     </paper-dropdown-menu>
///
/// This example renders a dropdown menu with 4 options.
///
/// ### Styling
///
/// The following custom properties and mixins are also available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-dropdown-menu` | A mixin that is applied to the element host | `{}`
/// `--paper-dropdown-menu-disabled` | A mixin that is applied to the element host when disabled | `{}`
/// `--paper-dropdown-menu-ripple` | A mixin that is applied to the internal ripple | `{}`
/// `--paper-dropdown-menu-button` | A mixin that is applied to the internal menu button | `{}`
/// `--paper-dropdown-menu-input` | A mixin that is applied to the internal paper input | `{}`
/// `--paper-dropdown-menu-icon` | A mixin that is applied to the internal icon | `{}`
///
/// You can also use any of the `paper-input-container` and `paper-menu-button`
/// style mixins and custom properties to style the internal input and menu button
/// respectively.
@CustomElementProxy('paper-dropdown-menu')
class PaperDropdownMenu extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronControlState, IronButtonState, IronA11yKeysBehavior {
  PaperDropdownMenu.created() : super.created();
  factory PaperDropdownMenu() => new Element.tag('paper-dropdown-menu');

  /// Set to true to always float the label. Bind this to the
  /// `<paper-input-container>`'s `alwaysFloatLabel` property.
  bool get alwaysFloatLabel => jsElement[r'alwaysFloatLabel'];
  set alwaysFloatLabel(bool value) { jsElement[r'alwaysFloatLabel'] = value; }

  get keyBindings => jsElement[r'keyBindings'];
  set keyBindings(value) { jsElement[r'keyBindings'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// The label for the dropdown.
  String get label => jsElement[r'label'];
  set label(String value) { jsElement[r'label'] = value; }

  /// Set to true to disable animations when opening and closing the
  /// dropdown.
  bool get noAnimations => jsElement[r'noAnimations'];
  set noAnimations(bool value) { jsElement[r'noAnimations'] = value; }

  /// Set to true to disable the floating label. Bind this to the
  /// `<paper-input-container>`'s `noLabelFloat` property.
  bool get noLabelFloat => jsElement[r'noLabelFloat'];
  set noLabelFloat(bool value) { jsElement[r'noLabelFloat'] = value; }

  /// True if the dropdown is open. Otherwise, false.
  bool get opened => jsElement[r'opened'];
  set opened(bool value) { jsElement[r'opened'] = value; }

  /// The placeholder for the dropdown.
  String get placeholder => jsElement[r'placeholder'];
  set placeholder(String value) { jsElement[r'placeholder'] = value; }

  /// The last selected item. An item is selected if the dropdown menu has
  /// a child with class `dropdown-content`, and that child triggers an
  /// `iron-activate` event with the selected `item` in the `detail`.
  get selectedItem => jsElement[r'selectedItem'];
  set selectedItem(value) { jsElement[r'selectedItem'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// The derived "label" of the currently selected item. This value
  /// is the `label` property on the selected item if set, or else the
  /// trimmed text content of the selected item.
  String get selectedItemLabel => jsElement[r'selectedItemLabel'];
  set selectedItemLabel(String value) { jsElement[r'selectedItemLabel'] = value; }

  /// Hide the dropdown content.
  void close() =>
      jsElement.callMethod('close', []);

  /// Show the dropdown content.
  void open() =>
      jsElement.callMethod('open', []);
}
