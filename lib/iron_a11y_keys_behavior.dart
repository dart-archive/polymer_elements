// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_a11y_keys_behavior`.
@HtmlImport('iron_a11y_keys_behavior_nodart.html')
library polymer_elements.lib.src.iron_a11y_keys_behavior.iron_a11y_keys_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// `Polymer.IronA11yKeysBehavior` provides a normalized interface for processing
/// keyboard commands that pertain to [WAI-ARIA best practices](http://www.w3.org/TR/wai-aria-practices/#kbd_general_binding).
/// The element takes care of browser differences with respect to Keyboard events
/// and uses an expressive syntax to filter key presses.
///
/// Use the `keyBindings` prototype property to express what combination of keys
/// will trigger the event to fire.
///
/// Use the `key-event-target` attribute to set up event handlers on a specific
/// node.
/// The `keys-pressed` event will fire when one of the key combinations set with the
/// `keys` property is pressed.
@BehaviorProxy(const ['Polymer', 'IronA11yKeysBehavior'])
abstract class IronA11yKeysBehavior implements CustomElementProxyMixin {

  get keyBindings => jsElement[r'keyBindings'];
  set keyBindings(value) { jsElement[r'keyBindings'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// The HTMLElement that will be firing relevant KeyboardEvents.
  get keyEventTarget => jsElement[r'keyEventTarget'];
  set keyEventTarget(value) { jsElement[r'keyEventTarget'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// Can be used to imperatively add a key binding to the implementing
  /// element. This is the imperative equivalent of declaring a keybinding
  /// in the `keyBindings` prototype property.
  void addOwnKeyBinding(eventString, handlerName) =>
      jsElement.callMethod('addOwnKeyBinding', [eventString, handlerName]);

  /// Returns true if `event.key` or `event.keyCode` matches `eventString`.
  bool keyboardEventMatchesKeys(event, String eventString) =>
      jsElement.callMethod('keyboardEventMatchesKeys', [event, eventString]);

  /// When called, will remove all imperatively-added key bindings.
  void removeOwnKeyBindings() =>
      jsElement.callMethod('removeOwnKeyBindings', []);

  void registered() =>
      jsElement.callMethod('registered', []);
}
