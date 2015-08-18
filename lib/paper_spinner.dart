// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_spinner`.
@HtmlImport('paper_spinner_nodart.html')
library polymer_elements.lib.src.paper_spinner.paper_spinner;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'color.dart';
import 'iron_flex_layout.dart';

/// Element providing material design circular spinner.
///
///     <paper-spinner active></paper-spinner>
///
/// The default spinner cycles between four layers of colors; by default they are
/// blue, red, yellow and green. It can be customized so that it uses one color only
/// by setting all the layer colors to the same value.
///
/// ### Accessibility
///
/// Alt attribute should be set to provide adequate context for accessibility. If not provided,
/// it defaults to 'loading'.
/// Empty alt can be provided to mark the element as decorative if alternative content is provided
/// in another form (e.g. a text block following the spinner).
///
///     <paper-spinner alt="Loading contacts list" active></paper-spinner>
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-spinner-layer-1-color` | Color of the first spinner rotation | `--google-blue-500`
/// `--paper-spinner-layer-2-color` | Color of the second spinner rotation | `--google-red-500`
/// `--paper-spinner-layer-3-color` | Color of the third spinner rotation | `--google-yellow-500`
/// `--paper-spinner-layer-4-color` | Color of the fourth spinner rotation | `--google-green-500`
@CustomElementProxy('paper-spinner')
class PaperSpinner extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  PaperSpinner.created() : super.created();
  factory PaperSpinner() => new Element.tag('paper-spinner');

  /// Displays the spinner.
  bool get active => jsElement[r'active'];
  set active(bool value) { jsElement[r'active'] = value; }

  /// Alternative text content for accessibility support.
  /// If alt is present, it will add an aria-label whose content matches alt when active.
  /// If alt is not present, it will default to 'loading' as the alt value.
  String get alt => jsElement[r'alt'];
  set alt(String value) { jsElement[r'alt'] = value; }

  void reset() =>
      jsElement.callMethod('reset', []);
}
