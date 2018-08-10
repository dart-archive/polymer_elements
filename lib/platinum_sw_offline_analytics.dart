// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `platinum_sw_offline_analytics`.
@HtmlImport('platinum_sw_offline_analytics_nodart.html')
library polymer_elements.lib.src.platinum_sw.platinum_sw_offline_analytics;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// The `<platinum-sw-offline-analytics>` element registers a service worker handler to
/// intercepts requests for Google Analytics pings.
///
/// If the HTTP GET for the ping is successful (because the browser is online), then everything
/// proceeds as it normally would. If the HTTP GET fails, the ping request is saved to IndexedDB, and each time the service worker
/// script starts up it will attempt to "replay" those saved ping requests, giving up after one day
/// has passed.
///
/// The [`qt`](https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters#qt)
/// URL parameter is automatically added to the replayed HTTP GET and set to the number of
/// milliseconds that has passed since the initial ping request was attempted, to ensure that the
/// original time attribution is correct.
///
/// `<platinum-sw-offline-analytics>` does not take care of setting up Google Analytics on your
/// page, and assumes that you have [properly configured](https://support.google.com/analytics/answer/1008080)
/// Google Analytics tracking code registered elsewhere on your page.
///
/// Since `<platinum-sw-offline-analytics>` is only useful if the page that is being tracked with
/// Google Analytics works offline, it's best used in conjunction with the `<platinum-sw-cache>`
/// element, which takes care of caching your site's resources and serving them while offline.
///
/// A basic configuration is
///
///     <platinum-sw-register auto-register>
///       <platinum-sw-offline-analytics></platinum-sw-offline-analytics>
///       <platinum-sw-cache></platinum-sw-cache>
///     </platinum-sw-register>
@CustomElementProxy('platinum-sw-offline-analytics')
class PlatinumSwOfflineAnalytics extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  PlatinumSwOfflineAnalytics.created() : super.created();
  factory PlatinumSwOfflineAnalytics() => new Element.tag('platinum-sw-offline-analytics');
}
