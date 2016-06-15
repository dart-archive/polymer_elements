// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_badge`.
@HtmlImport('paper_badge_nodart.html')
library polymer_elements.lib.src.paper_badge.paper_badge;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_resizable_behavior.dart';
import 'iron_icon.dart';
import 'iron_flex_layout.dart';
import 'default_theme.dart';
import 'typography.dart';

/// `<paper-badge>` is a circular text badge that is displayed on the top right
/// corner of an element, representing a status or a notification. It will badge
/// the anchor element specified in the `for` attribute, or, if that doesn't exist,
/// centered to the parent node containing it.
///
/// Badges can also contain an icon by adding the `icon` attribute and setting
/// it to the id of the desired icon. Please note that you should still set the
/// `label` attribute in order to keep the element accessible. Also note that you will need to import
/// the `iron-iconset` that includes the icons you want to use. See [iron-icon](../iron-icon)
/// for more information on how to import and use icon sets.
///
/// Example:
///
///     <div style="display:inline-block">
///       <span>Inbox</span>
///       <paper-badge label="3"></paper-badge>
///     </div>
///
///     <div>
///       <paper-button id="btn">Status</paper-button>
///       <paper-badge icon="favorite" for="btn" label="favorite icon"></paper-badge>
///     </div>
///
///     <div>
///       <paper-icon-button id="account-box" icon="account-box" alt="account-box"></paper-icon-button>
///       <paper-badge icon="social:mood" for="account-box" label="mood icon"></paper-badge>
///     </div>
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-badge-background` | The background color of the badge | `--accent-color`
/// `--paper-badge-opacity` | The opacity of the badge | `1.0`
/// `--paper-badge-text-color` | The color of the badge text | `white`
/// `--paper-badge-width` | The width of the badge circle | `20px`
/// `--paper-badge-height` | The height of the badge circle | `20px`
/// `--paper-badge-margin-left` | Optional spacing added to the left of the badge. | `0px`
/// `--paper-badge-margin-bottom` | Optional spacing added to the bottom of the badge. | `0px`
/// `--paper-badge` | Mixin applied to the badge | `{}`
@CustomElementProxy('paper-badge')
class PaperBadge extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronResizableBehavior {
  PaperBadge.created() : super.created();
  factory PaperBadge() => new Element.tag('paper-badge');

  /// The id of the element that the badge is anchored to. This element
  /// must be a sibling of the badge.
  String get forId => jsElement[r'for'];
  set forId(String value) { jsElement[r'for'] = value; }

  /// An iron-icon ID. When given, the badge content will use an
  /// `<iron-icon>` element displaying the given icon ID rather than the
  /// label text. However, the label text will still be used for
  /// accessibility purposes.
  String get icon => jsElement[r'icon'];
  set icon(String value) { jsElement[r'icon'] = value; }

  /// The label displayed in the badge. The label is centered, and ideally
  /// should have very few characters.
  String get label => jsElement[r'label'];
  set label(String value) { jsElement[r'label'] = value; }

  /// Returns the target element that this badge is anchored to. It is
  /// either the element given by the `for` attribute, or the immediate parent
  /// of the badge.
  get target => jsElement[r'target'];

  /// Repositions the badge relative to its anchor element. This is called
  /// automatically when the badge is attached or an `iron-resize` event is
  /// fired (for exmaple if the window has resized, or your target is a
  /// custom element that implements IronResizableBehavior).
  ///
  /// You should call this in all other cases when the achor's position
  /// might have changed (for example, if it's visibility has changed, or
  /// you've manually done a page re-layout).
  updatePosition() =>
      jsElement.callMethod('updatePosition', []);
}
