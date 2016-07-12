// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_route_converter`.
@HtmlImport('app_route_converter_nodart.html')
library polymer_elements.lib.src.app_route.app_route_converter;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'app_route_converter_behavior.dart';

/// `app-route-converter` provides a means to convert a path and query
/// parameters into a route object and vice versa. This produced route object
/// is to be fed into route-consuming elements such as `app-route`.
///
/// > n.b. This element is intended to be a primitive of the routing system and for
/// creating bespoke routing solutions from scratch. To simply include routing in
/// an app, please refer to [app-location](https://github.com/PolymerElements/app-route/blob/master/app-location.html)
/// and [app-route](https://github.com/PolymerElements/app-route/blob/master/app-route.html).
///
/// An example of a route object that describes
/// `https://elements.polymer-project.org/elements/app-route-converter?foo=bar&baz=qux`
/// and should be passed to other `app-route` elements:
///
///     {
///       prefix: '',
///       path: '/elements/app-route-converter',
///       __queryParams: {
///         foo: 'bar',
///         baz: 'qux'
///       }
///     }
///
/// `__queryParams` is private to discourage directly data-binding to it. This is so
/// that routing elements like `app-route` can intermediate changes to the query
/// params and choose whether to propagate them upstream or not. `app-route` for
/// example will not propagate changes to its `queryParams` property if it is not
/// currently active. A public queryParams object will also be produced in which you
/// should perform data-binding operations.
///
/// Example Usage:
///
///     <iron-location path="{{path}}" query="{{query}}"></iron-location>
///     <iron-query-params
///         params-string="{{query}}"
///         params-object="{{queryParams}}">
///     </iron-query-params>
///     <app-route-converter
///         path="{{path}}"
///         query-params="{{queryParams}}"
///         route="{{route}}">
///     </app-route-converter>
///     <app-route route='{{route}}' pattern='/:page' data='{{data}}'>
///     </app-route>
///
/// This is a simplified implementation of the `app-location` element. Here the
/// `iron-location` produces a path and a query, the `iron-query-params` consumes
/// the query and produces a queryParams object, and the `app-route-converter`
/// consumes the path and the query params and converts it into a route which is in
/// turn is consumed by the `app-route`.
@CustomElementProxy('app-route-converter')
class AppRouteConverter extends HtmlElement with CustomElementProxyMixin, PolymerBase, AppRouteConverterBehavior {
  AppRouteConverter.created() : super.created();
  factory AppRouteConverter() => new Element.tag('app-route-converter');
}
