// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_button_behavior`.
@HtmlImport('paper_button_behavior_nodart.html')
library polymer_elements.lib.src.paper_behaviors.paper_button_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_button_state.dart';
import 'iron_a11y_keys_behavior.dart';
import 'iron_control_state.dart';
import 'paper_ripple_behavior.dart';


@BehaviorProxy(const ['Polymer', 'PaperButtonBehavior'])
abstract class PaperButtonBehavior implements CustomElementProxyMixin, IronButtonState, IronControlState, PaperRippleBehavior {

  /// The z-depth of this element, from 0-5. Setting to 0 will remove the
  /// shadow, and each increasing number greater than 0 will be "deeper"
  /// than the last.
  num get elevation => jsElement[r'elevation'];
  set elevation(num value) { jsElement[r'elevation'] = value; }
}
