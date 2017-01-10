// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `platinum_sw_register`.
@HtmlImport('platinum_sw_register_nodart.html')
library polymer_elements.lib.src.platinum_sw.platinum_sw_register;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// The `<platinum-sw-register>` element handles
/// [service worker](http://www.html5rocks.com/en/tutorials/service-worker/introduction/)
/// registration, reflects the overall service worker state, and coordinates the configuration
/// provided by other Service Worker Elements.
/// `<platinum-sw-register>` is used as a parent element for child elements in the
/// `<platinum-sw-*>` group.
///
///     <platinum-sw-register skip-waiting
///                           clients-claim
///                           auto-register
///                           state="{{state}}"
///                           on-service-worker-error="handleSWError"
///                           on-service-worker-updated="handleSWUpdated"
///                           on-service-worker-installed="handleSWInstalled">
///       ...one or more <platinum-sw-*> children which share the service worker registration...
///     </platinum-sw-register>
///
/// Please see https://github.com/PolymerElements/platinum-sw#top-level-sw-importjs for a
/// *crucial* prerequisite file you must create before `<platinum-sw-register>` can be used!
@CustomElementProxy('platinum-sw-register')
class PlatinumSwRegister extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  PlatinumSwRegister.created() : super.created();
  factory PlatinumSwRegister() => new Element.tag('platinum-sw-register');

  /// Whether this element should automatically register the corresponding service worker as
  /// soon as its added to a page.
  ///
  /// If set to `false`, then the service worker won't be automatically registered, and you
  /// must call this element's `register()` method if you want service worker functionality.
  /// This is useful if, for example, the service worker needs to be configured using
  /// information that isn't immediately available at the time the page loads.
  ///
  /// If set to `true`, the service worker will be automatically registered without having to
  /// call any methods.
  bool get autoRegister => jsElement[r'autoRegister'];
  set autoRegister(bool value) { jsElement[r'autoRegister'] = value; }

  /// The URI used as a base when constructing relative paths to service worker helper libraries
  /// that need to be loaded.
  ///
  /// This can normally be kept set to the default, which will use the directory containing this
  /// element as the base. However, if you [Vulcanize](https://github.com/polymer/vulcanize) your
  /// elements, then the default base might not be appropriate anymore. This will allow you to
  /// override it.
  ///
  /// See https://github.com/PolymerElements/platinum-sw#relative-paths--vulcanization for more
  /// information.
  String get baseUri => jsElement[r'baseUri'];
  set baseUri(String value) { jsElement[r'baseUri'] = value; }

  /// Whether the activated service worker should [take immediate control](https://slightlyoff.github.io/ServiceWorker/spec/service_worker/#clients-claim-method)
  /// of any pages under its scope.
  ///
  /// If this is `false`, the service worker won't have any effect until the next time the page
  /// is visited/reloaded.
  /// If this is `true`, it will take control and start handling events for the current page
  /// (and any pages under the same scope open in other tabs/windows) as soon it's active.
  bool get clientsClaim => jsElement[r'clientsClaim'];
  set clientsClaim(bool value) { jsElement[r'clientsClaim'] = value; }

  /// The service worker script that is [registered](https://slightlyoff.github.io/ServiceWorker/spec/service_worker/#navigator-service-worker-register).
  /// The script *should* be located at the top level of your site, to ensure that it is able
  /// to control all the pages on your site.
  ///
  /// It's *strongly* recommended that you create a top-level file named `sw-import.js`
  /// containing only:
  ///
  /// `importScripts('bower_components/platinum-sw/service-worker.js');`
  ///
  /// (adjust to match the path where your `platinum-sw` element directory can be found).
  ///
  /// This will ensure that your service worker script contains everything needed to play
  /// nicely with the Service Worker Elements group.
  String get href => jsElement[r'href'];
  set href(String value) { jsElement[r'href'] = value; }

  /// Whether the page should be automatically reloaded (via `window.location.reload()`) when
  /// the service worker is successfully installed.
  ///
  /// While it's perfectly valid to continue using a page with a freshly installed service
  /// worker, it's a common pattern to want to reload it immediately following the install.
  /// This ensures that, for example, if you're using a `<platinum-sw-cache>` with an on the
  /// fly caching strategy, it will get a chance to intercept all the requests needed to render
  /// your page and store them in the cache.
  ///
  /// If you don't immediately reload your page, then any resources that were loaded before the
  /// service worker was installed (e.g. this `platinum-sw-register.html` file) won't be present
  /// in the cache until the next time the page is loaded.
  ///
  /// Note that this reload will only happen when a service worker is installed for the first
  /// time. If the service worker is subsequently updated, it won't trigger another reload.
  bool get reloadOnInstall => jsElement[r'reloadOnInstall'];
  set reloadOnInstall(bool value) { jsElement[r'reloadOnInstall'] = value; }

  /// By default, the service worker will use a scope that applies to all pages at the same
  /// directory level or lower. This is almost certainly what you want, as illustrated by the
  /// following hypothetical serving setup:
  ///
  /// ```
  /// /root/
  ///   service-worker.js
  ///   index.html
  ///   subdir1/
  ///     index.html
  ///   subdir2/
  ///     index.html
  /// ```
  ///
  /// So by default, registering `/root/service-worker.js` will cause the service worker's scope
  /// to cover `/root/index.html`, `/root/subdir1/index.html`, and /root/subdir2/index.html`.
  ///
  /// If, for some reason, you need to register `/root/service-worker.js` from within
  /// `/root/subdir1/index.html`, *and* you want that registration to only cover
  /// `/root/subdir1/**`, you can override this `scope` property and set it to `'./'`.
  ///
  /// There is more context about default scopes and how scope overrides work in
  /// [this Stack Overflow](http://stackoverflow.com/a/33881341/385997) response.
  String get scope => jsElement[r'scope'];
  set scope(String value) { jsElement[r'scope'] = value; }

  /// Whether an updated service worker should [bypass the `waiting` state](https://slightlyoff.github.io/ServiceWorker/spec/service_worker/#service-worker-global-scope-skipwaiting)
  /// and immediately become `active`.
  ///
  /// Normally, during an update, the new service worker stays in the
  /// `waiting` state until the current page and any other tabs/windows that are using the old
  /// service worker are unloaded.
  ///
  /// If this is `false`, an updated service worker won't be activated until all instances of
  /// the old server worker have been unloaded.
  ///
  /// If this is `true`, an updated service worker will become `active` immediately.
  bool get skipWaiting => jsElement[r'skipWaiting'];
  set skipWaiting(bool value) { jsElement[r'skipWaiting'] = value; }

  /// The current state of the service worker registered by this element.
  ///
  /// One of:
  /// - 'installed'
  /// - 'updated'
  /// - 'error'
  /// - 'unsupported'
  String get state => jsElement[r'state'];
  set state(String value) { jsElement[r'state'] = value; }

  /// Registers the service worker based on the configuration options in this element and any
  /// child elements.
  ///
  /// If you set the `autoRegister` property to `true`, then this method is called automatically
  /// at page load.
  /// It can be useful to set `autoRegister` to `false` and then explicitly call this method if
  /// there are options that are only configured after the page is loaded.
  register() =>
      jsElement.callMethod('register', []);
}
