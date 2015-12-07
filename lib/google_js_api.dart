// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_js_api`.
@HtmlImport('google_js_api_nodart.html')
library polymer_elements.lib.src.google_apis.google_js_api;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_jsonp_library.dart';

/// Dynamically loads Google JavaScript API `gapi`, firing the `js-api-load` event when ready.
///
/// Any number of components can use `<google-js-api>` elements, and the library will only be loaded once.
///
/// ##### Example
///
///     <google-js-api></google-js-api>
///     <script>
///       var api = document.querySelector('google-js-api');
///       api.addEventListener('js-api-load', function(e) {
///         console.log('API loaded', gapi);
///       });
///     </script>
@CustomElementProxy('google-js-api')
class GoogleJsApi extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronJsonpLibraryBehavior {
  GoogleJsApi.created() : super.created();
  factory GoogleJsApi() => new Element.tag('google-js-api');

  get api => jsElement[r'api'];

  /// Name of event fired when library is loaded and available.
  String get notifyEvent => jsElement[r'notifyEvent'];
  set notifyEvent(String value) { jsElement[r'notifyEvent'] = value; }

  String get libraryUrl => jsElement[r'libraryUrl'];
  set libraryUrl(String value) { jsElement[r'libraryUrl'] = value; }
}
