// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_route_converter_behavior`.
@HtmlImport('app_route_converter_behavior_nodart.html')
library polymer_elements.lib.src.app_route.app_route_converter_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// Provides bidirectional mapping between `path` and `queryParams` and a
/// app-route compatible `route` object.
///
/// For more information, see the docs for `app-route-converter`.
@BehaviorProxy(const ['Polymer', 'AppRouteConverterBehavior'])
abstract class AppRouteConverterBehavior implements CustomElementProxyMixin {

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
  /// be fed into consuming elements such as `app-route`.
  get route => jsElement[r'route'];
  set route(value) { jsElement[r'route'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}
}
