// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_button_state`.
@HtmlImport('iron_button_state_nodart.html')
library polymer_elements.lib.src.iron_behaviors.iron_button_state;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_a11y_keys_behavior.dart';
import 'iron_control_state.dart';


@BehaviorProxy(const ['Polymer', 'IronButtonState'])
abstract class IronButtonState implements CustomElementProxyMixin, IronA11yKeysBehavior {

  /// If true, the button is a toggle and is currently in the active state.
  bool get active => jsElement[r'active'];
  set active(bool value) { jsElement[r'active'] = value; }

  /// The aria attribute to be set if the button is a toggle and in the
  /// active state.
  String get ariaActiveAttribute => jsElement[r'ariaActiveAttribute'];
  set ariaActiveAttribute(String value) { jsElement[r'ariaActiveAttribute'] = value; }

  get keyBindings => jsElement[r'keyBindings'];
  set keyBindings(value) { jsElement[r'keyBindings'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// True if the element is currently being pressed by a "pointer," which
  /// is loosely defined as mouse or touch input (but specifically excluding
  /// keyboard input).
  bool get pointerDown => jsElement[r'pointerDown'];
  set pointerDown(bool value) { jsElement[r'pointerDown'] = value; }

  /// If true, the user is currently holding down the button.
  bool get pressed => jsElement[r'pressed'];
  set pressed(bool value) { jsElement[r'pressed'] = value; }

  /// True if the input device that caused the element to receive focus
  /// was a keyboard.
  bool get receivedFocusFromKeyboard => jsElement[r'receivedFocusFromKeyboard'];
  set receivedFocusFromKeyboard(bool value) { jsElement[r'receivedFocusFromKeyboard'] = value; }

  /// If true, the button toggles the active state with each tap or press
  /// of the spacebar.
  bool get toggles => jsElement[r'toggles'];
  set toggles(bool value) { jsElement[r'toggles'] = value; }
}
