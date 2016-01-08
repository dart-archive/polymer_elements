// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_doc_property`.
@HtmlImport('iron_doc_property_nodart.html')
library polymer_elements.lib.src.iron_doc_viewer.iron_doc_property;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'marked_element.dart';
import 'iron_doc_property_styles.dart';

/// Renders documentation describing a specific property of an element.
///
/// Give it a hydrolysis `PropertyDescriptor` (via `descriptor`), and watch it go!
@CustomElementProxy('iron-doc-property')
class IronDocProperty extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronDocProperty.created() : super.created();
  factory IronDocProperty() => new Element.tag('iron-doc-property');

  /// Unique anchor ID for deep-linking.
  String get anchorId => jsElement[r'anchorId'];
  set anchorId(String value) { jsElement[r'anchorId'] = value; }

  /// Whether the property should show a one-liner, or full summary.
  ///
  /// Note that this property _is_ reflected as an attribute, but we perform
  /// the reflection manually. In order to support the CSS transitions, we
  /// must calculate the element height before setting the attribute.
  bool get collapsed => jsElement[r'collapsed'];
  set collapsed(bool value) { jsElement[r'collapsed'] = value; }

  /// The [Hydrolysis](https://github.com/PolymerLabs/hydrolysis)-generated
  /// element descriptor to display details for.
  ///
  /// Alternatively, the element descriptor can be provided as JSON via the text content
  /// of this element.
  get descriptor => jsElement[r'descriptor'];
  set descriptor(value) { jsElement[r'descriptor'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}
}
