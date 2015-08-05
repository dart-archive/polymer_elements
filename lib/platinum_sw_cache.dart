// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `platinum_sw_cache`.
@HtmlImport('platinum_sw_cache_nodart.html')
library polymer_elements.lib.src.platinum_sw.platinum_sw_cache;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// The `<platinum-sw-cache>` element makes it easy to precache specific resources, perform runtime
/// caching, and serve your cached resources when a network is unavailable.
/// Under the hood, the [sw-toolbox](https://github.com/googlechrome/sw-toolbox) library is used
/// for all the caching and request handling logic.
/// `<platinum-sw-cache>` needs to be a child element of `<platinum-sw-register>`.
/// A simple, yet useful configuration is
///
///     <platinum-sw-register auto-register>
///       <platinum-sw-cache></platinum-sw-cache>
///     </platinum-sw-register>
///
/// This is enough to have all of the resources your site uses cached at runtime, both local and
/// cross-origin.
/// (It uses the default `defaultCacheStrategy` of "networkFirst".)
/// When there's a network available, visits to your site will go against the network copy of the
/// resources, but if someone visits your site when they're offline, all the cached resources will
/// be used.
@CustomElementProxy('platinum-sw-cache')
class PlatinumSwCache extends HtmlElement with CustomElementProxyMixin, PolymerProxyMixin {
  PlatinumSwCache.created() : super.created();
  factory PlatinumSwCache() => new Element.tag('platinum-sw-cache');

  /// The caching strategy used for all requests, both for local and cross-origin resources.
  ///
  /// For a list of strategies, see the [`sw-toolbox` documentation](https://github.com/GoogleChrome/sw-toolbox#built-in-handlers).
  /// Specify a strategy as a string, without the "toolbox" prefix. E.g., for
  /// `toolbox.networkFirst`, set `defaultCacheStrategy` to "networkFirst".
  ///
  /// Note that the "cacheFirst" and "cacheOnly" strategies are not recommended, and may be
  /// explicitly prevented in a future release. More information can be found at
  /// https://github.com/PolymerElements/platinum-sw#cacheonly--cachefirst-defaultcachestrategy-considered-harmful
  String get defaultCacheStrategy => jsElement[r'defaultCacheStrategy'];
  set defaultCacheStrategy(String value) { jsElement[r'defaultCacheStrategy'] = value; }

  /// Used to provide a list of URLs that are always precached as soon as the service worker is
  /// installed. Corresponds to  [`sw-toolbox`'s `precache()` method](https://github.com/GoogleChrome/sw-toolbox#toolboxprecachearrayofurls).
  ///
  /// This is useful for URLs that that wouldn't necessarily be picked up by runtime caching,
  /// i.e. a list of resources that are needed by one of the subpages of your site, or a list of
  /// resources that are only loaded via user interaction.
  ///
  /// `precache` can be used in conjunction with `precacheFile`, and the two arrays will be
  /// concatenated.
  JsArray get precache => jsElement[r'precache'];
  set precache(JsArray value) { jsElement[r'precache'] = (value is Iterable) ? new JsObject.jsify(value) : value;}

  /// Used to provide a list of URLs that are always precached as soon as the service worker is
  /// installed. Corresponds to  [`sw-toolbox`'s `precache()` method](https://github.com/GoogleChrome/sw-toolbox#toolboxprecachearrayofurls).
  ///
  /// While the `precache` option supports provided the array of URLs in as an inline attribute,
  /// this option supports providing them as an array in JSON file, which is fetched at runtime.
  /// This is useful if the array is generated via a separate build step, as it's easier to
  /// write that output to a file then it is to modify inline HTML content.
  ///
  /// `precacheFile` can be used in conjunction with `precache`, and the two arrays will be
  /// concatenated.
  String get precacheFile => jsElement[r'precacheFile'];
  set precacheFile(String value) { jsElement[r'precacheFile'] = value; }
}
