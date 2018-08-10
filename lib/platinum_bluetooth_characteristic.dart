// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `platinum_bluetooth_characteristic`.
@HtmlImport('platinum_bluetooth_characteristic_nodart.html')
library polymer_elements.lib.src.platinum_bluetooth.platinum_bluetooth_characteristic;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// The `<platinum-bluetooth-characteristic>` element allows you to [read
/// and write characteristics on nearby bluetooth devices][1] thanks to the
/// young [Web Bluetooth API][2]. It is currently partially implemented
/// behind the experimental flag `chrome://flags/#enable-web-bluetooth`. It
/// is also now available in Chrome 53 as an [origin trial][3] for Chrome
/// OS, Android M, and Mac.
///
///
/// `<platinum-bluetooth-characteristic>` needs to be a child of a
/// `<platinum-bluetooth-service>` element.
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
/// Here's another example on how to reset energy expended on nearby
/// bluetooth device advertising Heart Rate service:
///
/// ```html
/// <platinum-bluetooth-device services-filter='["heart_rate"]'>
///   <platinum-bluetooth-service service='heart_rate'>
///     <platinum-bluetooth-characteristic characteristic='heart_rate_control_point'>
///     </platinum-bluetooth-characteristic>
///   </platinum-bluetooth-service>
/// </platinum-bluetooth-device>
/// ```
/// ```js
/// var bluetoothDevice = document.querySelector('platinum-bluetooth-device');
/// var heartRateCtrlPoint = document.querySelector('platinum-bluetooth-characteristic');
///
/// button.addEventListener('click', function() {
///   bluetoothDevice.request().then(function() {
///     // Writing 1 is the signal to reset energy expended.
///     var resetEnergyExpended = new Uint8Array([1]);
///     return heartRateCtrlPoint.write(resetEnergyExpended).then(function() {
///       console.log('Energy expended has been reset');
///     });
///   })
///   .catch(function(error) { });
/// });
/// ```
///
/// It is also possible for `<platinum-bluetooth-characteristic>` to fill in
/// a data-bound field in response to a read.
///
/// ```html
/// <platinum-bluetooth-device services-filter='["heart_rate"]'>
///   <platinum-bluetooth-service service='heart_rate'>
///     <platinum-bluetooth-characteristic characteristic='body_sensor_location'
///                                        value={{bodySensorLocation}}>
///     </platinum-bluetooth-characteristic>
///   </platinum-bluetooth-service>
/// </platinum-bluetooth-device>
/// ...
/// <span>{{bodySensorLocation}}</span>
/// ```
/// ```js
/// var bluetoothDevice = document.querySelector('platinum-bluetooth-device');
/// var bodySensorLocation = document.querySelector('platinum-bluetooth-characteristic');
///
/// button.addEventListener('click', function() {
///   bluetoothDevice.request().then(function() {
///     return bodySensorLocation.read()
///   })
///   .catch(function(error) { });
/// });
/// ```
///
/// Starting and stopping notifications on a `<platinum-bluetooth-characteristic>` is pretty straightforward when taking advantage of the [Polymer Change notification protocol](https://www.polymer-project.org/1.0/docs/devguide/data-binding.html#change-notification-protocol). Here's how to get your Heart Rate Measurement for instance:
///
/// ```html
/// <platinum-bluetooth-device services-filter='["heart_rate"]'>
///   <platinum-bluetooth-service service='heart_rate'>
///     <platinum-bluetooth-characteristic characteristic='heart_rate_measurement'
///                                        on-value-changed='parseHeartRate'>
///     </platinum-bluetooth-characteristic>
///   </platinum-bluetooth-service>
/// </platinum-bluetooth-device>
/// ```
/// ```js
/// var bluetoothDevice = document.querySelector('platinum-bluetooth-device');
/// var heartRate = document.querySelector('platinum-bluetooth-characteristic');
///
/// startButton.addEventListener('click', function() {
///   bluetoothDevice.request().then(function() {
///     return heartRate.startNotifications().catch(function(error) { });
///   });
/// });
///
/// stopButton.addEventListener('click', function() {
///   heartRate.stopNotifications().catch(function(error) { });
/// });
///
/// function parseHeartRate(event) {
///  let value = event.target.value;
///  // Do something with the DataView Object value...
/// }
/// ```
///
/// You can also use changes in `value` to drive characteristic writes when
/// `auto-write` property is set to true.
///
/// ```html
/// <platinum-bluetooth-device services-filter='["heart_rate"]'>
///   <platinum-bluetooth-service service='heart_rate'>
///     <platinum-bluetooth-characteristic characteristic='heart_rate_control_point'
///                                        auto-write>
///     </platinum-bluetooth-characteristic>
///   </platinum-bluetooth-service>
/// </platinum-bluetooth-device>
/// ```
/// ```js
/// var bluetoothDevice = document.querySelector('platinum-bluetooth-device');
/// var heartRateCtrlPoint = document.querySelector('platinum-bluetooth-characteristic');
///
/// button.addEventListener('click', function() {
///   bluetoothDevice.request().then(function() {
///     // Writing 1 is the signal to reset energy expended.
///     heartRateCtrlPoint.value = new Uint8Array([1]);
///   })
///   .catch(function(error) { });
/// });
///
/// heartRateCtrlPoint.addEventListener('platinum-bluetooth-auto-write-error',
///     function(event) {
///   // Handle error...
/// });
/// ```
///
/// [1]: https://developers.google.com/web/updates/2015/07/interact-with-ble-devices-on-the-web
/// [2]: https://github.com/WebBluetoothCG/web-bluetooth
/// [3]: https://developers.google.com/web/updates/2015/07/interact-with-ble-devices-on-the-web#available-for-origin-trials
@CustomElementProxy('platinum-bluetooth-characteristic')
class PlatinumBluetoothCharacteristic extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  PlatinumBluetoothCharacteristic.created() : super.created();
  factory PlatinumBluetoothCharacteristic() => new Element.tag('platinum-bluetooth-characteristic');

  /// If true, automatically perform a write `value` on the characteristic
  /// when `value` changes.
  bool get autoWrite => jsElement[r'autoWrite'];
  set autoWrite(bool value) { jsElement[r'autoWrite'] = value; }

  /// Required Bluetooth GATT characteristic for read and write operations.
  /// You may provide either the full Bluetooth UUID as a string or a
  /// short 16- or 32-bit form as integers like 0x2A19.
  String get characteristic => jsElement[r'characteristic'];
  set characteristic(String value) { jsElement[r'characteristic'] = value; }

  /// Value gets populated with the characteristic value when it's read
  /// and during a notification session.
  get value => jsElement[r'value'];
  set value(value) { jsElement[r'value'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Returns a promise that will resolve when Bluetooth GATT Characteristic
  /// is read.
  read() =>
      jsElement.callMethod('read', []);

  /// Returns a promise that will resolve when Bluetooth GATT Characteristic
  /// notification session starts.
  startNotifications() =>
      jsElement.callMethod('startNotifications', []);

  /// Returns a promise that will resolve when Bluetooth GATT Characteristic
  /// notification session stops.
  stopNotifications() =>
      jsElement.callMethod('stopNotifications', []);

  /// Returns a promise that will resolve when Bluetooth GATT Characteristic
  /// is written.
  /// [value]: The value to write.
  write(value) =>
      jsElement.callMethod('write', [value]);
}
