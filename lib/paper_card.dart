// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_card`.
@HtmlImport('paper_card_nodart.html')
library polymer_elements.lib.src.paper_card.paper_card;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_flex_layout.dart';
import 'iron_image.dart';
import 'paper_material.dart';
import 'default_theme.dart';

/// Material design: [Cards](https://www.google.com/design/spec/components/cards.html)
///
/// `paper-card` is a container with a drop shadow.
///
/// Example:
///
///     <paper-card heading="Card Title">
///       <div class="card-content">Some content</div>
///       <div class="card-actions">
///         <paper-button>Some action</paper-button>
///       </div>
///     </paper-card>
///
/// Example - top card image:
///
///     <paper-card heading="Card Title" image="/path/to/image.png">
///       ...
///     </paper-card>
///
/// ### Accessibility
///
/// By default, the `aria-label` will be set to the value of the `heading` attribute.
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-card-background-color` | The background color of the card | `--primary-background-color`
/// `--paper-card-header-color` | The color of the header text | `#000`
/// `--paper-card-header` | Mixin applied to the card header section | `{}`
/// `--paper-card-header-text` | Mixin applied to the title in the card header section | `{}`
/// `--paper-card-header-image` | Mixin applied to the image in the card header section | `{}`
/// `--paper-card-header-image-text` | Mixin applied to the text overlapping the image in the card header section | `{}`
/// `--paper-card-content` | Mixin applied to the card content section| `{}`
/// `--paper-card-actions` | Mixin applied to the card action section | `{}`
/// `--paper-card` | Mixin applied to the card | `{}`
@CustomElementProxy('paper-card')
class PaperCard extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  PaperCard.created() : super.created();
  factory PaperCard() => new Element.tag('paper-card');

  /// Read-only property used to pass down the `animatedShadow` value to
  /// the underlying paper-material style (since they have different names).
  bool get animated => jsElement[r'animated'];
  set animated(bool value) { jsElement[r'animated'] = value; }

  /// Set this to true to animate the card shadow when setting a new
  /// `z` value.
  bool get animatedShadow => jsElement[r'animatedShadow'];
  set animatedShadow(bool value) { jsElement[r'animatedShadow'] = value; }

  /// The z-depth of the card, from 0-5.
  num get elevation => jsElement[r'elevation'];
  set elevation(num value) { jsElement[r'elevation'] = value; }

  /// When `preloadImage` is true, setting `fadeImage` to true will cause the
  /// image to fade into place.
  bool get fadeImage => jsElement[r'fadeImage'];
  set fadeImage(bool value) { jsElement[r'fadeImage'] = value; }

  /// The title of the card.
  String get heading => jsElement[r'heading'];
  set heading(String value) { jsElement[r'heading'] = value; }

  /// The url of the title image of the card.
  String get image => jsElement[r'image'];
  set image(String value) { jsElement[r'image'] = value; }

  /// When `true`, any change to the image url property will cause the
  /// `placeholder` image to be shown until the image is fully rendered.
  bool get preloadImage => jsElement[r'preloadImage'];
  set preloadImage(bool value) { jsElement[r'preloadImage'] = value; }
}
