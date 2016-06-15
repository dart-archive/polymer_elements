// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_location`.
@HtmlImport('app_location_nodart.html')
library polymer_elements.lib.src.app_route.app_location;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'app_route_converter_behavior.dart';
import 'iron_location.dart';
import 'iron_query_params.dart';

/// `app-location` is an element that provides synchronization between the
/// browser location bar and the state of an app. When created, `app-location`
/// elements will automatically watch the global location for changes. As changes
/// occur, `app-location` produces and updates an object called `route`. This
/// `route` object is suitable for passing into a `app-route`, and other similar
/// elements.
///
/// An example of the public API of a route object that describes the URL
/// `https://elements.polymer-project.org/elements/app-route-converter?foo=bar&baz=qux`:
///
///     {
///       prefix: '',
///       path: '/elements/app-route-converter'
///     }
///
/// Example Usage:
///
///     <app-location route="{{route}}"></app-location>
///     <app-route route="{{route}}" pattern="/:page" data="{{data}}"></app-route>
///
/// As you can see above, the `app-location` element produces a `route` and that
/// property is then bound into the `app-route` element. The bindings are two-
/// directional, so when changes to the `route` object occur within `app-route`,
/// they automatically reflect back to the global location.
///
/// ### Hashes vs Paths
///
/// By default `app-location` routes using the pathname portion of the URL. This has
/// broad browser support but it does require cooperation of the backend server. An
/// `app-location` can be configured to use the hash part of a URL instead using
/// the `use-hash-as-path` attribute, like so:
///
///     <app-location route="{{route}}" use-hash-as-path></app-location>
///
/// ### Integrating with other routing code
///
/// There is no standard event that is fired when window.location is modified.
/// `app-location` fires a `location-changed` event on `window` when it updates the
/// location. It also listens for that same event, and re-reads the URL when it's
/// fired. This makes it very easy to interop with other routing code.
@CustomElementProxy('app-location')
class AppLocation extends HtmlElement with CustomElementProxyMixin, PolymerBase, AppRouteConverterBehavior {
  AppLocation.created() : super.created();
  factory AppLocation() => new Element.tag('app-location');

  /// The route path, which will be either the hash or the path, depending
  /// on useHashAsPath.
  String get path => jsElement[r'path'];
  set path(String value) { jsElement[r'path'] = value; }

  /// A model representing the deserialized path through the route tree, as
  /// well as the current queryParams.
  get route => jsElement[r'route'];
  set route(value) { jsElement[r'route'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// A regexp that defines the set of URLs that should be considered part
  /// of this web app.
  ///
  /// Clicking on a link that matches this regex won't result in a full page
  /// navigation, but will instead just update the URL state in place.
  ///
  /// This regexp is given everything after the origin in an absolute
  /// URL. So to match just URLs that start with /search/ do:
  ///     url-space-regex="^/search/"
  get urlSpaceRegex => jsElement[r'urlSpaceRegex'];
  set urlSpaceRegex(value) { jsElement[r'urlSpaceRegex'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// In many scenarios, it is convenient to treat the `hash` as a stand-in
  /// alternative to the `path`. For example, if deploying an app to a static
  /// web server (e.g., Github Pages) - where one does not have control over
  /// server-side routing - it is usually a better experience to use the hash
  /// to represent paths through one's app.
  ///
  /// When this property is set to true, the `hash` will be used in place of
  ///
  /// the `path` for generating a `route`.
  bool get useHashAsPath => jsElement[r'useHashAsPath'];
  set useHashAsPath(bool value) { jsElement[r'useHashAsPath'] = value; }
}
