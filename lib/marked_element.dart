// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `marked_element`.
@HtmlImport('marked_element_nodart.html')
library polymer_elements.lib.src.marked_element.marked_element;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// Element wrapper for the [marked](https://github.com/chjj/marked) library.
///
/// `<marked-element>` accepts Markdown source, and renders it to a child
/// element with the class `markdown-html`. This child element can be styled
/// as you would a normal DOM element. If you do not provide a child element
/// with the `markdown-html` class, the Markdown source will still be rendered,
/// but to a shadow DOM child that cannot be styled.
///
/// The Markdown source can be specified either via the `markdown` attribute:
///
///     <marked-element markdown="`Markdown` is _awesome_!">
///       <div class="markdown-html"></div>
///     </marked-element>
///
/// Or, you can provide it via a `<script type="text/markdown">` element child:
///
///     <marked-element>
///       <div class="markdown-html"></div>
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
///
/// ### Styling
/// If you are using a child with the `markdown-html` class, you can style it
/// as you would a regular DOM element:
///
///     .markdown-html p {
///       color: red;
///     }
///
///     .markdown-html td:first-child {
///       padding-left: 24px;
///     }
@CustomElementProxy('marked-element')
class MarkedElement extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  MarkedElement.created() : super.created();
  factory MarkedElement() => new Element.tag('marked-element');

  /// The markdown source that should be rendered by this element.
  String get markdown => jsElement[r'markdown'];
  set markdown(String value) { jsElement[r'markdown'] = value; }

  get outputElement => jsElement[r'outputElement'];

  /// Conform to obscure parts of markdown.pl as much as possible. Don't fix any of the original markdown bugs or poor behavior.
  bool get pedantic => jsElement[r'pedantic'];
  set pedantic(bool value) { jsElement[r'pedantic'] = value; }

  /// Sanitize the output. Ignore any HTML that has been input.
  bool get sanitize => jsElement[r'sanitize'];
  set sanitize(bool value) { jsElement[r'sanitize'] = value; }

  /// Use "smart" typographic punctuation for things like quotes and dashes.
  bool get smartypants => jsElement[r'smartypants'];
  set smartypants(bool value) { jsElement[r'smartypants'] = value; }

  /// Renders `markdown` into this element's DOM.
  ///
  /// This is automatically called whenever the `markdown` property is changed.
  ///
  /// The only case where you should be calling this is if you are providing
  /// markdown via `<script type="text/markdown">` after this element has been
  /// constructed (or updating that markdown).
  render() =>
      jsElement.callMethod('render', []);

  /// Unindents the markdown source that will be rendered.
  unindent(text) =>
      jsElement.callMethod('unindent', [text]);
}
