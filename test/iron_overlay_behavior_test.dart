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

runAfterOpen(overlay, cb) {
  overlay.on['iron-overlay-opened'].take(1).listen((_) {
    cb();
  });
  overlay.open();
}

main() async {
  await initWebComponents();

  group('basic overlay tests', () {
    TestOverlay overlay;

    setUp(() {
      overlay = fixture('basic');
    });

    test('overlay starts hidden', () {
      expect(overlay.opened, isFalse, reason: 'overlay starts closed');
      expect(overlay.getComputedStyle().display, 'none',
          reason: 'overlay starts hidden');
    });

    test('overlay open by default', () {
      overlay = fixture('opened');
      runAfterOpen(overlay, () {
        expect(overlay.opened, isTrue, reason: 'overlay starts opened');
        expect(overlay.getComputedStyle().display, isNot('none'),
            reason: 'overlay starts showing');
      });
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

    test('clicking an overlay does not close it', () {
      var done = new Completer();
      runAfterOpen(overlay, () {
        overlay.on['iron-overlay-closed'].take(1).listen((_) {
          // Test cleanup causes this to fire.
          if (done.isCompleted) return;
          done.completeError('iron-overlay-closed should not fire');
        });
        overlay.fire('click');
        wait(10).then((_) {
          done.complete();
        });
      });
      return done.future;
    });

    test('node with autofocus is focused', () {
      var done = new Completer();
      overlay = fixture('autofocus');
      runAfterOpen(overlay, () {
        expect(Polymer.dom(overlay).querySelector('[autofocus]'),
            document.activeElement,
            reason: '<button autofocus> is focused');
        done.complete();
      });
      return done.future;
    });

    test('cancel an overlay by clicking outside', () {
      var done = new Completer();
      runAfterOpen(overlay, () {
        overlay.on['iron-overlay-closed'].take(1).listen((event) {
          expect(eventDetail(event)['canceled'], isTrue,
              reason: 'overlay is canceled');
          done.complete();
        });
        fireEvent('click', null, document);
      });
      return done.future;
    });

    test('cancel an overlay with esc key', () {
      var done = new Completer();
      runAfterOpen(overlay, () {
        overlay.on['iron-overlay-closed'].take(1).listen((event) {
          expect(eventDetail(event)['canceled'], isTrue,
              reason: 'overlay is canceled');
          done.complete();
        });
        fireEvent('keydown', {'keyCode': 27}, document);
      });
      return done.future;
    });

    test('no-cancel-on-outside-click property', () {
      var done = new Completer();
      overlay.noCancelOnOutsideClick = true;
      runAfterOpen(overlay, () {
        overlay.on['iron-overlay-closed'].take(1).listen((_) {
          // Test cleanup causes this to fire.
          if (done.isCompleted) return;
          done.completeError('iron-overlay-closed should not fire');
        });
        fireEvent('click', null, document);
        wait(10).then((_) {
          done.complete();
        });
      });
      return done.future;
    });

    test('no-cancel-on-esc-key property', () {
      var done = new Completer();
      overlay.noCancelOnEscKey = true;
      runAfterOpen(overlay, () {
        overlay.on['iron-overlay-closed'].take(1).listen((_) {
          // Test cleanup causes this to fire.
          if (done.isCompleted) return;
          done.completeError('iron-overlay-cancel should not fire');
        });
        fireEvent('keydown', {'keyCode': 27}, document);
        wait(10).then((_) {
          done.complete();
        });
      });
      return done.future;
    });
  });

  group('multiple overlays', () {
    List<TestOverlay> overlays;

    setUp(() {
      overlays = fixture('multiple');
    });

    test('new overlays appear on top', () {
      var done = new Completer();
      runAfterOpen(overlays[0], () {
        runAfterOpen(overlays[1], () {
          var styleZ = int.parse(overlays[0].getComputedStyle().zIndex);
          var styleZ1 = int.parse(overlays[1].getComputedStyle().zIndex);
          expect(styleZ1, greaterThan(styleZ),
              reason: 'overlays[1] has higher z-index than overlays[0]');
          done.complete();
        });
      });
      return done.future;
    });
  });

  group('overlays with backdrop', () {
    List<TestOverlay> overlays;

    setUp(() {
      overlays = fixture('backdrop-multiple');
    });

    test('backdrop appears behind the overlay', () {
      var done = new Completer();
      runAfterOpen(overlays[0], () {
        expect(overlays[0].backdropElement, isNotNull,
            reason: 'backdrop is defined');
        expect(overlays[0].backdropElement.parentNode, isNotNull,
            reason: 'backdrop is inserted in the DOM');

        var styleZ = int.parse(overlays[0].getComputedStyle().zIndex);
        var backdropStyleZ =
            int.parse(overlays[0].backdropElement.getComputedStyle().zIndex);
        expect(styleZ, greaterThan(backdropStyleZ),
            reason: 'overlay has higher z-index than backdrop');
        done.complete();
      });
      return done.future;
    });

    test('backdrop is removed when the element is removed from DOM', () {
      var done = new Completer();
      runAfterOpen(overlays[0], () {
        var backdrop = overlays[0].backdropElement;
        Polymer.dom(backdrop.parentNode).removeChild(backdrop);
        PolymerDom.flush();
        expect(backdrop.parentNode, isNull,
            reason: 'backdrop is removed from DOM');
        done.complete();
      });
      return done.future;
    });

    test('backdrop is opened when iron-overlay-open-completed fires', () {
      var done = new Completer();
      runAfterOpen(overlays[0], () {
        expect(overlays[0].backdropElement.opened, isTrue,
            reason: 'backdrop is opened');
        done.complete();
      });
      return done.future;
    });
  });

  group('multiple overlays with backdrop', () {
    List<TestOverlay> overlays;

    setUp(() {
      overlays = fixture('backdrop-multiple');
    });

    test('multiple overlays share the same backdrop', () {
      expect(
          identical(overlays[0].backdropElement, overlays[1].backdropElement),
          isTrue,
          reason: 'overlays[0] has the same backdrop element as overlays[1]');
    });

    test('newest overlay appear on top', () {
      var done = new Completer();
      runAfterOpen(overlays[0], () {
        runAfterOpen(overlays[1], () {
          var styleZ = int.parse(overlays[0].getComputedStyle().zIndex);
          var style1Z = int.parse(overlays[1].getComputedStyle().zIndex);
          var bgStyleZ =
              int.parse(overlays[0].backdropElement.getComputedStyle().zIndex);
          expect(style1Z, greaterThan(styleZ),
              reason: 'overlays[1] has higher z-index than overlays[0]');
          expect(styleZ, greaterThan(bgStyleZ),
              reason: 'overlays[0] has higher z-index than backdrop');
          done.complete();
        });
      });
      return done.future;
    });
  });

  group('a11y', () {
    test('overlay has aria-hidden=true when opened', () {
      TestOverlay overlay = fixture('basic');
      expect(overlay.getAttribute('aria-hidden'), 'true',
          reason: 'overlay has aria-hidden="true"');
      overlay.open();
      expect(overlay.getAttribute('aria-hidden'), isNull,
          reason: 'overlay does not have aria-hidden attribute');
      return wait(1).then((_) {
        overlay.close();
        expect(overlay.getAttribute('aria-hidden'), 'true',
          reason: 'overlay has aria-hidden="true"');
      });
    });
  });
}
