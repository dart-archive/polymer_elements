// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `platinum_sw_import_script`.
@HtmlImport('platinum_sw_import_script_nodart.html')
library polymer_elements.lib.src.platinum_sw.platinum_sw_import_script;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// The `<platinum-sw-import-script>` element is used to import a JavaScript file that is executed
/// each time the service worker starts up.
///
/// `<platinum-sw-import-script>` needs to be a child element of `<platinum-sw-register>`.
///
/// A common use case is to define a custom request handler for a `fetch` event, but it can be used
/// for any type of code that you want to be executed by the service worker.
///
///     <platinum-sw-register auto-register>
///       <platinum-sw-import-script href="custom-fetch-handler.js"></platinum-sw-import-script>
///       <platinum-sw-fetch handler="customFetchHandler"
///                          path="/(.*)/customFetch"></platinum-sw-fetch>
///     </platinum-sw-register>
///
/// You can specify multiple `<platinum-sw-import-script>` elements, each one corresponding to a
/// different JavaScript file. The JavaScript files will be loaded in the order in which the
/// `<platinum-sw-import-script>` elements appear. Under the hood, this results in an
/// [`importScripts()`](https://developer.mozilla.org/en-US/docs/Web/API/WorkerGlobalScope/importScripts)
/// call made from the context of the service worker.
@CustomElementProxy('platinum-sw-import-script')
class PlatinumSwImportScript extends HtmlElement with CustomElementProxyMixin, PolymerProxyMixin {
  PlatinumSwImportScript.created() : super.created();
  factory PlatinumSwImportScript() => new Element.tag('platinum-sw-import-script');

  /// The URL of the JavaScript file that you want imported.
  ///
  /// Relative URLs are assumed to be
  /// relative to the service worker's script location, which will almost always be the same
  /// location as the page which includes this element.
  String get href => jsElement[r'href'];
  set href(String value) { jsElement[r'href'] = value; }
}
