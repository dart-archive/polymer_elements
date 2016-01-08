// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_item_body`.
@HtmlImport('paper_item_body_nodart.html')
library polymer_elements.lib.src.paper_item.paper_item_body;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_flex_layout.dart';
import 'default_theme.dart';
import 'typography.dart';

/// Use `<paper-item-body>` in a `<paper-item>` or `<paper-icon-item>` to make two- or
/// three- line items. It is a flex item that is a vertical flexbox.
///
///     <paper-item>
///       <paper-item-body two-line>
///         <div>Show your status</div>
///         <div secondary>Your status is visible to everyone</div>
///       </paper-item-body>
///     </paper-item>
///
/// The child elements with the `secondary` attribute is given secondary text styling.
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-item-body-two-line-min-height`   | Minimum height of a two-line item          | `72px`
/// `--paper-item-body-three-line-min-height` | Minimum height of a three-line item        | `88px`
/// `--paper-item-body-secondary-color`       | Foreground color for the `secondary` area  | `--secondary-text-color`
/// `--paper-item-body-secondary`             | Mixin applied to the `secondary` area      | `{}`
@CustomElementProxy('paper-item-body')
class PaperItemBody extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  PaperItemBody.created() : super.created();
  factory PaperItemBody() => new Element.tag('paper-item-body');
}
