// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `platinum_bluetooth_device`.
@HtmlImport('platinum_bluetooth_device_nodart.html')
library polymer_elements.lib.src.platinum_bluetooth.platinum_bluetooth_device;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// The `<platinum-bluetooth-device>` element allows you to [discover nearby
/// bluetooth devices][1] thanks to the young [Web Bluetooth API][2]. It is
/// currently partially implemented behind the experimental flag
/// `chrome://flags/#enable-web-bluetooth`. It is also now available in
/// Chrome 53 as an [origin trial][3] for Chrome OS, Android M, and Mac.
///
/// `<platinum-bluetooth-device>` is used as a parent element for
/// `<platinum-bluetooth-service>` child elements.
///
/// For instance, here's how to request a nearby bluetooth device advertising
/// Battery service:
///
/// ```html
/// <platinum-bluetooth-device services-filter='["battery_service"]'>
/// </platinum-bluetooth-device>
/// ```
/// ```js
/// button.addEventListener('click', function() {
///   document.querySelector('platinum-bluetooth-device').request()
///   .then(function(device) { console.log(device.name); })
///   .catch(function(error) { console.error(error); });
/// });
/// ```
///
/// You can also request a nearby bluetooth device by setting a filter on
/// a name or name Prefix:
///
/// ```html
/// <platinum-bluetooth-device name-filter='foobar'>
/// </platinum-bluetooth-device>
/// ```
/// ```html
/// <platinum-bluetooth-device name-prefix-filter='foo'>
/// </platinum-bluetooth-device>
/// ```
///
/// And you can combine some of the filters as well. Here's how to request a
/// nearby bluetooth device advertising Battery service and whose name is
/// "foobar":
///
/// ```html
/// <platinum-bluetooth-device services-filter='["battery_service"]'
///                            name-filter='foobar'>
/// </platinum-bluetooth-device>
/// ```
///
/// If you filter just by name, then you must use `optional-services-filter`
/// to get access to any services:
///
/// ```html
/// <platinum-bluetooth-device name-filter='foobar'
///                            optional-services-filter='["battery_service"]'>
/// </platinum-bluetooth-device>
/// ```
///
/// Disconnecting manually from a connected bluetooth device is pretty
/// straightforward:
///
/// ```js
/// disconnectButton.addEventListener('click', function() {
///   document.querySelector('platinum-bluetooth-device').disconnect();
/// });
/// ```
///
/// [1]: https://developers.google.com/web/updates/2015/07/interact-with-ble-devices-on-the-web
/// [2]: https://github.com/WebBluetoothCG/web-bluetooth
/// [3]: https://developers.google.com/web/updates/2015/07/interact-with-ble-devices-on-the-web#available-for-origin-trials
@CustomElementProxy('platinum-bluetooth-device')
class PlatinumBluetoothDevice extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  PlatinumBluetoothDevice.created() : super.created();
  factory PlatinumBluetoothDevice() => new Element.tag('platinum-bluetooth-device');

  /// Current Bluetooth device picked by user.
  get device => jsElement[r'device'];
  set device(value) { jsElement[r'device'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Device name filter.
  String get nameFilter => jsElement[r'nameFilter'];
  set nameFilter(String value) { jsElement[r'nameFilter'] = value; }

  /// Device name prefix filter.
  String get namePrefixFilter => jsElement[r'namePrefixFilter'];
  set namePrefixFilter(String value) { jsElement[r'namePrefixFilter'] = value; }

  /// Optional Bluetooth GATT services filter. This implies that if you
  /// filter just by name, you must use `optionalServicesFilter` to get
  /// access to any services. You may provide either the full Bluetooth
  /// UUID as a string or a short 16- or 32-bit form as integers like
  /// 0x180d.
  List get optionalServicesFilter => jsElement[r'optionalServicesFilter'];
  set optionalServicesFilter(List value) { jsElement[r'optionalServicesFilter'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// Bluetooth GATT services filter. You may provide either the
  /// full Bluetooth UUID as a string or a short 16- or 32-bit form as
  /// integers like 0x180d.
  List get servicesFilter => jsElement[r'servicesFilter'];
  set servicesFilter(List value) { jsElement[r'servicesFilter'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// Indicates whether the Web Bluetooth API is supported by
  /// this browser.
  bool get supported => jsElement[r'supported'];
  set supported(bool value) { jsElement[r'supported'] = value; }

  /// Disconnect GATT Server connection from current bluetooth device.
  disconnect() =>
      jsElement.callMethod('disconnect', []);

  /// Request a nearby bluetooth device and returns a Promise that will
  /// resolve when user picked one Bluetooth device based on filters.
  ///
  /// It must be called on user gesture.
  request() =>
      jsElement.callMethod('request', []);

  /// Reset device to pick a new device.
  reset() =>
      jsElement.callMethod('reset', []);
}
