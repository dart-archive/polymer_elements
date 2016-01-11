// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_material`.
@HtmlImport('paper_material_nodart.html')
library polymer_elements.lib.src.paper_material.paper_material;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'shadow.dart';
import 'paper_material_shared_styles.dart';

/// Material design: [Cards](https://www.google.com/design/spec/components/cards.html)
///
/// `paper-material` is a container that renders two shadows on top of each other to
/// create the effect of a lifted piece of paper.
///
/// Example:
///
///     <paper-material elevation="1">
///       ... content ...
///     </paper-material>
@CustomElementProxy('paper-material')
class PaperMaterial extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  PaperMaterial.created() : super.created();
  factory PaperMaterial() => new Element.tag('paper-material');

  /// Set this to true to animate the shadow when setting a new
  /// `elevation` value.
  bool get animated => jsElement[r'animated'];
  set animated(bool value) { jsElement[r'animated'] = value; }

  /// The z-depth of this element, from 0-5. Setting to 0 will remove the
  /// shadow, and each increasing number greater than 0 will be "deeper"
  /// than the last.
  num get elevation => jsElement[r'elevation'];
  set elevation(num value) { jsElement[r'elevation'] = value; }
}
