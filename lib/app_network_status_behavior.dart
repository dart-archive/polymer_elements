// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_network_status_behavior`.
@HtmlImport('app_network_status_behavior_nodart.html')
library polymer_elements.lib.src.app_storage.app_network_status_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// `Polymer.appNetworkStatusBehavior` tracks the status of whether the browser
/// is online or offline. True if the browser is online, and false if the browser is
/// offline matching the HTML browser state spec.
@BehaviorProxy(const ['Polymer', 'AppNetworkStatusBehavior'])
abstract class AppNetworkStatusBehavior implements CustomElementProxyMixin {

  /// True if the browser is online, and false if the browser is offline
  /// matching the HTML browser state spec.
  bool get online => jsElement[r'online'];
  set online(bool value) { jsElement[r'online'] = value; }

  /// Updates the `online` property to reflect the browser connection status.
  refreshNetworkStatus() =>
      jsElement.callMethod('refreshNetworkStatus', []);
}
