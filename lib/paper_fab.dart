// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_fab`.
@HtmlImport('paper_fab_nodart.html')
library polymer_elements.lib.src.paper_fab.paper_fab;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'paper_button_behavior.dart';
import 'iron_button_state.dart';
import 'iron_a11y_keys_behavior.dart';
import 'iron_control_state.dart';
import 'paper_ripple_behavior.dart';
import 'iron_flex_layout.dart';
import 'iron_icon.dart';
import 'paper_material_shared_styles.dart';
import 'color.dart';
import 'default_theme.dart';

/// Material design: [Floating Action Button](https://www.google.com/design/spec/components/buttons-floating-action-button.html)
///
/// `paper-fab` is a floating action button. It contains an image placed in the center and
/// comes in two sizes: regular size and a smaller size by applying the attribute `mini`. When
/// the user touches the button, a ripple effect emanates from the center of the button.
///
/// You may import `iron-icons` to use with this element, or provide a URL to a custom icon.
/// See `iron-iconset` for more information about how to use a custom icon set.
///
/// Example:
///
///     <link href="path/to/iron-icons/iron-icons.html" rel="import">
///
///     <paper-fab icon="add"></paper-fab>
///     <paper-fab mini icon="favorite"></paper-fab>
///     <paper-fab src="star.png"></paper-fab>
///
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-fab-background` | The background color of the button | `--accent-color`
/// `--paper-fab-keyboard-focus-background` | The background color of the button when focused | `--paper-pink-900`
/// `--paper-fab-disabled-background` | The background color of the button when it's disabled | `--paper-grey-300`
/// `--paper-fab-disabled-text` | The text color of the button when it's disabled | `--paper-grey-500`
/// `--paper-fab` | Mixin applied to the button | `{}`
/// `--paper-fab-mini` | Mixin applied to a mini button | `{}`
/// `--paper-fab-disabled` | Mixin applied to a disabled button | `{}`
/// `--paper-fab-iron-icon` | Mixin applied to the iron-icon within the button | `{}`
@CustomElementProxy('paper-fab')
class PaperFab extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronA11yKeysBehavior, IronButtonState, IronControlState, PaperRippleBehavior, PaperButtonBehavior {
  PaperFab.created() : super.created();
  factory PaperFab() => new Element.tag('paper-fab');

  /// Specifies the icon name or index in the set of icons available in
  /// the icon's icon set. If the icon property is specified,
  /// the src property should not be.
  String get icon => jsElement[r'icon'];
  set icon(String value) { jsElement[r'icon'] = value; }

  /// The label displayed in the badge. The label is centered, and ideally
  /// should have very few characters.
  String get label => jsElement[r'label'];
  set label(String value) { jsElement[r'label'] = value; }

  /// Set this to true to style this is a "mini" FAB.
  bool get mini => jsElement[r'mini'];
  set mini(bool value) { jsElement[r'mini'] = value; }

  /// The URL of an image for the icon. If the src property is specified,
  /// the icon property should not be.
  String get src => jsElement[r'src'];
  set src(String value) { jsElement[r'src'] = value; }
}
