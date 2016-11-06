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
/// will trigger the callback. A key binding has the format
/// `"KEY+MODIFIER:EVENT": "callback"` (`"KEY": "callback"` or
/// `"KEY:EVENT": "callback"` are valid as well). Some examples:
///
///      keyBindings: {
///        'space': '_onKeydown', // same as 'space:keydown'
///        'shift+tab': '_onKeydown',
///        'enter:keypress': '_onKeypress',
///        'esc:keyup': '_onKeyup'
///      }
///
/// The callback will receive with an event containing the following information in `event.detail`:
///
///      _onKeydown: function(event) {
///        console.log(event.detail.combo); // KEY+MODIFIER, e.g. "shift+tab"
///        console.log(event.detail.key); // KEY only, e.g. "tab"
///        console.log(event.detail.event); // EVENT, e.g. "keydown"
///        console.log(event.detail.keyboardEvent); // the original KeyboardEvent
///      }
///
/// Use the `keyEventTarget` attribute to set up event handlers on a specific
/// node.
///
/// See the [demo source code](https://github.com/PolymerElements/iron-a11y-keys-behavior/blob/master/demo/x-key-aware.html)
/// for an example.
@BehaviorProxy(const ['Polymer', 'IronA11yKeysBehavior'])
abstract class IronA11yKeysBehavior implements CustomElementProxyMixin {

  /// To be used to express what combination of keys  will trigger the relative
  /// callback. e.g. `keyBindings: { 'esc': '_onEscPressed'}`
  get instanceKeyBindings => jsElement[r'keyBindings'];
  set instanceKeyBindings(value) { jsElement[r'keyBindings'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The EventTarget that will be firing relevant KeyboardEvents. Set it to
  /// `null` to disable the listeners.
  get keyEventTarget => jsElement[r'keyEventTarget'];
  set keyEventTarget(value) { jsElement[r'keyEventTarget'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// If true, this property will cause the implementing element to
  /// automatically stop propagation on any handled KeyboardEvents.
  bool get stopKeyboardEventPropagation => jsElement[r'stopKeyboardEventPropagation'];
  set stopKeyboardEventPropagation(bool value) { jsElement[r'stopKeyboardEventPropagation'] = value; }

  /// Can be used to imperatively add a key binding to the implementing
  /// element. This is the imperative equivalent of declaring a keybinding
  /// in the `keyBindings` prototype property.
  addOwnKeyBinding(eventString, handlerName) =>
      jsElement.callMethod('addOwnKeyBinding', [eventString, handlerName]);

  /// Returns true if a keyboard event matches `eventString`.
  bool keyboardEventMatchesKeys(event, String eventString) =>
      jsElement.callMethod('keyboardEventMatchesKeys', [event, eventString]);

  /// When called, will remove all imperatively-added key bindings.
  removeOwnKeyBindings() =>
      jsElement.callMethod('removeOwnKeyBindings', []);

  registered() =>
      jsElement.callMethod('registered', []);
}
