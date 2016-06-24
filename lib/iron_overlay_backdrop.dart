// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_overlay_backdrop`.
@HtmlImport('iron_overlay_backdrop_nodart.html')
library polymer_elements.lib.src.iron_overlay_behavior.iron_overlay_backdrop;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// `iron-overlay-backdrop` is a backdrop used by `Polymer.IronOverlayBehavior`. It should be a
/// singleton.
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling.
///
/// Custom property | Description | Default
/// -------------------------------------------|------------------------|---------
/// `--iron-overlay-backdrop-background-color` | Backdrop background color                                     | #000
/// `--iron-overlay-backdrop-opacity`          | Backdrop opacity                                              | 0.6
/// `--iron-overlay-backdrop`                  | Mixin applied to `iron-overlay-backdrop`.                      | {}
/// `--iron-overlay-backdrop-opened`           | Mixin applied to `iron-overlay-backdrop` when it is displayed | {}
@CustomElementProxy('iron-overlay-backdrop')
class IronOverlayBackdrop extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronOverlayBackdrop.created() : super.created();
  factory IronOverlayBackdrop() => new Element.tag('iron-overlay-backdrop');

  /// Returns true if the backdrop is opened.
  bool get opened => jsElement[r'opened'];
  set opened(bool value) { jsElement[r'opened'] = value; }

  /// Hides the backdrop.
  close() =>
      jsElement.callMethod('close', []);

  /// Removes the backdrop from document body if needed.
  complete() =>
      jsElement.callMethod('complete', []);

  /// Shows the backdrop.
  open() =>
      jsElement.callMethod('open', []);

  /// Appends the backdrop to document body if needed.
  prepare() =>
      jsElement.callMethod('prepare', []);
}
