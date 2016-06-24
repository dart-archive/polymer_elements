// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_map_marker`.
@HtmlImport('google_map_marker_nodart.html')
library polymer_elements.lib.src.google_map.google_map_marker;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'google_maps_api.dart';

/// The `google-map-marker` element represents a map marker. It is used as a
/// child of `google-map`.
///
/// <b>Example</b>:
///
///     <google-map latitude="37.77493" longitude="-122.41942">
///       <google-map-marker latitude="37.779" longitude="-122.3892"
///           title="Go Giants!"></google-map-marker>
///     </google-map>
///
/// <b>Example</b> - marker with info window (children create the window content):
///
///     <google-map-marker latitude="37.77493" longitude="-122.41942">
///       <img src="image.png">
///     </google-map-marker>
///
/// <b>Example</b> - a draggable marker:
///
///     <google-map-marker latitude="37.77493" longitude="-122.41942"
///          draggable="true"></google-map-marker>
///
/// <b>Example</b> - hide a marker:
///
///     <google-map-marker latitude="37.77493" longitude="-122.41942"
///         hidden></google-map-marker>
@CustomElementProxy('google-map-marker')
class GoogleMapMarker extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleMapMarker.created() : super.created();
  factory GoogleMapMarker() => new Element.tag('google-map-marker');

  /// A animation for the marker. "DROP" or "BOUNCE". See
  /// https://developers.google.com/maps/documentation/javascript/examples/marker-animations.
  String get animation => jsElement[r'animation'];
  set animation(String value) { jsElement[r'animation'] = value; }

  /// When true, marker *click events are automatically registered.
  bool get clickEvents => jsElement[r'clickEvents'];
  set clickEvents(bool value) { jsElement[r'clickEvents'] = value; }

  /// When true, marker drag* events are automatically registered.
  bool get dragEvents => jsElement[r'dragEvents'];
  set dragEvents(bool value) { jsElement[r'dragEvents'] = value; }

  /// Image URL for the marker icon.
  get icon => jsElement[r'icon'];
  set icon(value) { jsElement[r'icon'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// A Google Map Infowindow object.
  get info => jsElement[r'info'];
  set info(value) { jsElement[r'info'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The marker's latitude coordinate.
  num get latitude => jsElement[r'latitude'];
  set latitude(num value) { jsElement[r'latitude'] = value; }

  /// The marker's longitude coordinate.
  num get longitude => jsElement[r'longitude'];
  set longitude(num value) { jsElement[r'longitude'] = value; }

  /// The Google map object.
  get map => jsElement[r'map'];
  set map(value) { jsElement[r'map'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// A Google Maps marker object.
  get marker => jsElement[r'marker'];
  set marker(value) { jsElement[r'marker'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// When true, marker mouse* events are automatically registered.
  bool get mouseEvents => jsElement[r'mouseEvents'];
  set mouseEvents(bool value) { jsElement[r'mouseEvents'] = value; }

  /// Specifies whether the InfoWindow is open or not
  bool get open => jsElement[r'open'];
  set open(bool value) { jsElement[r'open'] = value; }

  /// Z-index for the marker icon.
  num get zIndex => jsElement[r'zIndex'];
  set zIndex(num value) { jsElement[r'zIndex'] = value; }
}
