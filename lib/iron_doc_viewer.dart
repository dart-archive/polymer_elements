// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_doc_viewer`.
@HtmlImport('iron_doc_viewer_nodart.html')
library polymer_elements.lib.src.iron_doc_viewer.iron_doc_viewer;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'marked_element.dart';
import 'paper_styles.dart';
import 'paper_button.dart';
import 'prism_highlighter.dart';
import 'iron_doc_property.dart';

/// Renders documentation describing an element's API.
///
/// `iron-doc-viewer` renders element and behavior descriptions as extracted by
/// [Hydrolysis](https://github.com/PolymerLabs/hydrolysis). You can provide them
/// either via binding...
///
///     <iron-doc-viewer descriptor="{{elementDescriptor}}"></iron-doc-viewer>
///
/// ...or by placing the element descriptor in JSON as the text content of an
/// `iron-doc-viewer`:
///
///     <iron-doc-viewer>
///       {
///         "is": "awesome-sauce",
///         "properties": [
///           {"name": "isAwesome", "type": "boolean", "desc": "Is it awesome?"},
///         ]
///       }
///     </iron-doc-viewer>
///
/// However, be aware that due to current limitations in Polymer 0.8, _changes_ to
/// the text content will not be respected, only the initial value will be loaded.
/// If you wish to update the documented element, please set it via the `descriptor`
/// property.
@CustomElementProxy('iron-doc-viewer')
class IronDocViewer extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronDocViewer.created() : super.created();
  factory IronDocViewer() => new Element.tag('iron-doc-viewer');

  /// The [Hydrolysis](https://github.com/PolymerLabs/hydrolysis)-generated
  /// element descriptor to display details for.
  ///
  /// Alternatively, the element descriptor can be provided as JSON via the text content
  /// of this element.
  get descriptor => jsElement[r'descriptor'];
  set descriptor(value) { jsElement[r'descriptor'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}
}
