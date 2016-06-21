@TestOn('browser')
library polymer_elements.test.iron_overlay_behavior_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';

import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';

import 'common.dart';
import 'fixtures/test_overlay.dart';
import 'fixtures/test_overlay2.dart';
import 'sinon/sinon.dart';
import 'package:polymer_elements/iron_overlay_manager.dart';
import 'fixtures/test_buttons.dart';
import 'package:polymer_elements/iron_overlay_backdrop.dart';
import 'fixtures/test_menu_button.dart';

Future runAfterOpen(overlay, cb) {
  Completer completer = new Completer();
  overlay.on['iron-overlay-opened'].take(1).listen((_) async {
    await wait(1);
    await cb();
    completer.complete();
  });
  overlay.open();
  return completer.future;
}

Future runAfterClose(overlay, cb) {
  Completer completer = new Completer();
  overlay.on['iron-overlay-closed'].take(1).listen((_) async {
    await wait(1);
    await cb();
    completer.complete();
  });
  overlay.close();
  return completer.future;
}

final JsObject _IronOverlayManager = context['Polymer']['IronOverlayManager'];

main() async {
  await initPolymer();

  //context['Polymer']['Gesture'].callMethod('add', [document, 'tap', null]);

  group('basic overlay tests', () {
    TestOverlay overlay;

    setUp(() async {
      overlay = fixture('basic');
      await new Future(() {});
    });

    test('overlay starts hidden', () {
      expect(overlay.opened, isFalse, reason: 'overlay starts closed');
      expect(overlay.getComputedStyle().display, 'none', reason: 'overlay starts hidden');
    });

    test('_renderOpened called only after is attached', when((done) async {
      TestOverlay overlay = document.createElement('test-overlay');
      // The overlay is ready at this point, but not yet attached.
      Spy _spy = spy(overlay.jsElement, '_renderOpened');
      // This triggers _openedChanged.
      overlay.opened = true;
      // Wait long enough for requestAnimationFrame callback.
      await wait(100);
      $assert.isFalse(_spy.called, '_renderOpened not called');
      // Because not attached yet, overlay should not be the current overlay!
      $assert.isNotOk(overlay.jsElement['_manager'].callMethod('currentOverlay'), 'currentOverlay not set');
      done();
    }));

    test('overlay open/close events', () {
      var done = new Completer();
      var nevents = 0;

      overlay.on['iron-overlay-opened'].take(1).listen((_) {
        nevents += 1;
        overlay.opened = false;
      });

      overlay.on['iron-overlay-closed'].take(1).listen((_) {
        nevents += 1;
        expect(nevents, 2, reason: 'opened and closed events fired');
        done.complete();
      });

      overlay.opened = true;
      return done.future;
    });

    test('open() refits overlay only once', () {
      Spy _spy = spy(overlay.jsElement, 'refit');
      return runAfterOpen(overlay, () {
        expect(_spy.callCount, 1, reason: 'overlay did refit only once');
      });
    });

    test('open overlay refits on iron-resize', () async {
      await runAfterOpen(overlay, () async {
        Spy _spy = spy(overlay.jsElement, 'refit');
        overlay.fire('iron-resize');
        PolymerDom.flush();
        await requestAnimationFrame();
        expect(_spy.called, isTrue, reason: 'overlay did refit');
      });
    });

    test('closed overlay does not refit on iron-resize', () async {
      Spy _spy = spy(overlay.jsElement, 'refit');
      overlay.fire('iron-resize');
      PolymerDom.flush();
      await requestAnimationFrame();
      expect(_spy.called, isFalse, reason: 'overlay should not refit');
    });

    test('open() triggers iron-resize', () async {
      var callCount = 0;
      // Ignore iron-resize triggered by window resize.
      window.onResize.take(1).listen((_) {
        callCount--;
      });
      overlay.on['iron-resize'].take(1).listen((_) {
        callCount++;
      });
      await runAfterOpen(overlay, () {
        expect(callCount, 1, reason: 'iron-resize called once before iron-overlay-opened');
      });
    });

    test('close() triggers iron-resize', () async {
      return runAfterOpen(overlay, () {
        var spy = new Stub();
        overlay.on['iron-resize'].listen(spy);
        return runAfterClose(overlay, () {
          expect(spy.calls, 1, reason: 'iron-resize called once before iron-overlay-closed');
        });
      });
    });

    test('closed overlay does not trigger iron-resize when its content changes', () {
      // Ignore iron-resize triggered by window resize.
      var callCount = 0;
      window.onResize.take(1).listen((_) {
        callCount--;
      });
      overlay.on['iron-resize'].take(1).listen((_) {
        callCount++;
      });
      new PolymerDom(overlay).append(document.createElement('div'));
      PolymerDom.flush();
      expect(callCount, 0, reason: 'iron-resize should not be called');
    });

    test('open overlay triggers iron-resize when its content changes', () {
      return runAfterOpen(overlay, () {
        Stub spy = new Stub();
        overlay.on['iron-resize'].take(1).listen(spy);
        new PolymerDom(overlay).append(new Element.tag('div'));
        PolymerDom.flush();
        expect(spy.calls, 1, reason: 'iron-resize should be called once');
      });
    });

    test('close an overlay quickly after open', () {
      var done = new Completer();
      // first, open the overlay
      overlay.open();
      overlay.async(() {
        // during the opening transition, close the overlay
        overlay.close();
        // wait for any exceptions to be thrown until the transition is done
        overlay.async(() {
          done.complete();
        }, waitTime: 300);
      });
      return done.future;
    });

    test('clicking an overlay does not close it', () async {
      await runAfterOpen(overlay, () async {
        Stub spy = new Stub();
        overlay.on['iron-overlay-closed'].take(1).listen(spy);
        tap(overlay);
        await wait(10);
        expect(spy.calls, 0, reason: 'iron-overlay-closed should not fire');
      });
    });

    test('open overlay on mousedown does not close it', () async {
      var btn = document.createElement('button');
      btn.onMouseDown.take(1).listen((_) {
        overlay.open();
      });
      document.body.children.add(btn);
      // It triggers mousedown, mouseup, and click.
      tap(btn);
      document.body.children.remove(btn);

      expect(overlay.opened, isTrue, reason: 'overlay opened');
      await wait(10);

      expect(overlay.opened, isTrue, reason: 'overlay is still open');
    });

    test('clicking outside fires iron-overlay-canceled', () async {
      await runAfterOpen(overlay, () {
        Completer done = new Completer();
        overlay.on['iron-overlay-canceled'].take(1).listen((event) {
          expect(new CustomEventWrapper(event).detail.target, document.body, reason: 'detail contains original click event');
          done.complete();
        });
        tap(document.body);
        return done.future;
      });
    });

    test('clicking outside closes the overlay', () async {
      await runAfterOpen(overlay, () {
        Completer done = new Completer();
        overlay.on['iron-overlay-closed'].take(1).listen((event) {
          expect(new CustomEventWrapper(event).detail['canceled'], isTrue, reason: 'overlay is canceled');
          done.complete();
        });
        tap(document.body);
        return done.future;
      });
    });

    test('iron-overlay-canceled event can be prevented', () async {
      await runAfterOpen(overlay, () async {
        overlay.on['iron-overlay-canceled'].take(1).listen((event) {
          event.preventDefault();
        });
        Stub spy = new Stub();
        overlay.on['iron-overlay-closed'].take(1).listen(spy);
        tap(document.body);
        await wait(10);
        expect(overlay.opened, isTrue, reason: 'overlay is still open');
        expect(spy.calls, 0, reason: 'iron-overlay-closed not fired');
      });
    });

    test('cancel an overlay with esc key', () async {
      await runAfterOpen(overlay, () {
        Completer done = new Completer();
        overlay.on['iron-overlay-canceled'].take(1).listen((event) {
          expect(new CustomEventWrapper(event).detail.type, 'keydown');
          done.complete();
        });
        pressAndReleaseKeyOn(document, 27);
        return done.future;
      });
    });

    test('close an overlay with esc key', () async {
      await runAfterOpen(overlay, () {
        Completer done = new Completer();
        overlay.on['iron-overlay-closed'].take(1).listen((event) {
          expect(new CustomEventWrapper(event).detail['canceled'], isTrue, reason: 'overlay is canceled');
          done.complete();
        });
        pressAndReleaseKeyOn(document, 27);
        return done.future;
      });
    });

    test('no-cancel-on-outside-click property', () async {
      overlay.noCancelOnOutsideClick = true;
      await runAfterOpen(overlay, () async {
        Stub spy = new Stub();
        overlay.on['iron-overlay-closed'].take(1).listen(spy);
        tap(document.body);
        await wait(10);
        expect(spy.calls, 0, reason: 'iron-overlay-closed should not fire');
      });
    });

    test('no-cancel-on-esc-key property', () async {
      overlay.noCancelOnEscKey = true;
      await runAfterOpen(overlay, () async {
        var spy = new Stub();
        overlay.on['iron-overlay-closed'].take(1).listen(spy);
        pressAndReleaseKeyOn(document, 27);
        await wait(10);
        expect(spy.calls, 0, reason: 'iron-overlay-cancel should not fire');
      });
    });

    test('with-backdrop sets tabindex=-1 and removes it', () {
      overlay.withBackdrop = true;
      expect(overlay.attributes['tabindex'], '-1', reason: 'tabindex is -1');
      overlay.withBackdrop = false;
      expect(overlay.attributes.containsKey('tabindex'), isFalse, reason: 'tabindex removed');
    });

    test('with-backdrop does not override tabindex if already set', () {
      overlay.attributes['tabindex'] = '1';
      overlay.withBackdrop = true;
      expect(overlay.attributes['tabindex'], '1', reason: 'tabindex is 1');
      overlay.withBackdrop = false;
      expect(overlay.attributes['tabindex'], '1', reason: 'tabindex is still 1');
    });
  });

  group('keyboard event listener', () {
    TestOverlay overlay;

    Function preventKeyDown = (event) {
      event.preventDefault();
      event.stopPropagation();
    };

    setUpAll(() {
      // Worst case scenario: listener with useCapture = true that prevents & stops propagation
      // added before the overlay is initialized.
      document.addEventListener('keydown', preventKeyDown, true);
    });

    setUp(() {
      overlay = fixture('basic');
    });

    tearDownAll(() {
      document.removeEventListener('keydown', preventKeyDown, true);
    });

    test('cancel an overlay with esc key even if event is prevented by other listeners', () async {
      await runAfterOpen(overlay, () {
        Completer done = new Completer();
        overlay.on['iron-overlay-canceled'].take(1).listen((event) {
          done.complete();
        });
        pressAndReleaseKeyOn(document, 27);
        return done.future;
      });
    });
  });

  group('opened overlay', () {
    TestOverlay overlay;

    setUp(() {
      overlay = fixture('opened');
    });

    test('overlay open by default', () async {
      Completer done = new Completer();
      overlay.on['iron-overlay-opened'].take(1).listen((_) {
        expect(overlay.opened, isTrue, reason: 'overlay starts opened');
        expect(overlay.getComputedStyle().display, isNot('none'), reason: 'overlay starts showing');
        done.complete();
      });

      await done.future;
    });

    test('overlay positioned & sized properly', () async {
      Completer done = new Completer();
      overlay.on['iron-overlay-opened'].take(1).listen((_) {
        var s = overlay.getComputedStyle();
        expect(parseFloat(s.left), closeTo((window.innerWidth - overlay.offsetWidth) / 2, 1), reason: 'centered horizontally');
        expect(parseFloat(s.top), closeTo((window.innerHeight - overlay.offsetHeight) / 2, 1), reason: 'centered vertically');
        done.complete();
      });
      await done.future;
    });
  });

  group('focus handling', () {
    TestOverlay overlay;

    setUp(() {
      overlay = fixture('autofocus');
    });

    test('node with autofocus is focused', () async {
      await runAfterOpen(overlay, () {
        expect(new PolymerDom(overlay).querySelector('[autofocus]'), document.activeElement, reason: '<button autofocus> is focused');
      });
    });

    test('no-auto-focus will not focus node with autofocus', () async {
      overlay.noAutoFocus = true;

      // In Safari the element with autofocus will immediately receive focus when displayed for the first time http://jsbin.com/woroci/2/
      // Ensure this is not the case for overlay.
      expect(new PolymerDom(overlay).querySelector('[autofocus]'), isNot(document.activeElement), reason: '<button autofocus> not immediately focused');

      await runAfterOpen(overlay, () {
        expect(new PolymerDom(overlay).querySelector('[autofocus]'), isNot(document.activeElement), reason: '<button autofocus> not focused after opened');
      });
    });

    test('no-cancel-on-outside-click property; focus stays on overlay when click outside', () async {
      overlay.noCancelOnOutsideClick = true;
      await runAfterOpen(overlay, () async {
        tap(document.body);
        await wait(10);
        expect(new PolymerDom(overlay).querySelector('[autofocus]'), document.activeElement, reason: '<button autofocus> is focused');
      });
    });

    test('with-backdrop traps the focus within the overlay', () async {
      Stub focusSpy = new Stub();
      var button = document.createElement('button');
      document.body.children.add(button);
      button.addEventListener('focus', focusSpy, true);

      overlay.withBackdrop = true;
      await runAfterOpen(overlay, () {
        // Try to steal the focus
        focus(button);
        expect(new PolymerDom(overlay).querySelector('[autofocus]'), document.activeElement, reason: '<button autofocus> is focused');
        expect(focusSpy.calls, 0, reason: 'button in body did not get the focus');
        document.body.children.remove(button);
      });
    });

    test('overlay with-backdrop and 1 focusable: prevent TAB and trap the focus', when((done) {
      overlay.withBackdrop = true;
      runAfterOpen(overlay, () async {
        // 1ms timeout needed by IE10 to have proper focus switching.
        await wait(1);
        // Spy keydown.
        bool defaultPrevented;
        int calls = 0;
        StreamSubscription sub = document.on['keydown'].listen((Event evt) {
          defaultPrevented = evt.defaultPrevented;
          calls++;
        });
        // Simulate TAB.
        pressAndReleaseKeyOn(document, 9);
        $assert.equal(new PolymerDom(overlay).querySelector('[autofocus]'), document.activeElement, 'focus stays on button');
        $assert.isTrue(calls == 1, 'keydown spy called');
        $assert.isTrue(defaultPrevented, 'keydown default prevented');
        // Cleanup.
        sub.cancel();
        done();
      });
    }));

    test('empty overlay with-backdrop: prevent TAB and trap the focus', when((done) {
      overlay = fixture('basic');
      overlay.withBackdrop = true;
      runAfterOpen(overlay, () async {
        // 1ms timeout needed by IE10 to have proper focus switching.
        await wait(1);
        // Spy keydown.
        bool defaultPrevented;
        int calls = 0;
        StreamSubscription sub = document.on['keydown'].listen((Event evt) {
          defaultPrevented = evt.defaultPrevented;
          calls++;
        });
        // Simulate TAB.
        pressAndReleaseKeyOn(document, 9);
        $assert.equal(overlay, document.activeElement, 'focus stays on overlay');
        $assert.isTrue(calls == 1, 'keydown spy called');
        $assert.isTrue(defaultPrevented, 'keydown default prevented');
        // Cleanup.
        sub.cancel();
        done();
      });
    }));
  });

  group('focusable nodes', () {
    TestOverlay overlay;
    TestOverlay overlayWithTabIndex;
    TestOverlay2 overlayFocusableNodes;

    setUp(() {
      var f = fixture('focusables');
      overlay = f[0];
      overlayWithTabIndex = f[1];
      overlayFocusableNodes = f[2];
    });

    test('_focusableNodes returns nodes that are focusable', () {
      var focusableNodes = overlay.jsElement["_focusableNodes"];
      expect(focusableNodes.length, 3, reason: '3 nodes are focusable');
      expect(focusableNodes[0], Polymer.dom(overlay).querySelector('.focusable1'));
      expect(focusableNodes[1], Polymer.dom(overlay).querySelector('.focusable2'));
      expect(focusableNodes[2], Polymer.dom(overlay).querySelector('.focusable3'));
    });

    test('_focusableNodes includes overlay if it has a valid tabindex', () {
      overlay.setAttribute('tabindex', '0');
      var focusableNodes = overlay.jsElement["_focusableNodes"];
      expect(focusableNodes.length, 4, reason: '4 focusable nodes');
      expect(focusableNodes.indexOf(overlay), isNot(-1), reason: 'overlay is included');
    });

    test('_focusableNodes respects the tabindex order', () {
      var focusableNodes = overlayWithTabIndex.jsElement["_focusableNodes"];
      expect(focusableNodes.length, 6, reason: '6 nodes are focusable');
      expect(focusableNodes[0], Polymer.dom(overlayWithTabIndex).querySelector('.focusable1'));
      expect(focusableNodes[1], Polymer.dom(overlayWithTabIndex).querySelector('.focusable2'));
      expect(focusableNodes[2], Polymer.dom(overlayWithTabIndex).querySelector('.focusable3'));
      expect(focusableNodes[3], Polymer.dom(overlayWithTabIndex).querySelector('.focusable4'));
      expect(focusableNodes[4], Polymer.dom(overlayWithTabIndex).querySelector('.focusable5'));
      expect(focusableNodes[5], Polymer.dom(overlayWithTabIndex).querySelector('.focusable6'));
    });

    test('_focusableNodes can be overridden', () {
      // It has 1 focusable in the light dom, and 2 in the shadow dom.
      List<Element> focusableNodes = overlayFocusableNodes.focusableNodes;
      $assert.equal(focusableNodes.length, 2, 'length ok');
      $assert.equal(focusableNodes[0], overlayFocusableNodes.$['first'], 'first ok');
      $assert.equal(focusableNodes[1], overlayFocusableNodes.$['last'], 'last ok');
    });

    test('with-backdrop: TAB & Shift+TAB wrap focus', when((done) {
      overlay.withBackdrop = true;
      List<Element> focusableNodes = overlay.jsElement['_focusableNodes'];
      runAfterOpen(overlay, () async {
        // 1ms timeout needed by IE10 to have proper focus switching.
        await wait(1);
        // Go to last element.
        focusableNodes[focusableNodes.length - 1].focus();
        // Spy keydown.
        await wait(1);
        // Spy keydown.
        List<bool> defaultPrevented = [];

        StreamSubscription sub = document.on['keydown'].listen((Event evt) {
          defaultPrevented.add(evt.defaultPrevented);
        });
        // Simulate TAB.
        pressAndReleaseKeyOn(document, 9);
        $assert.equal(focusableNodes[0], document.activeElement, 'focus wrapped to first focusable');
        $assert.isTrue(defaultPrevented.length == 1, 'keydown spy called');
        $assert.isTrue(defaultPrevented[0], 'keydown default prevented');
        // Simulate Shift+TAB.
        pressAndReleaseKeyOn(document, 9, ['shift']);
        $assert.equal(focusableNodes[focusableNodes.length - 1], document.activeElement, 'focus wrapped to last focusable');
        $assert.isTrue(defaultPrevented.length == 2, 'keydown spy called again');
        $assert.isTrue(defaultPrevented[1], 'keydown default prevented again');
        // Cleanup.
        sub.cancel();
        done();
      });
    }));

    test('with-backdrop: TAB & Shift+TAB wrap focus respecting tabindex', when((done) {
      overlayWithTabIndex.withBackdrop = true;
      List<Element> focusableNodes = overlayWithTabIndex.jsElement['_focusableNodes'];
      runAfterOpen(overlayWithTabIndex, () async {
        // 1ms timeout needed by IE10 to have proper focus switching.
        await wait(1);
        // Go to last element.
        focusableNodes[focusableNodes.length - 1].focus();
        // Simulate TAB.
        pressAndReleaseKeyOn(document, 9);
        $assert.equal(focusableNodes[0], document.activeElement, 'focus wrapped to first focusable');
        // Simulate Shift+TAB.
        pressAndReleaseKeyOn(document, 9, ['shift']);
        $assert.equal(focusableNodes[focusableNodes.length - 1], document.activeElement, 'focus wrapped to last focusable');
        done();
      });
    }));

    test('with-backdrop: Shift+TAB after open wrap focus', when((done) {
      overlay.withBackdrop = true;
      var focusableNodes = overlay.jsElement['_focusableNodes'];
      runAfterOpen(overlay, () async {
        // 1ms timeout needed by IE10 to have proper focus switching.
        await wait(1);
        // Spy keydown.
        List<bool> defaultPrevented = [];

        StreamSubscription sub = document.on['keydown'].listen((Event evt) {
          defaultPrevented.add(evt.defaultPrevented);
        });
        // Simulate Shift+TAB.
        pressAndReleaseKeyOn(document, 9, ['shift']);
        $assert.equal(focusableNodes[focusableNodes.length - 1], document.activeElement, 'focus wrapped to last focusable');
        $assert.isTrue(defaultPrevented.length == 1, 'keydown spy called');
        $assert.isTrue(defaultPrevented[0], 'keydown default prevented');
        // Cleanup.
        sub.cancel();
        done();
      });
    }));

    test('with-backdrop: Shift+TAB wrap focus in shadowDOM', when((done) {
      overlayFocusableNodes.withBackdrop = true;
      runAfterOpen(overlayFocusableNodes, () async {
        // 1ms timeout needed by IE10 to have proper focus switching.
        await wait(1);
        // Spy keydown.
        List<bool> defaultPrevented = [];

        StreamSubscription sub = document.on['keydown'].listen((Event evt) {
          defaultPrevented.add(evt.defaultPrevented);
        });
        // Simulate Shift+TAB.
        pressAndReleaseKeyOn(document, 9, ['shift']);
        $assert.equal(overlayFocusableNodes.$['last'], IronOverlayManager.deepActiveElement, 'focus wrapped to last focusable in the shadowDOM');
        $assert.isTrue(defaultPrevented.length == 1, 'keydown spy called');
        $assert.isTrue(defaultPrevented.single, 'keydown default prevented');
        // Cleanup.
        sub.cancel();
        done();
      });
    }));
  });

  onFocus(Element e, cb) async {
    Completer c = new Completer();
    e.onFocus.take(1).listen((_) {
      cb();
      c.complete();
    });
    e.focus();
    await c.future;
  }

  group('Polymer.IronOverlayManager.deepActiveElement', () {
    test('handles document.body', () async {
      await onFocus(document.body, () {
        expect(IronOverlayManager.deepActiveElement, document.body);
      });
    }, skip: "focus not working on test runner ?");

    test('handles light dom', () async {
      var focusable = document.getElementById('focusInput');
      await onFocus(focusable, () {
        expect(IronOverlayManager.deepActiveElement, focusable, reason: 'input is handled');
        focusable.blur();
      });
    }, skip: "focus not working on test runner ?");

    test('handles shadow dom', () async {
      var focusable = (document.getElementById('buttons') as TestButtons).button0;
      await onFocus(focusable, () {
        expect(IronOverlayManager.deepActiveElement, focusable);
        focusable.blur();
      });
    }, skip: "focus not working on test runner ?");
  });

  group('restore-focus-on-close', () {
    var overlay;
    setUp(() {
      overlay = fixture('autofocus');
      overlay.restoreFocusOnClose = true;
    });

    tearDown(() {
      // No matter what, return the focus to body!
      document.body.focus();
    });

    test('does not return focus on close by default (restore-focus-on-close=false)', () async {
      overlay.restoreFocusOnClose = false;
      var focusable = document.getElementById('focusInput');
      focusable.focus();
      await runAfterOpen(overlay, () async {
        await runAfterClose(overlay, () {
          expect(IronOverlayManager.deepActiveElement, isNot(focusable), reason: 'focus is not restored to focusable');
        });
      });
    }, skip: "focus not working on test runner ?");

    test('overlay returns focus on close', () async {
      var focusable = document.getElementById('focusInput');
      focusable.focus();
      await runAfterOpen(overlay, () async {
        await runAfterClose(overlay, () {
          expect(IronOverlayManager.deepActiveElement, focusable, reason: 'focus restored to focusable');
        });
      });
    }, skip: "focus not working on test runner ?");

    test('overlay returns focus on close (ShadowDOM)', () async {
      var focusable = (document.getElementById('buttons') as TestButtons).button0;
      focusable.focus();
      await runAfterOpen(overlay, () async {
        await runAfterClose(overlay, () async {
          expect(IronOverlayManager.deepActiveElement, focusable, reason: 'focus restored to focusable');
        });
      });
    }, skip: "focus not working on test runner ?");

    test('overlay does not return focus to elements contained in another overlay', () async {
      var overlay2 = fixture('basic');
      // So it doesn't interfere with focus changes.
      overlay2.noAutoFocus = true;
      var focusable = document.createElement('input');
      await runAfterOpen(overlay2, () async {
        new PolymerDom(overlay2).append(focusable);
        focusable.focus();
        await runAfterOpen(overlay, () async {
          await runAfterClose(overlay, () {
            expect(IronOverlayManager.deepActiveElement, isNot(focusable), reason: 'focus not restored to focusable inside overlay2');
          });
        });
      });
    }, skip: "focus not working on test runner ?");

    test('overlay does not return focus to elements that are not in the body anymore', () async {
      InputElement focusable = document.createElement('input');
      document.body.children.add(focusable);
      focusable.focus();
      Spy focusSpy = spy(new JsObject.fromBrowserObject(focusable), 'focus');
      await runAfterOpen(overlay, () async {
        document.body.children.remove(focusable);
        await runAfterClose(overlay, () {
          expect(focusSpy.called, isFalse, reason: 'focus not called');
        });
      });
    }, skip: "focus not working on test runner ?");
  }, skip: "focus not working on test runner ?");

  group('overlay with backdrop', () {
    TestOverlay overlay;

    setUp(() {
      overlay = fixture('backdrop');
    });

    test('backdrop is opened when overlay is opened', () async {
      expect(overlay.backdropElement, isNotNull, reason: 'backdrop is defined');
      await runAfterOpen(overlay, () {
        expect((overlay.backdropElement as IronOverlayBackdrop).opened, isTrue, reason: 'backdrop is opened');
        expect(overlay.backdropElement.parentNode, isNotNull, reason: 'backdrop is inserted in the DOM');
      });
    });

    test('backdrop appears behind the overlay', () async {
      await runAfterOpen(overlay, () {
        int styleZ = parseFloat(overlay.getComputedStyle().zIndex).floor();
        int backdropStyleZ = parseFloat(overlay.backdropElement.getComputedStyle().zIndex).floor();
        expect(styleZ > backdropStyleZ, isTrue, reason: 'overlay has higher z-index than backdrop');
      });
    });

    test('backdrop is removed when overlay is closed', () async {
      await runAfterOpen(overlay, () async {
        await runAfterClose(overlay, () async {
          expect((overlay.backdropElement as IronOverlayBackdrop).opened, isFalse, reason: 'backdrop is closed');
          expect(overlay.backdropElement.parentNode, isNull, reason: 'backdrop is removed from the DOM');
          expect(document.querySelectorAll('iron-overlay-backdrop').length, 0, reason: 'no backdrop elements on body');
        });
      });
    });

    test('backdrop is removed when the element is removed from DOM', () async {
      await runAfterOpen(overlay, () {
        (new PolymerDom(overlay).parentNode as Element).children.remove(overlay);
        // Ensure detached is executed.
        PolymerDom.flush();
        expect((overlay.backdropElement as IronOverlayBackdrop).opened, isFalse, reason: 'backdrop is closed');
        expect(overlay.backdropElement.parentNode, isNull, reason: 'backdrop is removed from the DOM');
        expect(document.querySelectorAll('iron-overlay-backdrop').length, 0, reason: 'no backdrop elements on body');
        expect(overlay.jsElement['_manager'].callMethod('currentOverlay'), isNull, reason: 'currentOverlay ok');
        expect(IronOverlayManager.currentOverlay, isNull, reason: 'currentOverlay ok'); // dam0vm3nt : same test with IronOverlayMan
      });
    });

    test('manager.getBackdrops() immediately updated on opened changes', when((done) {
      runAfterOpen(overlay, () {
        overlay.opened = true;
        expect(IronOverlayManager.backdrops.length, 1, reason: 'overlay added to manager backdrops');
        overlay.opened = false;
        expect(IronOverlayManager.backdrops.length, 0, reason: 'overlay removed from manager backdrops');
        done();
      });
    }));

    test('updating with-backdrop to false closes backdrop', () async {
      await runAfterOpen(overlay, () {
        overlay.withBackdrop = false;
        expect((overlay.backdropElement as IronOverlayBackdrop).opened, isFalse, reason: 'backdrop is closed');
        expect(overlay.backdropElement.parentNode, isNull, reason: 'backdrop is removed from document');
      });
    });

    test('backdrop is removed when toggling overlay opened', () async {
      overlay.open();
      await runAfterClose(overlay, () {
        expect((overlay.backdropElement as IronOverlayBackdrop).opened, isFalse, reason: 'backdrop is closed');
        expect(overlay.backdropElement.parentNode, isNull, reason: 'backdrop is removed from document');
      });
    });

    test('withBackdrop = false does not prevent click outside event', when((done) {
      overlay.withBackdrop = false;
      runAfterOpen(overlay, () {
        overlay.on['iron-overlay-canceled'].take(1).listen((event) {
          CustomEventWrapper customEventWrapper = new CustomEventWrapper(event);
          $assert.isFalse(customEventWrapper.detail.defaultPrevented, 'click event not prevented');
          done();
        });
        tap(document.body);
      });
    }));
  });

  int parseInt(x, [_]) => parseFloat(x).floor();

  group('multiple overlays', () {
    TestOverlay overlay1, overlay2;

    setUp(() {
      var f = fixture('multiple');
      overlay1 = f[0];
      overlay2 = f[1];
    });

    test('new overlays appear on top', () async {
      await runAfterOpen(overlay1, () async {
        await runAfterOpen(overlay2, () {
          var styleZ = parseInt(overlay1.getComputedStyle().zIndex);
          var styleZ1 = parseInt(overlay2.getComputedStyle().zIndex);
          expect(styleZ1 > styleZ, isTrue, reason: 'overlay2 has higher z-index than overlay1');
        });
      });
    });

    test('ESC closes only the top overlay', () async {
      await runAfterOpen(overlay1, () async {
        await runAfterOpen(overlay2, () {
          pressAndReleaseKeyOn(document, 27);
          expect(overlay2.opened, isFalse, reason: 'overlay2 was closed');
          expect(overlay1.opened, isTrue, reason: 'overlay1 is still opened');
        });
      });
    });

    test('close an overlay in proximity to another overlay', () async {
      // Open and close a separate overlay.
      overlay1.open();
      overlay1.close();

      // Open the overlay we care about.
      overlay2.open();

      // Immediately close the first overlay.
      // Wait for infinite recursion, otherwise we win.
      await runAfterClose(overlay2, () {});
    });
  });

  group('Manager overlays in sync', () {
    TestOverlay overlay1, overlay2;
    List overlays;

    setUp(() {
      var f = fixture('multiple');
      overlay1 = f[0];
      overlay2 = f[1];
      overlays = IronOverlayManager.jsObject["_overlays"];
    });

    test('no duplicates after attached', () async {
      overlay1 = new Element.tag('test-overlay');
      Completer done = new Completer();
      runAfterOpen(overlay1, () {
        expect(overlays.length, 1, reason: 'correct count after open and attached');
        document.body.children.remove(overlay1);
        done.complete();
      });
      document.body.children.add(overlay1);
      await done.future;
    });

    test('call open multiple times handled', when((done) {
      overlay1.open();
      overlay1.open();
      runAfterOpen(overlay1, () {
        $assert.equal(overlays.length, 1, '1 overlay after open');
        done();
      });
    }));

    test('close handled', when((done) {
      runAfterOpen(overlay1, () {
        overlay1.close();
        $assert.equal(overlays.length, 0, '0 overlays after close');
        done();
      });
    }));

    test('open/close brings overlay on top', when((done) {
      overlay1.open();
      runAfterOpen(overlay2, () {
        $assert.equal(overlays.indexOf(overlay1), 0, 'overlay1 at index 0');
        $assert.equal(overlays.indexOf(overlay2), 1, 'overlay2 at index 1');
        overlay1.close();
        runAfterOpen(overlay1, () {
          $assert.equal(overlays.indexOf(overlay1), 1, 'overlay1 moved at index 1');
          $assert.isAbove(parseInt(overlay1.style.zIndex), parseInt(overlay2.style.zIndex), 'overlay1 on top of overlay2');
          done();
        });
      });
    }));
  });

  group('z-ordering', () {
    int originalMinimumZ;
    TestOverlay overlay1, overlay2;

    setUp(() {
      var f = fixture('multiple');
      overlay1 = f[0];
      overlay2 = f[1];
      originalMinimumZ = IronOverlayManager.jsObject["_minimumZ"];
    });

    tearDown(() {
      IronOverlayManager.jsObject['_minimumZ'] = originalMinimumZ;
    });

    // for iframes
    test('default z-index is greater than 100', when((done) {
      runAfterOpen(overlay1, () {
        var styleZ = parseInt(overlay1.getComputedStyle().zIndex);
        expect(styleZ > 100, isTrue, reason: 'overlay1 z-index is <= 100');
        done();
      });
    }));

    test('ensureMinimumZ() effects z-index', when((done) {
      IronOverlayManager.ensureMinimumZ(1000);

      runAfterOpen(overlay1, () {
        var styleZ = parseInt(overlay1.getComputedStyle().zIndex);
        expect(styleZ > 1000, isTrue, reason: 'overlay1 z-index is <= 1000');
        done();
      });
    }));

    test('ensureMinimumZ() never decreases the minimum z-index', when((done) {
      IronOverlayManager.ensureMinimumZ(1000);
      IronOverlayManager.ensureMinimumZ(500);

      runAfterOpen(overlay1, () {
        var styleZ = parseInt(overlay1.getComputedStyle().zIndex);
        expect(styleZ > 1000, isTrue, reason: 'overlay1 z-index is <= 1000');
        done();
      });
    }));
  });

  group('multiple overlays with backdrop', () {
    TestOverlay overlay1, overlay2;
    TestOverlay2 overlay3;

    setUp(() {
      var f = fixture('multiple');
      overlay1 = f[0];
      overlay2 = f[1];
      overlay3 = f[2];
      overlay1.withBackdrop = overlay2.withBackdrop = overlay3.withBackdrop = true;
    });

    test('multiple overlays share the same backdrop', () {
      expect(overlay1.backdropElement == overlay2.backdropElement, isTrue, reason: 'overlay1 and overlay2 have the same backdrop element');
      expect(overlay1.backdropElement == overlay3.backdropElement, isTrue, reason: 'overlay1 and overlay3 have the same backdrop element');
    });

    test('only one iron-overlay-backdrop in the DOM', when((done) {
      // Open them all.
      overlay1.opened = true;
      overlay2.opened = true;
      runAfterOpen(overlay3, () {
        $assert.lengthOf(document.querySelectorAll('iron-overlay-backdrop'), 1, 'only one backdrop element in the DOM');
        done();
      });
    }));

    test('iron-overlay-backdrop is removed from the DOM when all overlays with backdrop are closed', when((done) {
      // Open & close them all.
      overlay1.opened = true;
      overlay2.opened = true;
      runAfterOpen(overlay3, () {
        overlay1.opened = overlay2.opened = overlay3.opened = false;
        PolymerDom.flush();
        $assert.lengthOf(document.querySelectorAll('iron-overlay-backdrop'), 0, 'backdrop element removed from the DOM');
        done();
      });
    }));

    test('newest overlay appear on top', when((done) {
      runAfterOpen(overlay1, () {
        runAfterOpen(overlay2, () {
          var styleZ = parseInt(overlay1.getComputedStyle().zIndex);
          var style1Z = parseInt(overlay2.getComputedStyle().zIndex);
          var bgStyleZ = parseInt(overlay1.backdropElement.getComputedStyle().zIndex);
          expect(style1Z > styleZ, isTrue, reason: 'overlay2 has higher z-index than overlay1');
          expect(styleZ > bgStyleZ, isTrue, reason: 'overlay1 has higher z-index than backdrop');
          done();
        });
      });
    }));

    test('click events handled only by top overlay', when((done) {
      var btn = new Element.tag('button');
      btn.on['tap'].take(1).listen((_) {
        overlay2.close();
      });
      new PolymerDom(overlay2).append(btn);
      runAfterOpen(overlay1, () {
        runAfterOpen(overlay2, () async {
          tap(btn);
          expect(overlay2.opened, isFalse, reason: 'overlay2 closed');
          expect(overlay1.opened, isTrue, reason: 'overlay1 still opened');
          done();
        });
      });
    }), skip: "Is this test correct ?");

    test('updating with-backdrop updates z-index', when((done) {
      runAfterOpen(overlay1, () {
        runAfterOpen(overlay2, () {
          overlay1.withBackdrop = false;
          var styleZ = parseInt(overlay1.getComputedStyle().zIndex);
          var style1Z = parseInt(overlay2.getComputedStyle().zIndex);
          var bgStyleZ = parseInt(overlay1.backdropElement.getComputedStyle().zIndex);
          expect(style1Z > bgStyleZ, isTrue, reason: 'overlay2 has higher z-index than backdrop');
          expect(styleZ < bgStyleZ, isTrue, reason: 'overlay1 has lower z-index than backdrop');
          done();
        });
      });
    }));
  });

  group('overlay in composed tree', () {
    TestMenuButton composed;
    TestOverlay overlay;
    Element trigger;
    setup(when((done) {
      composed = fixture('composed');
      overlay = composed.overlay;
      trigger = composed.trigger;
      overlay.withBackdrop = true;
      overlay.on['iron-overlay-opened'].take(1).listen((_) {
        done();
      });
      // Opens the overlay.
      tap(trigger);
    }));

    test('click on overlay content does not close it', when((done) async {
      // Tap on button inside overlay.
      tap(Polymer.dom(overlay).querySelector('button'));
      await wait(1);
      $assert.isTrue(overlay.opened, 'overlay still opened');
      done();
    }));

    test('with-backdrop wraps the focus within the overlay', when((done) async {
      // 1ms timeout needed by IE10 to have proper focus switching.
      await wait(1);
      var buttons = Polymer.dom(overlay).querySelectorAll('button');
      // Go to last element.
      buttons[buttons.length - 1].focus();
      // Spy keydown.
      List<bool> defaultPrevented = [];

      StreamSubscription sub = document.on['keydown'].listen((Event evt) {
        defaultPrevented.add(evt.defaultPrevented);
      });
      // Simulate TAB.
      pressAndReleaseKeyOn(document, 9);
      $assert.equal(buttons[0], IronOverlayManager.deepActiveElement, 'focus wrapped to first focusable');
      $assert.isTrue(defaultPrevented.length == 1, 'keydown spy called');
      $assert.isTrue(defaultPrevented[0], 'keydown default prevented');
      // Simulate Shift+TAB.
      pressAndReleaseKeyOn(document, 9, ['shift']);
      $assert.equal(buttons[buttons.length - 1], IronOverlayManager.deepActiveElement, 'focus wrapped to last focusable');
      $assert.isTrue(defaultPrevented.length == 2, 'keydown spy called again');
      $assert.isTrue(defaultPrevented[1], 'keydown default prevented again');
      // Cleanup.
      sub.cancel();
      done();
    }));
  });

  group('always-on-top', () {
    TestOverlay overlay1, overlay2;

    setUp(() {
      var f = fixture('multiple');
      overlay1 = f[0];
      overlay2 = f[1];
      overlay1.alwaysOnTop = true;
    });

    test('stays on top', when((done) {
      runAfterOpen(overlay1, () {
        runAfterOpen(overlay2, () {
          int zIndex1 = parseInt(overlay1.getComputedStyle().zIndex);
          var zIndex2 = parseInt(overlay2.getComputedStyle().zIndex);
          expect(zIndex1 > zIndex2, isTrue, reason: 'overlay1 on top');
          expect(IronOverlayManager.currentOverlay, overlay1, reason: 'currentOverlay ok');
          done();
        });
      });
    }));

    test('stays on top also if another overlay is with-backdrop', when((done) {
      overlay2.withBackdrop = true;
      runAfterOpen(overlay1, () {
        runAfterOpen(overlay2, () {
          int zIndex1 = parseInt(overlay1.getComputedStyle().zIndex, 10);
          int zIndex2 = parseInt(overlay2.getComputedStyle().zIndex, 10);
          expect(zIndex1 > zIndex2, isTrue, reason: 'overlay1 on top');
          expect(IronOverlayManager.currentOverlay, overlay1, reason: 'currentOverlay ok');
          done();
        });
      });
    }));

    test('last overlay with always-on-top wins', when((done) {
      overlay2.alwaysOnTop = true;
      runAfterOpen(overlay1, () {
        runAfterOpen(overlay2, () {
          var zIndex1 = parseInt(overlay1.getComputedStyle().zIndex, 10);
          var zIndex2 = parseInt(overlay2.getComputedStyle().zIndex, 10);
          expect(zIndex2 > zIndex1, isTrue, reason: 'overlay2 on top');
          expect(IronOverlayManager.currentOverlay, overlay2, reason: 'currentOverlay ok');
          done();
        });
      });
    }));
  });

  group('animations', () {
    test('overlay animations correctly triggered', when((done) {
      var overlay = fixture('basic');
      overlay.animated = true;
      overlay.open();
      overlay.on['simple-overlay-open-animation-start'].take(1).listen((_) {
        // Since animated overlay will transition center + 300px to center,
        // we should not find the element at the center when the open animation starts.
        var centerElement = document.elementFromPoint((window.innerWidth / 2).floor(), (window.innerHeight / 2).floor());
        expect(centerElement, isNot(overlay), reason: 'overlay should not be centered already');
        done();
      });
    }), skip: "will not work in test runner ?");
  });

  group('a11y', () {
    test('overlay has aria-hidden=true when opened', () {
      TestOverlay overlay = fixture('basic');
      expect(overlay.attributes['aria-hidden'], 'true', reason: 'overlay has aria-hidden="true"');
      overlay.open();
      expect(overlay.attributes.containsKey('aria-hidden'), isFalse, reason: 'overlay does not have aria-hidden attribute');
      overlay.close();
      expect(overlay.attributes['aria-hidden'], 'true', reason: 'overlay has aria-hidden="true"');
    });
  });
}
