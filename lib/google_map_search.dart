// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_map_search`.
@HtmlImport('google_map_search_nodart.html')
library polymer_elements.lib.src.google_map.google_map_search;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// Provides Google Maps Places API functionality.
///
/// See https://developers.google.com/maps/documentation/javascript/places for more
/// information on the API.
///
/// #### Example:
///
///     <template is="dom-bind">
///       <google-map-search map="{{map}}" query="Pizza"
///                          result="{{result}}"></google-map-search>
///       <google-map map="{{map}}" latitude="37.779"
///                   longitude="-122.3892"></google-map>
///       <div>Result:
///         <span>{{result.latitude}}</span>,
///         <span>{{result.longitude}}</span>
///       </div>
///     </template>
///     <script>
///       document.querySelector('google-map-search').search();
///     < /script>
@CustomElementProxy('google-map-search')
class GoogleMapSearch extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleMapSearch.created() : super.created();
  factory GoogleMapSearch() => new Element.tag('google-map-search');

  /// The Google map object.
  get map => jsElement[r'map'];
  set map(value) { jsElement[r'map'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// The search query.
  String get queryObject => jsElement[r'query'];
  set queryObject(String value) { jsElement[r'query'] = value; }

  /// The search result.
  get result => jsElement[r'result'];
  set result(value) { jsElement[r'result'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// Performance a search using for `query` for the search term.
  void search() =>
      jsElement.callMethod('search', []);
}
