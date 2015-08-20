@TestOn('browser')
library polymer_elements.test.iron_a11y_keys_behavior_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_a11y_keys_behavior.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('Polymer.IronA11yKeysBehavior', () {
    KeysTestBehavior keys;

    group('basic keys', () {
      setUp(() {
        keys = fixture('BasicKeys');
      });
  
      test('trigger the handler when the specified key is pressed', () {
        pressSpace(keys);
  
        expect(keys.keyCount, 1);
      });
  
      test('do not trigger the handler for non-specified keys', () {
        pressEnter(keys);
  
        expect(keys.keyCount, 0);
      });
  
      test('can have bindings added imperatively', () {
        keys.addOwnKeyBinding('enter', 'keyHandler');
  
        pressEnter(keys);
        expect(keys.keyCount, 1);
  
        pressSpace(keys);
        expect(keys.keyCount, 2);
      });
  
      test('can remove imperatively added bindings', () {
        keys.addOwnKeyBinding('enter', 'keyHandler');
        keys.removeOwnKeyBindings();
  
        pressEnter(keys);
        expect(keys.keyCount, 0);

        // **Dart Note**: All our key bindings are imperative, so this part of
        // the test isn't valid.
        // pressSpace(keys);
        // expect(keys.keyCount, 1);
      });
  
      group('edge cases', () {
        test('knows that `spacebar` is the same as `space`', () {
          var event = new CustomEvent('keydown');
          new JsObject.fromBrowserObject(event)['key'] = 'spacebar';
          expect(keys.keyboardEventMatchesKeys(event, 'space'), true);
        });
      });
  
      group('matching keyboard events to keys', () {
        test('can be done imperatively', () {
          var event = new CustomEvent('keydown');
          new JsObject.fromBrowserObject(event)['keyCode'] = 65;
          expect(keys.keyboardEventMatchesKeys(event, 'a'), true);
        });
  
        test('can be done with a provided keyboardEvent', () {
          var event;
          pressSpace(keys);
          event = keys.lastEvent as CustomEvent;

          expect(event, isNotNull);
          expect(eventDetail(event)['keyboardEvent'], isNotNull);
          expect(keys.keyboardEventMatchesKeys(event, 'space'), true);
        });
  
        test('can handle variations in arrow key names', () {
          var event = new CustomEvent('keydown');
          var jsEvent = new JsObject.fromBrowserObject(event);
          jsEvent['key'] = 'up';
          expect(keys.keyboardEventMatchesKeys(event, 'up'), true);
          jsEvent['key'] = 'ArrowUp';
          expect(keys.keyboardEventMatchesKeys(event, 'up'), true);
        });
      });
    });
  
    group('combo keys', () {
      setUp(() {
        keys = fixture('ComboKeys');
      });
  
      test('trigger the handler when the combo is pressed', () {
        var event = new CustomEvent('keydown');
        var jsEvent = new JsObject.fromBrowserObject(event);

        jsEvent['ctrlKey'] = true;
        jsEvent['shiftKey'] = true;
        jsEvent['keyCode'] = jsEvent['code'] = 65;

        keys.dispatchEvent(event);
  
        expect(keys.keyCount, 1);
      });
    });
  
    group('alternative event keys', () {
      setUp(() {
        keys = fixture('AlternativeEventKeys');
      });
  
      test('trigger on the specified alternative keyboard event', () {
        keyDownOn(keys, 32);
  
        expect(keys.keyCount, 0);
  
        keyUpOn(keys, 32);
  
        expect(keys.keyCount, 1);
      });
    });
  
    group('behavior keys', () {
      setUp(() {
        keys = fixture('BehaviorKeys');
      });
  
      test('bindings in other behaviors are transitive', () {
        pressEnter(keys);
        pressSpace(keys);
  
        expect(keys.keyCount, 2);
      });
    });
  });
}

@behavior
abstract class KeysTestBehavior implements PolymerMixin, HtmlElement, IronA11yKeysBehavior {
  @property
  int keyCount = 0;

  @property
  Event lastEvent;

  @eventHandler
  keyHandler(Event e) {
    set('keyCount', keyCount + 1);
    set('lastEvent', e);
  }
}

@jsProxyReflectable
@PolymerRegister('x-a11y-basic-keys')
class XA11yBasicKeys extends PolymerElement with IronA11yKeysBehavior, KeysTestBehavior {
  XA11yBasicKeys.created() : super.created();

  ready() {
    addOwnKeyBinding('space', 'keyHandler');
  }
}

@jsProxyReflectable
@PolymerRegister('x-a11y-combo-keys')
class XA11yComboKeys extends PolymerElement with IronA11yKeysBehavior, KeysTestBehavior {
  XA11yComboKeys.created() : super.created();

  ready() {
    addOwnKeyBinding('ctrl+shift+a', 'keyHandler');
  }
}

@jsProxyReflectable
@PolymerRegister('x-a11y-alternate-event-keys')
class XA11yAlternateEventKeys extends PolymerElement with IronA11yKeysBehavior, KeysTestBehavior {
  XA11yAlternateEventKeys.created() : super.created();

  ready() {
    addOwnKeyBinding('space:keyup', 'keyHandler');
  }
}

@behavior
abstract class XA11yBehavior implements KeysTestBehavior {
  static ready(KeysTestBehavior instance)  {
    instance.addOwnKeyBinding('enter', 'keyHandler');
  }
}

@jsProxyReflectable
@PolymerRegister('x-a11y-behavior-keys')
class XA11yBehaviorKeys extends PolymerElement
    with IronA11yKeysBehavior, KeysTestBehavior, XA11yBehavior {
  XA11yBehaviorKeys.created() : super.created();

  ready() {
    addOwnKeyBinding('space', 'keyHandler');
  }
}
