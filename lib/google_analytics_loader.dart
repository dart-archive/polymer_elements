// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_analytics_loader`.
@HtmlImport('google_analytics_loader_nodart.html')
library polymer_elements.lib.src.google_analytics.google_analytics_loader;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'google_signin_aware.dart';
import 'google_client_loader.dart';

/// google-analytics-loader is used internally by elements that need to know api state, and user state.
///
/// Loads gapi.client.analytics, and watches user signed-in state.
@CustomElementProxy('google-analytics-loader')
class GoogleAnalyticsLoader extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleAnalyticsLoader.created() : super.created();
  factory GoogleAnalyticsLoader() => new Element.tag('google-analytics-loader');

  /// True when user is authorized, and api is loaded
  bool get allReady => jsElement[r'allReady'];
  set allReady(bool value) { jsElement[r'allReady'] = value; }

  /// True when api is loaded
  bool get apiReady => jsElement[r'apiReady'];
  set apiReady(bool value) { jsElement[r'apiReady'] = value; }

  /// True when user is authorized
  bool get authorized => jsElement[r'authorized'];
  set authorized(bool value) { jsElement[r'authorized'] = value; }

  computeAllReady(apiReady, authorized) =>
      jsElement.callMethod('computeAllReady', [apiReady, authorized]);

  handleApiFailedToLoad(ev, detail) =>
      jsElement.callMethod('handleApiFailedToLoad', [ev, detail]);

  handleApiLoad() =>
      jsElement.callMethod('handleApiLoad', []);

  handleAuthSignout() =>
      jsElement.callMethod('handleAuthSignout', []);

  handleAuthSuccess() =>
      jsElement.callMethod('handleAuthSuccess', []);
}
