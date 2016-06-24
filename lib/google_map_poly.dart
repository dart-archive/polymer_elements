// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_map_poly`.
@HtmlImport('google_map_poly_nodart.html')
library polymer_elements.lib.src.google_map.google_map_poly;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'google_maps_api.dart';
import 'google_map_point.dart';

/// The `google-map-poly` element represents a series of connected line segments (aka a polyline) which
/// may also be closed to form a polygon (provided there are at least three points). It is used as a
/// child of `google-map` and will contain at least two `google-map-point` child elements.
///
/// <b>Example</b>—a simple line:
///
///     <google-map latitude="37.77493" longitude="-122.41942">
///       <google-map-poly>
///         <google-map-point latitude="37.77493" longitude="-122.41942"></google-map-point>
///         <google-map-point latitude="38.77493" longitude="-123.41942"></google-map-point>
///       </google-map-poly>
///     </google-map>
///
/// <b>Example</b>—a semi-translucent blue triangle:
///
///     <google-map latitude="37.77493" longitude="-122.41942">
///       <google-map-poly closed fill-color="blue" fill-opacity=".5">
///         <google-map-point latitude="36.77493" longitude="-121.41942"></google-map-point>
///         <google-map-point latitude="38.77493" longitude="-122.41942"></google-map-point>
///         <google-map-point latitude="36.77493" longitude="-123.41942"></google-map-point>
///       </google-map-poly>
///     </google-map>
@CustomElementProxy('google-map-poly')
class GoogleMapPoly extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleMapPoly.created() : super.created();
  factory GoogleMapPoly() => new Element.tag('google-map-poly');

  /// When true, the google-map-poly-*click events will be automatically registered.
  bool get clickEvents => jsElement[r'clickEvents'];
  set clickEvents(bool value) { jsElement[r'clickEvents'] = value; }

  /// When true, the poly will generate mouse events.
  bool get clickable => jsElement[r'clickable'];
  set clickable(bool value) { jsElement[r'clickable'] = value; }

  /// When true, the path will be closed by connecting the last point to the first one and
  /// treating the poly as a polygon.
  bool get closed => jsElement[r'closed'];
  set closed(bool value) { jsElement[r'closed'] = value; }

  /// When true, the google-map-poly-drag* events will be automatically registered.
  bool get dragEvents => jsElement[r'dragEvents'];
  set dragEvents(bool value) { jsElement[r'dragEvents'] = value; }

  /// When true, the poly may be dragged to a new position.
  bool get draggable => jsElement[r'draggable'];
  set draggable(bool value) { jsElement[r'draggable'] = value; }

  /// When true, the poly's vertices may be individually moved or new ones added.
  bool get editable => jsElement[r'editable'];
  set editable(bool value) { jsElement[r'editable'] = value; }

  /// When true, indicates that the user has begun editing the poly path (adding vertices).
  bool get editing => jsElement[r'editing'];
  set editing(bool value) { jsElement[r'editing'] = value; }

  /// If the path is closed, the polygon fill color. All CSS3 colors are supported except for
  /// extended named colors.
  String get fillColor => jsElement[r'fillColor'];
  set fillColor(String value) { jsElement[r'fillColor'] = value; }

  /// If the path is closed, the polygon fill opacity (between 0.0 and 1.0).
  num get fillOpacity => jsElement[r'fillOpacity'];
  set fillOpacity(num value) { jsElement[r'fillOpacity'] = value; }

  /// When true, the poly's edges are interpreted as geodesic and will follow the curvature of
  /// the Earth. When not set, the poly's edges are rendered as straight lines in screen space.
  /// Note that the poly of a geodesic poly may appear to change when dragged, as the dimensions
  /// are maintained relative to the surface of the earth.
  bool get geodesic => jsElement[r'geodesic'];
  set geodesic(bool value) { jsElement[r'geodesic'] = value; }

  /// If the path is not closed, the icons to be rendered along the polyline.
  List get icons => jsElement[r'icons'];
  set icons(List value) { jsElement[r'icons'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// The Google map object.
  get map => jsElement[r'map'];
  set map(value) { jsElement[r'map'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// When true, the google-map-poly-mouse* events will be automatically registered.
  bool get mouseEvents => jsElement[r'mouseEvents'];
  set mouseEvents(bool value) { jsElement[r'mouseEvents'] = value; }

  /// An array of the Google Maps LatLng objects that define the poly shape.
  get path => jsElement[r'path'];
  set path(value) { jsElement[r'path'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// A Google Maps polyline or polygon object (depending on value of "closed" attribute).
  get poly => jsElement[r'poly'];
  set poly(value) { jsElement[r'poly'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The color to draw the poly's stroke with. All CSS3 colors are supported except for extended
  /// named colors.
  String get strokeColor => jsElement[r'strokeColor'];
  set strokeColor(String value) { jsElement[r'strokeColor'] = value; }

  /// The stroke opacity (between 0.0 and 1.0).
  num get strokeOpacity => jsElement[r'strokeOpacity'];
  set strokeOpacity(num value) { jsElement[r'strokeOpacity'] = value; }

  /// The stroke position (center, inside, or outside).
  String get strokePosition => jsElement[r'strokePosition'];
  set strokePosition(String value) { jsElement[r'strokePosition'] = value; }

  /// The stroke width in pixels.
  num get strokeWeight => jsElement[r'strokeWeight'];
  set strokeWeight(num value) { jsElement[r'strokeWeight'] = value; }

  /// The Z-index relative to other objects on the map.
  num get zIndex => jsElement[r'zIndex'];
  set zIndex(num value) { jsElement[r'zIndex'] = value; }
}
