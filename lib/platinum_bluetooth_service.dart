// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `platinum_bluetooth_service`.
@HtmlImport('platinum_bluetooth_service_nodart.html')
library polymer_elements.lib.src.platinum_bluetooth.platinum_bluetooth_service;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// The `<platinum-bluetooth-service>` element is used in conjuction with
/// the `<platinum-bluetooth-characteristic>` element to [read and write
/// characteristics on nearby bluetooth devices][1] thanks to the young [Web
/// Bluetooth API][2]. It is currently only partially implemented
/// in Chrome OS 45 and Chrome 49 for Android behind the experimental flag
/// `chrome://flags/#enable-web-bluetooth`.
///
/// `<platinum-bluetooth-service>` needs to be a child of a
/// `<platinum-bluetooth-device>` element.
///
/// For instance, here's how to read battery level from a nearby bluetooth
/// device advertising Battery service:
///
/// ```html
/// <platinum-bluetooth-device services-filter='["battery_service"]'>
///   <platinum-bluetooth-service service='battery_service'>
///     <platinum-bluetooth-characteristic characteristic='battery_level'>
///     </platinum-bluetooth-characteristic>
///   </platinum-bluetooth-service>
/// </platinum-bluetooth-device>
/// ```
/// ```js
/// var bluetoothDevice = document.querySelector('platinum-bluetooth-device');
/// var batteryLevel = document.querySelector('platinum-bluetooth-characteristic');
///
/// button.addEventListener('click', function() {
///   bluetoothDevice.request().then(function() {
///     return batteryLevel.read().then(function(value) {
///       console.log('Battery Level is ' + value.getUint8(0) + '%');
///     });
///   })
///   .catch(function(error) { });
/// });
/// ```
///
/// [1]: https://developers.google.com/web/updates/2015/07/interact-with-ble-devices-on-the-web
/// [2]: https://github.com/WebBluetoothCG/web-bluetooth
@CustomElementProxy('platinum-bluetooth-service')
class PlatinumBluetoothService extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  PlatinumBluetoothService.created() : super.created();
  factory PlatinumBluetoothService() => new Element.tag('platinum-bluetooth-service');

  /// Required Bluetooth GATT primary service. You may provide either the
  /// full Bluetooth UUID as a string or a short 16- or 32-bit form as
  /// integers like 0x180d.
  String get service => jsElement[r'service'];
  set service(String value) { jsElement[r'service'] = value; }
}
