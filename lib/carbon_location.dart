// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `carbon_location`.
@HtmlImport('carbon_location_nodart.html')
library polymer_elements.lib.src.carbon_route.carbon_location;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_location.dart';
import 'iron_query_params.dart';
import 'carbon_route_converter.dart';

/// `carbon-location` is an element that provides synchronization between the
/// browser location bar and the state of an app. When created, `carbon-location`
/// elements will automatically watch the global location for changes. As changes
/// occur, `carbon-location` produces and updates an object called `route`. This
/// `route` object is suitable for passing into a `carbon-route`, and other similar
/// elements.
///
/// An example of a route object that describes the URL
/// `https://elements.polymer-project.org/elements/carbon-route-converter?foo=bar&baz=qux`:
///
///     {
///       prefix: '',
///       path: '/elements/carbon-route-converter'
///     }
///
/// Example Usage:
///
///     <carbon-location route="{{route}}"></carbon-location>
///     <carbon-route route="{{route}}" pattern="/:page" data="{{data}}"></carbon-route>
///
/// As you can see above, the `carbon-location` element produces a `route` and that
/// property is then bound into the `carbon-route` element. The bindings are two-
/// directional, so when changes to the `route` object occur within `carbon-route`,
/// they automatically reflect back to the global location.
///
/// A `carbon-location` can be configured to use the hash part of a URL as the
/// canonical source for path information.
///
/// Example:
///
///     <carbon-location route="{{route}}" use-hash-as-path></carbon-location>
@CustomElementProxy('carbon-location')
class CarbonLocation extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  CarbonLocation.created() : super.created();
  factory CarbonLocation() => new Element.tag('carbon-location');

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
