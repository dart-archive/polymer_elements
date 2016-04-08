// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_spinner_lite`.
@HtmlImport('paper_spinner_lite_nodart.html')
library polymer_elements.lib.src.paper_spinner.paper_spinner_lite;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'paper_spinner_behavior.dart';
import 'iron_flex_layout.dart';
import 'color.dart';
import 'paper_spinner_styles.dart';

/// Material design: [Progress & activity](https://www.google.com/design/spec/components/progress-activity.html)
///
/// Element providing a single color material design circular spinner.
///
///     <paper-spinner-lite active></paper-spinner-lite>
///
/// The default spinner is blue. It can be customized to be a different color.
///
/// ### Accessibility
///
/// Alt attribute should be set to provide adequate context for accessibility. If not provided,
/// it defaults to 'loading'.
/// Empty alt can be provided to mark the element as decorative if alternative content is provided
/// in another form (e.g. a text block following the spinner).
///
///     <paper-spinner-lite alt="Loading contacts list" active></paper-spinner-lite>
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-spinner-color` | Color of the spinner | `--google-blue-500`
/// `--paper-spinner-stroke-width` | The width of the spinner stroke | 3px
@CustomElementProxy('paper-spinner-lite')
class PaperSpinnerLite extends HtmlElement with CustomElementProxyMixin, PolymerBase, PaperSpinnerBehavior {
  PaperSpinnerLite.created() : super.created();
  factory PaperSpinnerLite() => new Element.tag('paper-spinner-lite');
}
