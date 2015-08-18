// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_plusone_api`.
@HtmlImport('google_plusone_api_nodart.html')
library polymer_elements.lib.src.google_apis.google_plusone_api;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_jsonp_library.dart';

/// Dynamically loads the Google+ JavaScript API, firing the `api-load` event when ready.
///
/// Any number of components can use `<google-plusone-api>` elements, and the library will only be loaded once.
@CustomElementProxy('google-plusone-api')
class GooglePlusoneApi extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronJsonpLibraryBehavior {
  GooglePlusoneApi.created() : super.created();
  factory GooglePlusoneApi() => new Element.tag('google-plusone-api');

  get api => jsElement[r'api'];

  /// Name of event fired when library is loaded and available.
  String get notifyEvent => jsElement[r'notifyEvent'];
  set notifyEvent(String value) { jsElement[r'notifyEvent'] = value; }

  String get libraryUrl => jsElement[r'libraryUrl'];
  set libraryUrl(String value) { jsElement[r'libraryUrl'] = value; }
}
