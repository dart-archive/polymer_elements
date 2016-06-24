@TestOn('browser')
library polymer_elements.test.iron_resizable_behavior_basic_test;

import 'dart:async';
import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'fixtures/iron_resizable_elements.dart';
import 'sinon/sinon.dart';

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
  await initPolymer();

  group('iron-resizable-behavior', () {
    TestElement testEl;

    setUp(() async {
      pendingNotifications = 0;
      testEl = fixture('TestElement');
      await new Future(() {});
    });

    group('x-resizer-parent', () {
      test('notify resizables from window', () async {
        var listeners = [
          ListenForResize(testEl.$['parent']),
          ListenForResize(testEl.$['child1a']),
          ListenForResize(testEl.$['child1b']),
          ListenForResize(testEl.$['shadow1c'].$['resizable']),
          ListenForResize(testEl.$['shadow1d'].$['resizable'])
        ];

        await wait(1);

        window.dispatchEvent(new CustomEvent('resize', canBubble: false));
        expect(pendingNotifications, 0);

        RemoveListeners(listeners);
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
        Spy child1aSpy = spy(testEl.$['child1a'].jsElement, 'notifyResize');
        Spy shadow1cSpy = spy(testEl.$['shadow1c'].$['resizable'].jsElement, 'notifyResize');
        Spy child1bSpy = spy(testEl.$['child1b'].jsElement, 'notifyResize');
        Spy shadow1dSpy = spy(testEl.$['shadow1d'].$['resizable'].jsElement, 'notifyResize');

        var firstElementToRemove = testEl.$['child1a'];
        var firstElementParent = new PolymerDom(firstElementToRemove).parentNode;
        var secondElementToRemove = testEl.$['shadow1c'].$['resizable'];
        var secondElementParent = new PolymerDom(secondElementToRemove).parentNode;

        new PolymerDom(firstElementParent).removeChild(firstElementToRemove);
        new PolymerDom(secondElementParent).removeChild(secondElementToRemove);

        PolymerDom.flush();

        testEl.$['parent'].notifyResize();

        expect(child1aSpy.callCount,0);
        expect(shadow1cSpy.callCount,0);
        expect(child1bSpy.callCount,1);
        expect(shadow1dSpy.callCount,1);
      });

      test('detach parent then notify window', when((done) {
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
          try {
            window.dispatchEvent(new CustomEvent('resize', canBubble: false ));
            expect(pendingNotifications,0);
            RemoveListeners(listeners);
            done();
          } catch (e) {
            done(e);
          }
        });
      }));
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

        window.dispatchEvent(new CustomEvent('resize', canBubble: false));
        expect(pendingNotifications, 0);

        RemoveListeners(listeners);
      });

      test('notify resizables from parent', () {
        var listeners = [
          ListenForResize(testEl.$['parent']),
          ListenForResize(testEl.$['child1a']),
          ListenForResize(testEl.$['child1b']),
          ListenForResize(testEl.$['shadow1c'].$['resizable']),
          ListenForResize(testEl.$['shadow1d'].$['resizable'])
        ];

        testEl.$['parent'].notifyResize();
        expect(pendingNotifications, 0);
        RemoveListeners(listeners);
      });

      test('detach resizables then notify parent', () {
        Spy child1aSpy = spy(testEl.$['child1a'].jsElement, 'notifyResize');
        Spy shadow1cSpy = spy(testEl.$['shadow1c'].$['resizable'].jsElement, 'notifyResize');
        Spy child1bSpy = spy(testEl.$['child1b'].jsElement, 'notifyResize');
        Spy shadow1dSpy = spy(testEl.$['shadow1d'].$['resizable'].jsElement, 'notifyResize');

        var firstElementToRemove = testEl.$['child1a'];
        var firstElementParent = new PolymerDom(firstElementToRemove).parentNode;
        var secondElementToRemove = testEl.$['shadow1c'].$['resizable'];
        var secondElementParent = new PolymerDom(secondElementToRemove).parentNode;

        new PolymerDom(firstElementParent).removeChild(firstElementToRemove);
        new PolymerDom(secondElementParent).removeChild(secondElementToRemove);

        PolymerDom.flush();

        testEl.$['parent'].notifyResize();

        expect(child1aSpy.callCount, 0);
        expect(shadow1cSpy.callCount, 0);
        expect(child1bSpy.callCount, 1);
        expect(shadow1dSpy.callCount, 1);
      });

      test('detach parent then notify window', when((done) async {
        var listeners = [
          ListenForResize(testEl.$['parent'], false),
          ListenForResize(testEl.$['child1a'], false),
          ListenForResize(testEl.$['child1b'], false),
          ListenForResize(testEl.$['shadow1c'].$['resizable'], false),
          ListenForResize(testEl.$['shadow1d'].$['resizable'], false)
        ];

        var el = new PolymerDom(testEl.root).querySelector('#parent');

        (el.parentNode as Element).children.remove(el);

        await wait(1);
        try {
          window.dispatchEvent(new CustomEvent('resize', canBubble: false));
          expect(pendingNotifications, 0);
          RemoveListeners(listeners);
          done();
        } catch (e) {
          done(e);
        }
      }));
    });


    group('x-resizer-parent-filtered', () {
      test('notify resizables from window', () {
        pendingNotifications=0;
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
      }, skip: 'https://github.com/dart-lang/polymer_elements/issues/60');
    });
  });
}
