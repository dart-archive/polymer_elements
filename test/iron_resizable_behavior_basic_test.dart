@TestOn('browser')
library polymer_elements.test.iron_resizable_behavior_basic_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'fixtures/iron_resizable_elements.dart';

int pendingNotifications;

ListenForResize(Element el, [bool expectsResize = true]) {
  var listener = (Event event) {
    var target = event.path.isNotEmpty ? event.path[0] : event.target;
    pendingNotifications--;
  };

  if (expectsResize != false) {
    pendingNotifications++;
  }

  el.addEventListener('iron-resize', listener);

  return {
    'el': el,
    'remove': () {
      el.removeEventListener('iron-resize', listener);
    }
  };
}

RemoveListeners(listeners) {
  listeners.forEach((listener) {
    listener['remove']();
  });
}

main() async {
  await initWebComponents();

  group('iron-resizable-behavior', () {
    TestElement testEl;

    setUp(() {
      pendingNotifications = 0;
      testEl = fixture('TestElement');
    });

    group('x-resizer-parent', () {

      test('notify resizables from window', () {
        var listeners = [
          ListenForResize(testEl.$['parent']),
          ListenForResize(testEl.$['child1a']),
          ListenForResize(testEl.$['child1b']),
          ListenForResize(testEl.$['shadow1c'].$['resizable']),
          ListenForResize(testEl.$['shadow1d'].$['resizable'])
        ];

        return wait(1).then((_) {
          window.dispatchEvent(new CustomEvent('resize', canBubble: false));

          expect(pendingNotifications, 0);

          RemoveListeners(listeners);
        });
      });

      test('notify resizables from parent', () {
        var listeners = [
          ListenForResize(testEl.$['parent']),
          ListenForResize(testEl.$['child1a']),
          ListenForResize(testEl.$['child1b']),
          ListenForResize(testEl.$['shadow1c'].$['resizable']),
          ListenForResize(testEl.$['shadow1d'].$['resizable'])
        ];
        
        return wait(1).then((_) {
          testEl.$['parent'].notifyResize();
          expect(pendingNotifications, 0);
          RemoveListeners(listeners);
        });
      });

      test('detach resizables then notify parent', () {
        var listeners = [
          ListenForResize(testEl.$['parent']),
          ListenForResize(testEl.$['child1a'], false),
          ListenForResize(testEl.$['child1b']),
          ListenForResize(testEl.$['shadow1c'].$['resizable'], false),
          ListenForResize(testEl.$['shadow1d'].$['resizable'])
        ];

        var el = Polymer.dom(testEl.root).querySelector('#child1a');

        el.parentNode.children.remove(el);
        el = Polymer.dom(testEl.root).querySelector('#shadow1c');
        el.parentNode.children.remove(el);

        return wait(1).then((_) {
          testEl.$['parent'].notifyResize();
          expect(pendingNotifications, 0);
          RemoveListeners(listeners);
        });
      });

      test('detach parent then notify window', () {
        var listeners = [
          ListenForResize(testEl.$['parent'], false),
          ListenForResize(testEl.$['child1a'], false),
          ListenForResize(testEl.$['child1b'], false),
          ListenForResize(testEl.$['shadow1c'].$['resizable'], false),
          ListenForResize(testEl.$['shadow1d'].$['resizable'], false)
        ];

        var el = Polymer.dom(testEl.root).querySelector('#parent');

        el.parentNode.children.remove(el);

        return wait(1).then((_) {
          window.dispatchEvent(new CustomEvent('resize', canBubble: false));
          expect(pendingNotifications, 0);
          RemoveListeners(listeners);
        });
      });

    });

    group('x-resizer-parent-filtered', () {

      test('notify resizables from window', () {
        var listeners = [
          ListenForResize(testEl.$['parentFiltered']),
          ListenForResize(testEl.$['child2a']),
          ListenForResize(testEl.$['child2b'], false),
          ListenForResize(testEl.$['shadow2c'].$['resizable'], false),
          ListenForResize(testEl.$['shadow2d'].$['resizable'], false)
        ];

        testEl.$['parentFiltered'].active = testEl.$['child2a'];

        return wait(1).then((_) {
          window.dispatchEvent(new CustomEvent('resize', canBubble: false));
          expect(pendingNotifications, 0);
          RemoveListeners(listeners);
        });
      });

      test('notify resizables from parent', () {
        var listeners = [
          ListenForResize(testEl.$['parentFiltered']),
          ListenForResize(testEl.$['child2a']),
          ListenForResize(testEl.$['child2b'], false),
          ListenForResize(testEl.$['shadow2c'].$['resizable'], false),
          ListenForResize(testEl.$['shadow2d'].$['resizable'], false)
        ];

        testEl.$['parentFiltered'].active = testEl.$['child2a'];

        return wait(1).then((_) {
          testEl.$['parentFiltered'].notifyResize();
          expect(pendingNotifications, 0);
          RemoveListeners(listeners);
        });
      });

      test('detach resizables then notify parent', () {
        var listeners = [
          ListenForResize(testEl.$['parentFiltered']),
          ListenForResize(testEl.$['child2a'], false),
          ListenForResize(testEl.$['child2b'], false),
          ListenForResize(testEl.$['shadow2c'].$['resizable'], false),
          ListenForResize(testEl.$['shadow2d'].$['resizable'])
        ];

        var el = Polymer.dom(testEl.root).querySelector('#child2a');
        el.parentNode.children.remove(el);
        el = Polymer.dom(testEl.root).querySelector('#shadow2c');
        el.parentNode.children.remove(el);

        testEl.$['parentFiltered'].active = testEl.$['shadow2d'].$['resizable'];

        return wait(1).then((_) {
          testEl.$['parentFiltered'].notifyResize();
          expect(pendingNotifications, 0);
          RemoveListeners(listeners);
        });
      });
    });
  });
}
