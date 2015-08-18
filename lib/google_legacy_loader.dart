// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_legacy_loader`.
@HtmlImport('google_legacy_loader_nodart.html')
library polymer_elements.lib.src.google_apis.google_legacy_loader;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_jsonp_library.dart';

/// Dynamically loads the legacy Google JavaScript API Loader (https://developers.google.com/loader/).
///
/// Fires `api-load` event when ready.
@CustomElementProxy('google-legacy-loader')
class GoogleLegacyLoader extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronJsonpLibraryBehavior {
  GoogleLegacyLoader.created() : super.created();
  factory GoogleLegacyLoader() => new Element.tag('google-legacy-loader');

  /// Wrapper for `google` API namespace.
  get api => jsElement[r'api'];

  /// Name of event fired when library is loaded and available.
  String get notifyEvent => jsElement[r'notifyEvent'];
  set notifyEvent(String value) { jsElement[r'notifyEvent'] = value; }

  String get libraryUrl => jsElement[r'libraryUrl'];
  set libraryUrl(String value) { jsElement[r'libraryUrl'] = value; }
}
