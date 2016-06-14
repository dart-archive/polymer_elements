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



}
