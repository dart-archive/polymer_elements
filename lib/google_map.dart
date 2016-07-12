// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_map`.
@HtmlImport('google_map_nodart.html')
library polymer_elements.lib.src.google_map.google_map;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_resizable_behavior.dart';
import 'google_maps_api.dart';
import 'iron_selector.dart';
import 'google_map_marker.dart';

/// The `google-map` element renders a Google Map.
///
/// <b>Example</b>:
///
///     <style>
///       google-map {
///         height: 600px;
///       }
///     </style>
///     <google-map latitude="37.77493" longitude="-122.41942"></google-map>
///
/// <b>Example</b> - add markers to the map and ensure they're in view:
///
///     <google-map latitude="37.77493" longitude="-122.41942" fit-to-markers>
///       <google-map-marker latitude="37.779" longitude="-122.3892"
///           draggable="true" title="Go Giants!"></google-map-marker>
///       <google-map-marker latitude="37.777" longitude="-122.38911"></google-map-marker>
///     </google-map>
///
/// <b>Example</b>:
///
///     <google-map disable-default-ui zoom="15"></google-map>
///     <script>
///       var map = document.querySelector('google-map');
///       map.latitude = 37.77493;
///       map.longitude = -122.41942;
///       map.addEventListener('google-map-ready', function(e) {
///         alert('Map loaded!');
///       });
///     </script>
///
/// <b>Example</b> - with Google directions, using data-binding inside another Polymer element
///
///     <google-map map="{{map}}"></google-map>
///     <google-map-directions map="{{map}}"
///         start-address="San Francisco" end-address="Mountain View">
///     </google-map-directions>
@CustomElementProxy('google-map')
class GoogleMap extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronResizableBehavior {
  GoogleMap.created() : super.created();
  factory GoogleMap() => new Element.tag('google-map');

  /// Additional map options for google.maps.Map constructor.
  /// Use to specify additional options we do not expose as
  /// properties.
  /// Ex: `<google-map additional-map-options='{"mapTypeId":"satellite"}'>`
  ///
  /// Note, you can't use API enums like `google.maps.ControlPosition.TOP_RIGHT`
  /// when using this property as an HTML attribute. Instead, use the actual
  /// value (e.g. `3`) or set `.additionalMapOptions` in JS rather than using
  /// the attribute.
  get additionalMapOptions => jsElement[r'additionalMapOptions'];
  set additionalMapOptions(value) { jsElement[r'additionalMapOptions'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// A Maps API key. To obtain an API key, see developers.google.com/maps/documentation/javascript/tutorial#api_key.
  String get apiKey => jsElement[r'apiKey'];
  set apiKey(String value) { jsElement[r'apiKey'] = value; }

  /// When true, map *click events are automatically registered.
  bool get clickEvents => jsElement[r'clickEvents'];
  set clickEvents(bool value) { jsElement[r'clickEvents'] = value; }

  /// A Maps API for Business Client ID. To obtain a Maps API for Business Client ID, see developers.google.com/maps/documentation/business/.
  /// If set, a Client ID will take precedence over an API Key.
  String get clientId => jsElement[r'clientId'];
  set clientId(String value) { jsElement[r'clientId'] = value; }

  /// If set, removes the map's default UI controls.
  bool get disableDefaultUi => jsElement[r'disableDefaultUi'];
  set disableDefaultUi(bool value) { jsElement[r'disableDefaultUi'] = value; }

  /// If true, prevent the user from zooming the map interactively.
  bool get disableZoom => jsElement[r'disableZoom'];
  set disableZoom(bool value) { jsElement[r'disableZoom'] = value; }

  /// When true, map drag* events are automatically registered.
  bool get dragEvents => jsElement[r'dragEvents'];
  set dragEvents(bool value) { jsElement[r'dragEvents'] = value; }

  /// If set, the zoom level is set such that all markers (google-map-marker children) are brought into view.
  bool get fitToMarkers => jsElement[r'fitToMarkers'];
  set fitToMarkers(bool value) { jsElement[r'fitToMarkers'] = value; }

  /// A kml file to load.
  String get kml => jsElement[r'kml'];
  set kml(String value) { jsElement[r'kml'] = value; }

  /// The localized language to load the Maps API with. For more information
  /// see https://developers.google.com/maps/documentation/javascript/basics#Language
  ///
  /// Note: the Maps API defaults to the preffered language setting of the browser.
  /// Use this parameter to override that behavior.
  String get language => jsElement[r'language'];
  set language(String value) { jsElement[r'language'] = value; }

  /// A latitude to center the map on.
  num get latitude => jsElement[r'latitude'];
  set latitude(num value) { jsElement[r'latitude'] = value; }

  /// A longitude to center the map on.
  num get longitude => jsElement[r'longitude'];
  set longitude(num value) { jsElement[r'longitude'] = value; }

  /// A Maps API object.
  get map => jsElement[r'map'];
  set map(value) { jsElement[r'map'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Map type to display. One of 'roadmap', 'satellite', 'hybrid', 'terrain'.
  String get mapType => jsElement[r'mapType'];
  set mapType(String value) { jsElement[r'mapType'] = value; }

  /// The markers on the map.
  List get markers => jsElement[r'markers'];
  set markers(List value) { jsElement[r'markers'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// A maximum zoom level which will be displayed on the map.
  num get maxZoom => jsElement[r'maxZoom'];
  set maxZoom(num value) { jsElement[r'maxZoom'] = value; }

  /// A minimum zoom level which will be displayed on the map.
  num get minZoom => jsElement[r'minZoom'];
  set minZoom(num value) { jsElement[r'minZoom'] = value; }

  /// When true, map mouse* events are automatically registered.
  bool get mouseEvents => jsElement[r'mouseEvents'];
  set mouseEvents(bool value) { jsElement[r'mouseEvents'] = value; }

  /// When set, prevents the map from tilting (when the zoom level and viewport supports it).
  bool get noAutoTilt => jsElement[r'noAutoTilt'];
  set noAutoTilt(bool value) { jsElement[r'noAutoTilt'] = value; }

  /// The non-marker objects on the map.
  List get objects => jsElement[r'objects'];
  set objects(List value) { jsElement[r'objects'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// If true, sign-in is enabled.
  /// See https://developers.google.com/maps/documentation/javascript/signedin#enable_sign_in
  bool get signedIn => jsElement[r'signedIn'];
  set signedIn(bool value) { jsElement[r'signedIn'] = value; }

  /// If set, all other info windows on markers are closed when opening a new one.
  bool get singleInfoWindow => jsElement[r'singleInfoWindow'];
  set singleInfoWindow(bool value) { jsElement[r'singleInfoWindow'] = value; }

  /// If set, custom styles can be applied to the map.
  /// For style documentation see developers.google.com/maps/documentation/javascript/reference#MapTypeStyle
  get styles => jsElement[r'styles'];
  set styles(value) { jsElement[r'styles'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Version of the Google Maps API to use.
  String get version => jsElement[r'version'];
  set version(String value) { jsElement[r'version'] = value; }

  /// A zoom level to set the map to.
  num get zoom => jsElement[r'zoom'];
  set zoom(num value) { jsElement[r'zoom'] = value; }

  /// Clears all markers from the map.
  clearMarkers() =>
      jsElement.callMethod('clear', []);

  /// Explicitly resizes the map, updating its center. This is useful if the
  /// map does not show after you have unhidden it.
  resize() =>
      jsElement.callMethod('resize', []);
}
