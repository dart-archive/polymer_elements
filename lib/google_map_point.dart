// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_map_point`.
@HtmlImport('google_map_point_nodart.html')
library polymer_elements.lib.src.google_map.google_map_point;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'google_maps_api.dart';

/// The `google-map-point` element represents a point on a map. It's used as a child of other
/// google-map-* elements.
///
/// <b>Example</b>—points defining a semi-translucent blue triangle:
///
///     <google-map latitude="37.77493" longitude="-122.41942">
///       <google-map-poly closed fill-color="blue" fill-opacity=".5">
///         <google-map-point latitude="36.77493" longitude="-121.41942"></google-map-point>
///         <google-map-point latitude="38.77493" longitude="-122.41942"></google-map-point>
///         <google-map-point latitude="36.77493" longitude="-123.41942"></google-map-point>
///       </google-map-poly>
///     </google-map>
@CustomElementProxy('google-map-point')
class GoogleMapPoint extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleMapPoint.created() : super.created();
  factory GoogleMapPoint() => new Element.tag('google-map-point');

  /// The point's latitude coordinate.
  num get latitude => jsElement[r'latitude'];
  set latitude(num value) { jsElement[r'latitude'] = value; }

  /// The point's longitude coordinate.
  num get longitude => jsElement[r'longitude'];
  set longitude(num value) { jsElement[r'longitude'] = value; }

  /// Returns the point as a Google Maps LatLng object.
  getPosition() =>
      jsElement.callMethod('getPosition', []);
}
