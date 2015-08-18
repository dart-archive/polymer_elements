// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_button`.
@HtmlImport('paper_button_nodart.html')
library polymer_elements.lib.src.paper_button.paper_button;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'paper_button_behavior.dart';
import 'iron_button_state.dart';
import 'iron_control_state.dart';
import 'paper_material.dart';
import 'paper_ripple.dart';

/// Material Design: <a href="http://www.google.com/design/spec/components/buttons.html">Buttons</a>
///
/// `paper-button` is a button. When the user touches the button, a ripple effect emanates
/// from the point of contact. It may be flat or raised. A raised button is styled with a
/// shadow.
///
/// Example:
///
///     <paper-button>flat button</paper-button>
///     <paper-button raised>raised button</paper-button>
///     <paper-button noink>No ripple effect</paper-button>
///     <paper-button toggles>toggle-able button</paper-button>
///
/// A button that has `toggles` true will remain `active` after being clicked (and
/// will have an `active` attribute set). For more information, see the `Polymer.IronButtonState`
/// behavior.
///
/// You may use custom DOM in the button body to create a variety of buttons. For example, to
/// create a button with an icon and some text:
///
///     <paper-button>
///       <iron-icon icon="favorite"></iron-icon>
///       custom button content
///     </paper-button>
///
/// ### Styling
///
/// Style the button with CSS as you would a normal DOM element.
///
///     /* make #my-button green with yellow text */
///     #my-button {
///         background: green;
///         color: yellow;
///     }
///
/// By default, the ripple is the same color as the foreground at 25% opacity. You may
/// customize the color using this selector:
///
///     /* make #my-button use a blue ripple instead of foreground color */
///     #my-button::shadow paper-ripple {
///       color: blue;
///     }
///
/// The opacity of the ripple is not customizable via CSS.
///
/// The following custom properties and mixins are also available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-button-flat-focus-color` | Background color of a focused flat button | `--paper-grey-200`
/// `--paper-button` | Mixin applied to the button | `{}`
/// `--paper-button-disabled` | Mixin applied to the disabled button | `{}`
@CustomElementProxy('paper-button')
class PaperButton extends HtmlElement with CustomElementProxyMixin, PolymerBase, PaperButtonBehavior, IronButtonState, IronControlState, PaperButtonBehaviorImpl {
  PaperButton.created() : super.created();
  factory PaperButton() => new Element.tag('paper-button');

  /// If true, the button should be styled with a shadow.
  bool get raised => jsElement[r'raised'];
  set raised(bool value) { jsElement[r'raised'] = value; }
}
