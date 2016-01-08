// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_map_directions`.
@HtmlImport('google_map_directions_nodart.html')
library polymer_elements.lib.src.google_map.google_map_directions;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'google_maps_api.dart';

/// Provides the Google Maps API Directions Service to provide directions
/// between a `startAddress` and `endAddress`.
///
/// See https://developers.google.com/maps/documentation/javascript/directions for more
/// information on the API.
///
/// #### Example:
///
///     <template is="dom-bind">
///       <google-map-directions map="{{map}}"
///           start-address="San Francisco"
///           end-address="Mountain View"
///           travel-mode="BICYCLING"
///           waypoints='[{"location": "Palo Alto"}, {"location": "San Mateo"}]'></google-map-directions>
///       <google-map map="{{map}}" latitude="37.779"
///                   longitude="-122.3892"></google-map>
///     </template>
@CustomElementProxy('google-map-directions')
class GoogleMapDirections extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleMapDirections.created() : super.created();
  factory GoogleMapDirections() => new Element.tag('google-map-directions');

  /// A Maps API key. To obtain an API key, see developers.google.com/maps/documentation/javascript/tutorial#api_key.
  String get apiKey => jsElement[r'apiKey'];
  set apiKey(String value) { jsElement[r'apiKey'] = value; }

  /// End address or latlng for directions to end.
  String get endAddress => jsElement[r'endAddress'];
  set endAddress(String value) { jsElement[r'endAddress'] = value; }

  /// The localized language to load the Maps API with. For more information
  /// see https://developers.google.com/maps/documentation/javascript/basics#Language
  ///
  /// Note: the Maps API defaults to the preffered language setting of the browser.
  /// Use this parameter to override that behavior.
  String get language => jsElement[r'language'];
  set language(String value) { jsElement[r'language'] = value; }

  /// The Google map object.
  get map => jsElement[r'map'];
  set map(value) { jsElement[r'map'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Options for the display of results
  get rendererOptions => jsElement[r'rendererOptions'];
  set rendererOptions(value) { jsElement[r'rendererOptions'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The response from the directions service.
  get response => jsElement[r'response'];
  set response(value) { jsElement[r'response'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Start address or latlng to get directions from.
  String get startAddress => jsElement[r'startAddress'];
  set startAddress(String value) { jsElement[r'startAddress'] = value; }

  /// Travel mode to use.  One of 'DRIVING', 'WALKING', 'BICYCLING', 'TRANSIT'.
  String get travelMode => jsElement[r'travelMode'];
  set travelMode(String value) { jsElement[r'travelMode'] = value; }

  /// Array of intermediate waypoints. Directions will be calculated
  /// from the origin to the destination by way of each waypoint in this array.
  /// The maximum allowed waypoints is 8, plus the origin, and destination.
  /// Maps API for Business customers are allowed 23 waypoints,
  /// plus the origin, and destination.
  /// Waypoints are not supported for transit directions. Optional.
  List get waypoints => jsElement[r'waypoints'];
  set waypoints(List value) { jsElement[r'waypoints'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}
}
