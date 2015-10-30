// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_map_search`.
@HtmlImport('google_map_search_nodart.html')
library polymer_elements.lib.src.google_map.google_map_search;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// `google-map-search` provides Google Maps Places API functionality.
///
/// See https://developers.google.com/maps/documentation/javascript/places for more
/// information on the API.
///
/// #### Example:
///
///     <template is="dom-bind">
///       <google-map-search map="[[map]]" query="Pizza" results="{{results}}">
///       </google-map-search>
///       <google-map map="{{map}}" latitude="37.779"
///                   longitude="-122.3892">
///         <template is="dom-repeat" items="{{results}}" as="marker">
///           <google-map-marker latitude="{{marker.latitude}}"
///                              longitude="{{marker.longitude}}">
///             <h2>{{marker.name}}</h2>
///             <span>{{marker.formatted_address}}</span>
///           </google-map-marker>
///         </template>
///       </google-map>
///     </template>
@CustomElementProxy('google-map-search')
class GoogleMapSearch extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleMapSearch.created() : super.created();
  factory GoogleMapSearch() => new Element.tag('google-map-search');

  /// By default, search is restricted to the currently visible map area.
  /// Set this to true to search everywhere.
  ///
  /// Ignored if `radius` is set.
  bool get globalSearch => jsElement[r'globalSearch'];
  set globalSearch(bool value) { jsElement[r'globalSearch'] = value; }

  /// Latitude of the center of the search area.
  /// Ignored if `globalSearch` is true.
  num get latitude => jsElement[r'latitude'];
  set latitude(num value) { jsElement[r'latitude'] = value; }

  /// The lat/lng location.
  get location => jsElement[r'location'];
  set location(value) { jsElement[r'location'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Longitude of the center of the search area.
  /// Ignored if `globalSearch` is true.
  num get longitude => jsElement[r'longitude'];
  set longitude(num value) { jsElement[r'longitude'] = value; }

  /// The Google map object.
  get map => jsElement[r'map'];
  set map(value) { jsElement[r'map'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The search query.
  String get queryObject => jsElement[r'query'];
  set queryObject(String value) { jsElement[r'query'] = value; }

  /// Search radius, in meters.
  /// If `latitude` and `longitude` are not specified,
  /// the center of the currently visible map area is used.
  ///
  /// If not set, search will be restricted to the currently visible
  /// map area, unless `globalSearch` is set to true.
  num get radius => jsElement[r'radius'];
  set radius(num value) { jsElement[r'radius'] = value; }

  /// The search results.
  List get results => jsElement[r'results'];
  set results(List value) { jsElement[r'results'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// Space-separated list of result types.
  /// The search will only return results of the listed types.
  /// See https://developers.google.com/places/documentation/supported_types
  /// for a list of supported types.
  /// Leave empty or null to search for all result types.
  String get types => jsElement[r'types'];
  set types(String value) { jsElement[r'types'] = value; }

  /// Fetches details for a given place.
  /// [placeId]: The place id.
  getDetails(String placeId) =>
      jsElement.callMethod('getDetails', [placeId]);

  /// Perform a search using for `query` for the search term.
  search() =>
      jsElement.callMethod('search', []);
}
