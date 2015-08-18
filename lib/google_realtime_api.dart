// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_realtime_api`.
@HtmlImport('google_realtime_api_nodart.html')
library polymer_elements.lib.src.google_apis.google_realtime_api;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_jsonp_library.dart';

/// Dynamically loads the Google Drive Realtime API, firing the `api-load` event when ready.
///
/// Any number of components can use `<google-realtime-api>` elements, and the library will only be loaded once.
@CustomElementProxy('google-realtime-api')
class GoogleRealtimeApi extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronJsonpLibraryBehavior {
  GoogleRealtimeApi.created() : super.created();
  factory GoogleRealtimeApi() => new Element.tag('google-realtime-api');

  /// Returns `gapi.drive.realtime`
  get api => jsElement[r'api'];

  /// Name of event fired when library is loaded and available.
  String get notifyEvent => jsElement[r'notifyEvent'];
  set notifyEvent(String value) { jsElement[r'notifyEvent'] = value; }

  String get libraryUrl => jsElement[r'libraryUrl'];
  set libraryUrl(String value) { jsElement[r'libraryUrl'] = value; }
}
