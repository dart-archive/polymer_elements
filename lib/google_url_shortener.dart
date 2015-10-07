// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_url_shortener`.
@HtmlImport('google_url_shortener_nodart.html')
library polymer_elements.lib.src.google_url_shortener.google_url_shortener;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'google_client_loader.dart';

/// `google-url-shortener` is a web component that shortens URLs with the
/// <a href="https://developers.google.com/url-shortener/">Google URL Shortener API
/// </a>.
///
/// ##### Example
///
///     <google-url-shortener id="shortener"></google-url-shortener>
///
///     <script>
///       var shortener = document.getElementById('shortener');
///
///       shortener.addEventListener('google-url-shorten', function(event) {
///         console.log(event.detail.shortUrl);
///       });
///
///       // Shorten the current page URL.
///       shortener.longUrl = document.URL;
///       shortener.shorten();
///     </script>
///
/// ##### Example using `auto` and binding.
///
///     <google-url-shortener id="shortener" longUrl="{{longUrl}}" auto>
///     </google-url-shortener>
///
///     <script>
///       var shortener = document.getElementById('shortener');
///
///       shortener.addEventListener('google-url-shorten', function(event) {
///         // This will be called automatically every time `longUrl` changes.
///         console.log(event.detail.shortUrl);
///       });
///     </script>
@CustomElementProxy('google-url-shortener')
class GoogleUrlShortener extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleUrlShortener.created() : super.created();
  factory GoogleUrlShortener() => new Element.tag('google-url-shortener');

  /// If true, automatically performs the shortening request when `longUrl`
  /// changes.
  bool get auto => jsElement[r'auto'];
  set auto(bool value) { jsElement[r'auto'] = value; }

  /// Error when url was shortened
  String get error => jsElement[r'error'];
  set error(String value) { jsElement[r'error'] = value; }

  /// The URL to be shortened.
  String get longUrl => jsElement[r'longUrl'];
  set longUrl(String value) { jsElement[r'longUrl'] = value; }

  /// Shortened URL
  String get shortUrl => jsElement[r'shortUrl'];
  set shortUrl(String value) { jsElement[r'shortUrl'] = value; }

  /// Shortens the URL in `longUrl`. Use if `auto` is not set.
  shorten() =>
      jsElement.callMethod('shorten', []);
}
