// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_maps_api`.
@HtmlImport('google_maps_api_nodart.html')
library polymer_elements.lib.src.google_apis.google_maps_api;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_jsonp_library.dart';

/// Dynamically loads the Google Maps JavaScript API, firing the `api-load` event when ready.
///
/// #### Example
///
///     <google-maps-api api-key="abc123" version="3.exp"></google-maps-api>
///     <script>
///       var mapsAPI = document.querySelector('google-maps-api');
///       mapsAPI.addEventListener('api-load', function(e) {
///         // this.api === google.maps
///       });
///     </script>
///
/// Any number of components can use `<google-maps-api>` elements, and the library will only be loaded once.
@CustomElementProxy('google-maps-api')
class GoogleMapsApi extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronJsonpLibraryBehavior {
  GoogleMapsApi.created() : super.created();
  factory GoogleMapsApi() => new Element.tag('google-maps-api');

  /// Provides the google.maps JS API namespace.
  get api => jsElement[r'api'];

  /// A Maps API key. To obtain an API key, see developers.google.com/maps/documentation/javascript/tutorial#api_key.
  String get apiKey => jsElement[r'apiKey'];
  set apiKey(String value) { jsElement[r'apiKey'] = value; }

  /// A Maps API for Business Client ID. To obtain a Maps API for Business Client ID, see developers.google.com/maps/documentation/business/.
  /// If set, a Client ID will take precedence over an API Key.
  String get clientId => jsElement[r'clientId'];
  set clientId(String value) { jsElement[r'clientId'] = value; }

  /// The localized language to load the Maps API with. For more information
  /// see https://developers.google.com/maps/documentation/javascript/basics#Language
  ///
  /// Note: the Maps API defaults to the preffered language setting of the browser.
  /// Use this parameter to override that behavior.
  String get language => jsElement[r'language'];
  set language(String value) { jsElement[r'language'] = value; }

  /// Name of event fired when library is loaded and available.
  String get notifyEvent => jsElement[r'notifyEvent'];
  set notifyEvent(String value) { jsElement[r'notifyEvent'] = value; }

  /// If true, sign-in is enabled.
  /// See https://developers.google.com/maps/documentation/javascript/signedin#enable_sign_in
  bool get signedIn => jsElement[r'signedIn'];
  set signedIn(bool value) { jsElement[r'signedIn'] = value; }

  /// Version of the Maps API to use.
  String get version => jsElement[r'version'];
  set version(String value) { jsElement[r'version'] = value; }

  String get libraryUrl => jsElement[r'libraryUrl'];
  set libraryUrl(String value) { jsElement[r'libraryUrl'] = value; }

  String get mapsUrl => jsElement[r'mapsUrl'];
  set mapsUrl(String value) { jsElement[r'mapsUrl'] = value; }
}
