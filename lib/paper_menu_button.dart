// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_menu_button`.
@HtmlImport('paper_menu_button_nodart.html')
library polymer_elements.lib.src.paper_menu_button.paper_menu_button;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_a11y_keys_behavior.dart';
import 'iron_control_state.dart';
import 'iron_dropdown.dart';
import 'neon_animation/animations/fade_in_animation.dart';
import 'neon_animation/animations/fade_out_animation.dart';
import 'default_theme.dart';
import 'shadow.dart';
import 'paper_menu_button_animations.dart';

/// Material design: [Dropdown buttons](https://www.google.com/design/spec/components/buttons.html#buttons-dropdown-buttons)
///
/// `paper-menu-button` allows one to compose a designated "trigger" element with
/// another element that represents "content", to create a dropdown menu that
/// displays the "content" when the "trigger" is clicked.
///
/// The child element with the class `dropdown-trigger` will be used as the
/// "trigger" element. The child element with the class `dropdown-content` will be
/// used as the "content" element.
///
/// The `paper-menu-button` is sensitive to its content's `iron-select` events. If
/// the "content" element triggers an `iron-select` event, the `paper-menu-button`
/// will close automatically.
///
/// Example:
///
///     <paper-menu-button>
///       <paper-icon-button icon="menu" class="dropdown-trigger"></paper-icon-button>
///       <paper-menu class="dropdown-content">
///         <paper-item>Share</paper-item>
///         <paper-item>Settings</paper-item>
///         <paper-item>Help</paper-item>
///       </paper-menu>
///     </paper-menu-button>
///
/// ### Styling
///
/// The following custom properties and mixins are also available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-menu-button-dropdown-background` | Background color of the paper-menu-button dropdown | `--primary-background-color`
/// `--paper-menu-button` | Mixin applied to the paper-menu-button | `{}`
/// `--paper-menu-button-disabled` | Mixin applied to the paper-menu-button when disabled | `{}`
/// `--paper-menu-button-dropdown` | Mixin applied to the paper-menu-button dropdown | `{}`
/// `--paper-menu-button-content` | Mixin applied to the paper-menu-button content | `{}`
@CustomElementProxy('paper-menu-button')
class PaperMenuButton extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronA11yKeysBehavior, IronControlState {
  PaperMenuButton.created() : super.created();
  factory PaperMenuButton() => new Element.tag('paper-menu-button');

  /// An animation config. If provided, this will be used to animate the
  /// closing of the dropdown.
  get closeAnimationConfig => jsElement[r'closeAnimationConfig'];
  set closeAnimationConfig(value) { jsElement[r'closeAnimationConfig'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The content element that is contained by the menu button, if any.
  get contentElement => jsElement[r'contentElement'];

  /// The orientation against which to align the menu dropdown
  /// horizontally relative to the dropdown trigger.
  String get horizontalAlign => jsElement[r'horizontalAlign'];
  set horizontalAlign(String value) { jsElement[r'horizontalAlign'] = value; }

  /// A pixel value that will be added to the position calculated for the
  /// given `horizontalAlign`. Use a negative value to offset to the
  /// left, or a positive value to offset to the right.
  num get horizontalOffset => jsElement[r'horizontalOffset'];
  set horizontalOffset(num value) { jsElement[r'horizontalOffset'] = value; }

  /// Set to true to disable automatically closing the dropdown after
  /// a selection has been made.
  bool get ignoreSelect => jsElement[r'ignoreSelect'];
  set ignoreSelect(bool value) { jsElement[r'ignoreSelect'] = value; }

  /// Set to true to disable animations when opening and closing the
  /// dropdown.
  bool get noAnimations => jsElement[r'noAnimations'];
  set noAnimations(bool value) { jsElement[r'noAnimations'] = value; }

  /// An animation config. If provided, this will be used to animate the
  /// opening of the dropdown.
  get openAnimationConfig => jsElement[r'openAnimationConfig'];
  set openAnimationConfig(value) { jsElement[r'openAnimationConfig'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// True if the content is currently displayed.
  bool get opened => jsElement[r'opened'];
  set opened(bool value) { jsElement[r'opened'] = value; }

  /// The orientation against which to align the menu dropdown
  /// vertically relative to the dropdown trigger.
  String get verticalAlign => jsElement[r'verticalAlign'];
  set verticalAlign(String value) { jsElement[r'verticalAlign'] = value; }

  /// A pixel value that will be added to the position calculated for the
  /// given `verticalAlign`. Use a negative value to offset towards the
  /// top, or a positive value to offset towards the bottom.
  num get verticalOffset => jsElement[r'verticalOffset'];
  set verticalOffset(num value) { jsElement[r'verticalOffset'] = value; }

  /// Hide the dropdown content.
  close() =>
      jsElement.callMethod('close', []);

  /// Make the dropdown content appear as an overlay positioned relative
  /// to the dropdown trigger.
  open() =>
      jsElement.callMethod('open', []);

  /// Toggles the drowpdown content between opened and closed.
  toggle() =>
      jsElement.callMethod('toggle', []);
}
