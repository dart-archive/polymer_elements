// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_youtube_api`.
@HtmlImport('google_youtube_api_nodart.html')
library polymer_elements.lib.src.google_apis.google_youtube_api;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_jsonp_library.dart';

/// Dynamically loads the Google Youtube Iframe API, firing the `api-load` event when ready.
///
/// Any number of components can use `<google-youtube-api>` elements, and the library will only be loaded once.
///
/// https://developers.google.com/youtube/iframe_api_reference
@CustomElementProxy('google-youtube-api')
class GoogleYoutubeApi extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronJsonpLibraryBehavior {
  GoogleYoutubeApi.created() : super.created();
  factory GoogleYoutubeApi() => new Element.tag('google-youtube-api');

  get api => jsElement[r'api'];

  String get callbackName => jsElement[r'callbackName'];
  set callbackName(String value) { jsElement[r'callbackName'] = value; }

  /// Name of event fired when library loads.
  String get notifyEvent => jsElement[r'notifyEvent'];
  set notifyEvent(String value) { jsElement[r'notifyEvent'] = value; }

  String get libraryUrl => jsElement[r'libraryUrl'];
  set libraryUrl(String value) { jsElement[r'libraryUrl'] = value; }
}
