// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_client_loader`.
@HtmlImport('google_client_loader_nodart.html')
library polymer_elements.lib.src.google_apis.google_client_loader;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'google_js_api.dart';

/// Element for loading a specific client Google API with the JavaScript client library.
///
/// For loading `gapi.client` libraries
///
/// ##### Example
///
///     <google-client-loader id="shortener"
///       name="urlshortener"
///       version="v1"></google-client-loader>
///
///     <script>
///       var shortener = document.getElementById('shortener');
///       shortener.addEventListener('google-api-load', function(event) {
///         var request = shortener.api.url.get({
///            shortUrl: 'http://goo.gl/fbsS'
///         });
///         request.execute(function(resp) {
///           console.log(resp);
///         });
///       });
///     </script>
@CustomElementProxy('google-client-loader')
class GoogleClientLoader extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleClientLoader.created() : super.created();
  factory GoogleClientLoader() => new Element.tag('google-client-loader');

  /// Returns the loaded API.
  get api => jsElement[r'api'];

  /// Root URL where to load the API from, e.g. 'http://host/apis'.
  /// For App Engine dev server this would be something like:
  /// 'http://localhost:8080/_ah/api'.
  /// Overrides 'appId' if both are specified.
  String get apiRoot => jsElement[r'apiRoot'];
  set apiRoot(String value) { jsElement[r'apiRoot'] = value; }

  /// App Engine application ID for loading a Google Cloud Endpoints API.
  String get appId => jsElement[r'appId'];
  set appId(String value) { jsElement[r'appId'] = value; }

  /// Wrapper for `gapi.auth`.
  get auth => jsElement[r'auth'];

  /// Name of the event fired when there is an error loading the library.
  String get errorEventName => jsElement[r'errorEventName'];
  set errorEventName(String value) { jsElement[r'errorEventName'] = value; }

  /// Name of the API to load, e.g. 'urlshortener'.
  ///
  /// You can find the full list of APIs on the
  /// <a href="https://developers.google.com/apis-explorer"> Google APIs
  /// Explorer</a>.
  String get name => jsElement[r'name'];
  set name(String value) { jsElement[r'name'] = value; }

  /// Name of the event fired when API library is loaded.
  String get successEventName => jsElement[r'successEventName'];
  set successEventName(String value) { jsElement[r'successEventName'] = value; }

  /// Version of the API to load, e.g. 'v1'.
  String get version => jsElement[r'version'];
  set version(String value) { jsElement[r'version'] = value; }
}
