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
import 'sinon/sinon.dart';
import 'package:polymer_elements/iron_overlay_manager.dart';
import 'fixtures/test_buttons.dart';
import 'package:polymer_elements/iron_overlay_backdrop.dart';

num parseFloat(String dimension) {
  return num.parse(dimension.replaceAll("px",""));
}

Future runAfterOpen(overlay, cb) {
  Completer completer= new Completer();
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

  group('basic overlay tests', () {
    TestOverlay overlay;

    setUp(() async {
      overlay = fixture('basic');
      await new Future(() {});
    });

    test('overlay starts hidden', () {
      expect(overlay.opened, isFalse, reason: 'overlay starts closed');
      expect(overlay
                 .getComputedStyle()
                 .display, 'none',
                 reason: 'overlay starts hidden');
    });

    test('overlay open by default', () async {
      overlay = fixture('opened');
      await overlay.on['iron-overlay-opened'].first;
      expect(overlay.opened, isTrue, reason: 'overlay starts opened');
      expect(overlay
                 .getComputedStyle()
                 .display, isNot('none'),
                 reason: 'overlay starts showing');
    });

    test('overlay positioned & sized properly', () async {
      overlay = fixture('opened');
      await overlay.on['iron-overlay-opened'].first;
      var s = overlay.getComputedStyle();
      expect(double.parse(s.left.replaceFirst('px', '')),
                 (window.innerWidth - overlay.offsetWidth) / 2,
                 reason: 'centered horizontally');
      expect(double.parse(s.top.replaceFirst('px', '')),
                 (window.innerHeight - overlay.offsetHeight) / 2,
                 reason: 'centered vertically');
    });

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
        expect(overlay
                   .getComputedStyle()
                   .display, isNot('none'), reason: 'overlay starts showing');
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
  });

  group('focusable nodes', () {
    TestOverlay overlay;
    TestOverlay overlayWithTabIndex;

    setUp(() {
      var f = fixture('focusables');
      overlay = f[0];
      overlayWithTabIndex = f[1];
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

    test('with-backdrop: TAB & Shift+TAB wrap focus', () async {
      overlay.withBackdrop = true;
      var focusableNodes = overlay.jsElement["_focusableNodes"];
      await runAfterOpen(overlay, () async {
        await wait(1);
        // Go to last element.
        focus(focusableNodes[focusableNodes.length - 1]);
        // Simulate TAB & focus out of overlay.
        pressAndReleaseKeyOn(document, 9);
        focus(document.body);

        expect(focusableNodes[0], document.activeElement, reason: 'focus wrapped to first focusable');
        // Simulate Shift+TAB & focus out of overlay.
        pressAndReleaseKeyOn(document, 9, ['shift']);
        focus(document.body);
        expect(focusableNodes[focusableNodes.length - 1], document.activeElement, reason: 'focus wrapped to last focusable');
      });
    });

    test('with-backdrop: TAB & Shift+TAB wrap focus respecting tabindex', () async {
      overlayWithTabIndex.withBackdrop = true;
      var focusableNodes = overlayWithTabIndex.jsElement['_focusableNodes'];
      await runAfterOpen(overlayWithTabIndex, () async {
        await wait(1);
        // Go to last element.
        focus(focusableNodes[focusableNodes.length - 1]);
        // Simulate TAB & focus out of overlay.
        pressAndReleaseKeyOn(document, 9);
        focus(document.body);
        expect(focusableNodes[0], document.activeElement, reason: 'focus wrapped to first focusable');
        // Simulate Shift+TAB & focus out of overlay.
        pressAndReleaseKeyOn(document, 9, ['shift']);
        focus(document.body);
        expect(focusableNodes[focusableNodes.length - 1], document.activeElement, reason: 'focus wrapped to last focusable');
      });
    });
  });

  onFocus(Element e,cb) async {
    Completer c = new Completer();
    e.onFocus.take(1).listen((_){
      cb();
      c.complete();
    });
    e.focus();
    await c.future;
  }

  group('Polymer.IronOverlayManager.deepActiveElement', () {
    test('handles document.body', () async {
      await onFocus(document.body,() {
        expect(IronOverlayManager.deepActiveElement, document.body);
      });
    },skip:"focus not working on test runner ?");

    test('handles light dom', () async {
      var focusable = document.getElementById('focusInput');
      await onFocus(focusable,() {
        expect(IronOverlayManager.deepActiveElement, focusable, reason: 'input is handled');
        focusable.blur();
      });
    }, skip:"focus not working on test runner ?");

    test('handles shadow dom', () async {
      var focusable = (document.getElementById('buttons') as TestButtons).button0;
      await onFocus(focusable, () {
        expect(IronOverlayManager.deepActiveElement, focusable);
        focusable.blur();
      });
    },skip:"focus not working on test runner ?");
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
    });

    test('overlay returns focus on close', () async {
      var focusable = document.getElementById('focusInput');
      focusable.focus();
      await runAfterOpen(overlay, () async {
        await runAfterClose(overlay, () {
          expect(IronOverlayManager.deepActiveElement, focusable, reason: 'focus restored to focusable');
        });
      });
    });

    test('overlay returns focus on close (ShadowDOM)', () async {
      var focusable = (document.getElementById('buttons') as TestButtons).button0;
      focusable.focus();
      await runAfterOpen(overlay, () async {
        await runAfterClose(overlay, () async {
          expect(IronOverlayManager.deepActiveElement, focusable, reason: 'focus restored to focusable');
        });
      });
    });

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
    });

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
    });
  });

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
        int styleZ = parseFloat(overlay
                                    .getComputedStyle()
                                    .zIndex).floor();
        int backdropStyleZ = parseFloat(overlay.backdropElement
                                            .getComputedStyle()
                                            .zIndex).floor();
        expect(styleZ > backdropStyleZ, isTrue, reason: 'overlay has higher z-index than backdrop');
      });
    });

    test('backdrop is removed when overlay is closed', () async {
      await runAfterOpen(overlay, () async {
        await runAfterClose(overlay, () async {
          expect((overlay.backdropElement as IronOverlayBackdrop).opened, isFalse, reason: 'backdrop is closed');
          expect(overlay.backdropElement.parentNode, isNull, reason: 'backdrop is removed from the DOM');
          expect(document
                     .querySelectorAll('iron-overlay-backdrop')
                     .length, 0, reason: 'no backdrop elements on body');
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
        expect(document
                   .querySelectorAll('iron-overlay-backdrop')
                   .length, 0, reason: 'no backdrop elements on body');
        expect(overlay.jsElement['_manager'].callMethod('currentOverlay'), isNull, reason: 'currentOverlay ok');
        expect(IronOverlayManager.currentOverlay, isNull, reason: 'currentOverlay ok'); // dam0vm3nt : same test with IronOverlayMan

      });
    });

    test('manager.getBackdrops() immediately updated on opened changes', () {
      overlay.opened = true;
      expect(IronOverlayManager.backdrops.length, 1, reason: 'overlay added to manager backdrops');
      overlay.opened = false;
      expect(IronOverlayManager.backdrops.length, 0, reason: 'overlay removed from manager backdrops');
    });

    test('updating with-backdrop to false closes backdrop', () async {
      await runAfterOpen(overlay, () {
        overlay.withBackdrop = false;
        expect((overlay.backdropElement as IronOverlayBackdrop).opened, isFalse, reason: 'backdrop is closed');
        expect(overlay.backdropElement.parentNode, isNull, reason: 'backdrop is removed from document');
      });
    });

    test('backdrop is removed when toggling overlay opened', () async {
      overlay.open();
      expect(overlay.backdropElement.parentNode, isNotNull, reason: 'backdrop is immediately inserted in the document');
      await runAfterClose(overlay, () {
        expect((overlay.backdropElement as IronOverlayBackdrop).opened, isFalse, reason: 'backdrop is closed');
        expect(overlay.backdropElement.parentNode, isNull, reason: 'backdrop is removed from document');
      });
    });
  });


}
