// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `prism_highlighter`.
@HtmlImport('prism_highlighter_nodart.html')
library polymer_elements.lib.src.prism_element.prism_highlighter;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// Syntax highlighting via [Prism](http://prismjs.com/).
///
/// Place a `<prism-highlighter>` in your document, preferably as a direct child of
/// `<body>`. It will listen for `syntax-highlight` events on its parent element,
/// and annotate the code being provided via that event.
///
/// The `syntax-highlight` event's detail is expected to have a `code` property
/// containing the source to highlight. The event detail can optionally contain a
/// `lang` property, containing a string like `"html"`, `"js"`, etc.
///
/// This flow is supported by [`<marked-element>`](https://github.com/PolymerElements/marked-element).
@CustomElementProxy('prism-highlighter')
class PrismHighlighter extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  PrismHighlighter.created() : super.created();
  factory PrismHighlighter() => new Element.tag('prism-highlighter');
}
