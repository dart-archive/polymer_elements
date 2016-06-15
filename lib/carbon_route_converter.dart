// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `carbon_route_converter`.
@HtmlImport('carbon_route_converter_nodart.html')
library polymer_elements.lib.src.carbon_route.carbon_route_converter;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// `carbon-route-converter` provides a means to convert a path and query
/// parameters into a route object and vice versa. This produced route object
/// is to be fed into route-consuming elements such as `carbon-route`.
///
/// > n.b. This element is intended to be a primitive of the routing system and for
/// creating bespoke routing solutions from scratch. To simply include routing in
/// an app, please refer to [carbon-location](https://github.com/PolymerElements/carbon-route/blob/master/carbon-location.html)
/// and [carbon-route](https://github.com/PolymerElements/carbon-route/blob/master/carbon-route.html).
///
/// An example of a route element that describes
/// `https://elements.polymer-project.org/elements/carbon-route-converter?foo=bar&baz=qux`:
///
///     {
///       prefix: '',
///       path: '/elements/carbon-route-converter',
///       queryParams: {
///         foo: 'bar',
///         baz: 'qux'
///       }
///     }
///
/// Example Usage:
///
///     <iron-location path="{{path}}" query="{{query}}"></iron-location>
///     <iron-query-params
///         params-string="{{query}}"
///         params-object="{{queryParams}}">
///     </iron-query-params>
///     <carbon-route-converter
///         path="{{path}}"
///         query-params="{{queryParams}}"
///         route="{{route}}">
///     </carbon-route-converter>
///     <carbon-route route='{{route}}' pattern='/:page' data='{{data}}'>
///     </carbon-route>
///
/// This is a simplified implementation of the `carbon-location` element. Here the
/// `iron-location` produces a path and a query, the `iron-query-params` consumes
/// the query and produces a queryParams object, and the `carbon-route-converter`
/// consumes the path and the query params and converts it into a route which is in
/// turn is consumed by the `carbon-route`.
@CustomElementProxy('carbon-route-converter')
class CarbonRouteConverter extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  CarbonRouteConverter.created() : super.created();
  factory CarbonRouteConverter() => new Element.tag('carbon-route-converter');

  /// The serialized path through the route tree. This corresponds to the
  /// `window.location.pathname` value, and will update to reflect changes
  /// to that value.
  String get path => jsElement[r'path'];
  set path(String value) { jsElement[r'path'] = value; }

  /// A set of key/value pairs that are universally accessible to branches of
  /// the route tree.
  get queryParams => jsElement[r'queryParams'];
  set queryParams(value) { jsElement[r'queryParams'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// A model representing the deserialized path through the route tree, as
  /// well as the current queryParams.
  ///
  /// A route object is the kernel of the routing system. It is intended to
  /// be fed into consuming elements such as `carbon-route`.
  get route => jsElement[r'route'];
  set route(value) { jsElement[r'route'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}
}
