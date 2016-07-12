// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_dropdown_menu`.
@HtmlImport('paper_dropdown_menu_nodart.html')
library polymer_elements.lib.src.paper_dropdown_menu.paper_dropdown_menu;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_button_state.dart';
import 'iron_a11y_keys_behavior.dart';
import 'iron_control_state.dart';
import 'iron_form_element_behavior.dart';
import 'iron_validatable_behavior.dart';
import 'iron_icon.dart';
import 'paper_input.dart';
import 'paper_menu_button.dart';
import 'paper_ripple.dart';
import 'default_theme.dart';
import 'paper_dropdown_menu_icons.dart';
import 'paper_dropdown_menu_shared_styles.dart';

/// Material design: [Dropdown menus](https://www.google.com/design/spec/components/buttons.html#buttons-dropdown-buttons)
///
/// `paper-dropdown-menu` is similar to a native browser select element.
/// `paper-dropdown-menu` works with selectable content. The currently selected
/// item is displayed in the control. If no item is selected, the `label` is
/// displayed instead.
///
/// Example:
///
///     <paper-dropdown-menu label="Your favourite pastry">
///       <paper-listbox class="dropdown-content">
///         <paper-item>Croissant</paper-item>
///         <paper-item>Donut</paper-item>
///         <paper-item>Financier</paper-item>
///         <paper-item>Madeleine</paper-item>
///       </paper-listbox>
///     </paper-dropdown-menu>
///
/// This example renders a dropdown menu with 4 options.
///
/// The child element with the class `dropdown-content` is used as the dropdown
/// menu. This can be a [`paper-listbox`](paper-listbox), or any other or
/// element that acts like an [`iron-selector`](iron-selector).
///
/// Specifically, the menu child must fire an
/// [`iron-select`](iron-selector#event-iron-select) event when one of its
/// children is selected, and an [`iron-deselect`](iron-selector#event-iron-deselect)
/// event when a child is deselected. The selected or deselected item must
/// be passed as the event's `detail.item` property.
///
/// Applications can listen for the `iron-select` and `iron-deselect` events
/// to react when options are selected and deselected.
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
class PaperDropdownMenu extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronA11yKeysBehavior, IronButtonState, IronControlState, IronFormElementBehavior, IronValidatableBehavior {
  PaperDropdownMenu.created() : super.created();
  factory PaperDropdownMenu() => new Element.tag('paper-dropdown-menu');

  /// Set to true to always float the label. Bind this to the
  /// `<paper-input-container>`'s `alwaysFloatLabel` property.
  bool get alwaysFloatLabel => jsElement[r'alwaysFloatLabel'];
  set alwaysFloatLabel(bool value) { jsElement[r'alwaysFloatLabel'] = value; }

  /// The content element that is contained by the dropdown menu, if any.
  get contentElement => jsElement[r'contentElement'];

  /// The error message to display when invalid.
  String get errorMessage => jsElement[r'errorMessage'];
  set errorMessage(String value) { jsElement[r'errorMessage'] = value; }

  /// The orientation against which to align the menu dropdown
  /// horizontally relative to the dropdown trigger.
  String get horizontalAlign => jsElement[r'horizontalAlign'];
  set horizontalAlign(String value) { jsElement[r'horizontalAlign'] = value; }

  get keyBindings => jsElement[r'keyBindings'];
  set keyBindings(value) { jsElement[r'keyBindings'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

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
  /// `iron-select` event with the selected `item` in the `detail`.
  get selectedItem => jsElement[r'selectedItem'];
  set selectedItem(value) { jsElement[r'selectedItem'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The derived "label" of the currently selected item. This value
  /// is the `label` property on the selected item if set, or else the
  /// trimmed text content of the selected item.
  String get selectedItemLabel => jsElement[r'selectedItemLabel'];
  set selectedItemLabel(String value) { jsElement[r'selectedItemLabel'] = value; }

  /// The value for this element that will be used when submitting in
  /// a form. It is read only, and will always have the same value
  /// as `selectedItemLabel`.
  String get value => jsElement[r'value'];
  set value(String value) { jsElement[r'value'] = value; }

  /// The orientation against which to align the menu dropdown
  /// vertically relative to the dropdown trigger.
  String get verticalAlign => jsElement[r'verticalAlign'];
  set verticalAlign(String value) { jsElement[r'verticalAlign'] = value; }

  /// Hide the dropdown content.
  close() =>
      jsElement.callMethod('close', []);

  /// Show the dropdown content.
  open() =>
      jsElement.callMethod('open', []);
}
