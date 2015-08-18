// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `marked_element`.
@HtmlImport('marked_element_nodart.html')
library polymer_elements.lib.src.marked_element.marked_element;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// Element wrapper for the [marked](http://marked.org/) library.
///
/// `<marked-element>` accepts Markdown source either via its `markdown` attribute:
///
///     <marked-element markdown="`Markdown` is _awesome_!"></marked-element>
///
/// Or, you can provide it via a `<script type="text/markdown">` element child:
///
///     <marked-element>
///       <script type="text/markdown">
///         Check out my markdown!
///
///         We can even embed elements without fear of the HTML parser mucking up their
///         textual representation:
///
///         ```html
///         <awesome-sauce>
///           <div>Oops, I'm about to forget to close this div.
///         </awesome-sauce>
///         ```
///       </script>
///     </marked-element>
///
/// Note that the `<script type="text/markdown">` approach is _static_. Changes to
/// the script content will _not_ update the rendered markdown!
@CustomElementProxy('marked-element')
class MarkedElement extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  MarkedElement.created() : super.created();
  factory MarkedElement() => new Element.tag('marked-element');

  /// The markdown source that should be rendered by this element.
  String get markdown => jsElement[r'markdown'];
  set markdown(String value) { jsElement[r'markdown'] = value; }

  /// Renders `markdown` into this element's DOM.
  ///
  /// This is automatically called whenever the `markdown` property is changed.
  ///
  /// The only case where you should be calling this is if you are providing
  /// markdown via `<script type="text/markdown">` after this element has been
  /// constructed (or updating that markdown).
  void render() =>
      jsElement.callMethod('render', []);
}
