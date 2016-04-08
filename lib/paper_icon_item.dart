// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_icon_item`.
@HtmlImport('paper_icon_item_nodart.html')
library polymer_elements.lib.src.paper_item.paper_icon_item;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'paper_item_behavior.dart';
import 'iron_button_state.dart';
import 'iron_a11y_keys_behavior.dart';
import 'iron_control_state.dart';
import 'iron_flex_layout.dart';
import 'typography.dart';
import 'paper_item_shared_styles.dart';

/// `<paper-icon-item>` is a convenience element to make an item with icon. It is an interactive list
/// item with a fixed-width icon area, according to Material Design. This is useful if the icons are of
/// varying widths, but you want the item bodies to line up. Use this like a `<paper-item>`. The child
/// node with the attribute `item-icon` is placed in the icon area.
///
///     <paper-icon-item>
///       <iron-icon icon="favorite" item-icon></iron-icon>
///       Favorite
///     </paper-icon-item>
///     <paper-icon-item>
///       <div class="avatar" item-icon></div>
///       Avatar
///     </paper-icon-item>
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property               | Description                                    | Default
/// ------------------------------|------------------------------------------------|----------
/// `--paper-item-icon-width`     | Width of the icon area                         | `56px`
/// `--paper-item-icon`           | Mixin applied to the icon area                 | `{}`
/// `--paper-icon-item`           | Mixin applied to the item                      | `{}`
/// `--paper-item-selected-weight`| The font weight of a selected item             | `bold`
/// `--paper-item-selected`       | Mixin applied to selected paper-items                | `{}`
/// `--paper-item-disabled-color` | The color for disabled paper-items             | `--disabled-text-color`
/// `--paper-item-disabled`       | Mixin applied to disabled paper-items        | `{}`
/// `--paper-item-focused`        | Mixin applied to focused paper-items         | `{}`
/// `--paper-item-focused-before` | Mixin applied to :before focused paper-items | `{}`
@CustomElementProxy('paper-icon-item')
class PaperIconItem extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronA11yKeysBehavior, IronButtonState, IronControlState, PaperItemBehavior {
  PaperIconItem.created() : super.created();
  factory PaperIconItem() => new Element.tag('paper-icon-item');
}
