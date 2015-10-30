// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_streetview_pano`.
@HtmlImport('google_streetview_pano_nodart.html')
library polymer_elements.lib.src.google_streetview_pano.google_streetview_pano;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'google_maps_api.dart';

/// Element for generating a Google Maps Street View Panorama.
///
/// ##### Example
///
///     <google-streetview-pano
///       pano-id="CWskcsTEZBNXaD8gG-zATA"
///       heading="330"
///       pitch="-2"
///       zoom="0.8"
///       disable-default-ui>
///     </google-streetview-pano>
///
/// There are tons of great panoramas on the [Google Maps | Views page](https://www.google.com/maps/views/home?gl=us)
///
/// To grab a panorama, look at its url in the address bar. For example:
///
/// google.com/maps/views/view/102684927602131521305/photo/**1szTnskrdKIAAAGuu3fZRw**
///
/// The hash in bold is the `pano-id`. You'll often need to dial in the `heading`, `pitch` and `zoom` manually.
///
/// You can also use the position attribute and set it to a position with a computed value. Example: { lat: 42.345573, lng: -71.098326 }
///
///     <google-streetview-pano
///       position="[[_myComputedPosition()]]"
///       heading="330"
///       pitch="-2"
///       zoom="0.8"
///       disable-default-ui>
///     </google-streetview-pano>
@CustomElementProxy('google-streetview-pano')
class GoogleStreetviewPano extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleStreetviewPano.created() : super.created();
  factory GoogleStreetviewPano() => new Element.tag('google-streetview-pano');

  /// A Maps API key. To obtain an API key, see developers.google.com/maps/documentation/javascript/tutorial#api_key.
  String get apiKey => jsElement[r'apiKey'];
  set apiKey(String value) { jsElement[r'apiKey'] = value; }

  /// A Maps API for Business Client ID. To obtain a Maps API for Business Client ID, see developers.google.com/maps/documentation/business/.
  /// If set, a Client ID will take precedence over an API Key.
  String get clientId => jsElement[r'clientId'];
  set clientId(String value) { jsElement[r'clientId'] = value; }

  /// If true, disables the auto panning animation
  bool get disableAutoPan => jsElement[r'disableAutoPan'];
  set disableAutoPan(bool value) { jsElement[r'disableAutoPan'] = value; }

  /// If true, disables all default UI.
  bool get disableDefaultUi => jsElement[r'disableDefaultUi'];
  set disableDefaultUi(bool value) { jsElement[r'disableDefaultUi'] = value; }

  /// The camera heading in degrees relative to true north. True north is 0°, east is 90°, south is 180°, west is 270°.
  num get heading => jsElement[r'heading'];
  set heading(num value) { jsElement[r'heading'] = value; }

  /// The localized language to load the Maps API with. For more information
  /// see https://developers.google.com/maps/documentation/javascript/basics#Language
  ///
  /// Note: the Maps API defaults to the preferred language setting of the browser.
  /// Use this parameter to override that behavior.
  String get language => jsElement[r'language'];
  set language(String value) { jsElement[r'language'] = value; }

  get pano => jsElement[r'pano'];
  set pano(value) { jsElement[r'pano'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Specifies which photosphere to load
  String get panoId => jsElement[r'panoId'];
  set panoId(String value) { jsElement[r'panoId'] = value; }

  /// The camera pitch in degrees, relative to the street view vehicle. Ranges from 90° (directly upwards) to -90° (directly downwards).
  num get pitch => jsElement[r'pitch'];
  set pitch(num value) { jsElement[r'pitch'] = value; }

  /// Specifies which position to load
  get position => jsElement[r'position'];
  set position(value) { jsElement[r'position'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  get rAFid => jsElement[r'rAFid'];
  set rAFid(value) { jsElement[r'rAFid'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Version of the Google Maps API to use.
  String get version => jsElement[r'version'];
  set version(String value) { jsElement[r'version'] = value; }

  /// Sets the zoom level of the panorama. Fully zoomed-out is level 0, where the field of view is 180 degrees.
  num get zoom => jsElement[r'zoom'];
  set zoom(num value) { jsElement[r'zoom'] = value; }

  /// Reset the pov for the panorama.
  reset() =>
      jsElement.callMethod('reset', []);

  /// Cancel the slow panning animation.
  stop() =>
      jsElement.callMethod('stop', []);

  /// Fired every rAF. Updates the heading to create a slow pan effect
  /// Will be canceled by mouse enter or calling stop()
  update() =>
      jsElement.callMethod('update', []);
}
