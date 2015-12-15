@TestOn('browser')
library polymer_elements.test.iron_behavior_active_state_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'fixtures/iron_behavior_elements.dart';
import 'common.dart';
import 'package:polymer_elements/paper_input.dart';

main() async {
  await initPolymer();

  group('active-state', () {
    TestButton activeTarget;

    setUp(() {
      activeTarget = fixture('TrivialActiveState');
    });

    group('active state with toggles attribute', () {
      setUp(() {
        activeTarget = fixture('ToggleActiveState');
      });

      group('when down', () {
        test('is pressed', () {
          down(activeTarget);
          expect(activeTarget.getAttribute('pressed'), isNotNull);
        });
      });

      group('when clicked', () {
        test('is activated', () {
          var done = new Completer();
          downAndUp(activeTarget, () {
            try {
              expect(activeTarget.getAttribute('active'), isNotNull);
              expect(activeTarget.getAttribute('aria-pressed'), isNotNull);
              expect(activeTarget.getAttribute('aria-pressed'), 'true');
              done.complete();
            } catch (e) {
              done.complete(e);
            }
          });
          return done.future;
        });

        test('is deactivated by a subsequent click', () {
          var done = new Completer();
          downAndUp(activeTarget, () {
            downAndUp(activeTarget, () {
              try {
                expect(activeTarget.getAttribute('active'), isNull);
                expect(activeTarget.getAttribute('aria-pressed'), isNotNull);
                expect(activeTarget.getAttribute('aria-pressed'), 'false');
                done.complete();
              } catch (e) {
                done.complete(e);
              }
            });
          });
          return done.future;
        });

        test('the correct aria attribute is set', () {
          var done = new Completer();
          activeTarget.ariaActiveAttribute = 'aria-checked';
          downAndUp(activeTarget, () {
            try {
              expect(activeTarget.getAttribute('active'), isNotNull);
              expect(activeTarget.getAttribute('aria-checked'), isNotNull);
              expect(activeTarget.getAttribute('aria-checked'), 'true');
              done.complete();
            } catch (e) {
              done.complete(e);
            }
          });
          return done.future;
        });

        test('the aria attribute is updated correctly', () {
          var done = new Completer();
          activeTarget.ariaActiveAttribute = 'aria-checked';
          downAndUp(activeTarget, () {
            try {
              expect(activeTarget.getAttribute('active'), isNotNull);
              expect(activeTarget.getAttribute('aria-checked'), isNotNull);
              expect(activeTarget.getAttribute('aria-checked'), 'true');

              activeTarget.ariaActiveAttribute = 'aria-pressed';
              expect(activeTarget.getAttribute('aria-checked'), isNull);
              expect(activeTarget.getAttribute('aria-pressed'), isNotNull);
              expect(activeTarget.getAttribute('aria-pressed'), 'true');
              done.complete();
            } catch (e) {
              done.complete(e);
            }
          });
          return done.future;
        });
      });
    });

    group('without toggles attribute', () {
      group('when mouse is down', () {
        test('does not get an active attribute', () {
          expect(activeTarget.getAttribute('active'), isNull);
          down(activeTarget);
          expect(activeTarget.getAttribute('active'), isNull);
        });
      });

      group('when mouse is up', () {
        test('does not get an active attribute', () {
          down(activeTarget);
          expect(activeTarget.getAttribute('active'), isNull);
          up(activeTarget);
          expect(activeTarget.getAttribute('active'), isNull);
        });
      });
    });

    group('when space is pressed', () {
      test('triggers a click event', () {
        var done = new Completer();
        activeTarget.on['click'].take(1).listen((_) {
          done.complete();
        });
        pressSpace(activeTarget);
        return done.future;
      });

      test('only triggers click after the key is released', () {
        var done = new Completer();
        var keyupTriggered = false;

        activeTarget.on['keyup'].take(1).listen((_) {
          keyupTriggered = true;
        });

        activeTarget.on['click'].take(1).listen((_) {
          try {
            expect(keyupTriggered, true);
            done.complete();
          } catch (e) {
            done.complete(e);
          }
        });

        pressSpace(activeTarget);
        return done.future;
      });
    });

    group('when enter is pressed', () {
      test('triggers a click event', () {
        var done = new Completer();
        activeTarget.on['click'].take(1).listen((_) {
          done.complete();
        });

        pressEnter(activeTarget);
        return done.future;
      });

      test('only triggers click before the key is released', () {
        var done = new Completer();
        var keyupTriggered = false;

        activeTarget.on['keyup'].take(1).listen((_) {
          keyupTriggered = true;
        });

        activeTarget.on['click'].take(1).listen((_) {
          try {
            expect(keyupTriggered, false);
            done.complete();
          } catch (e) {
            done.complete(e);
          }
        });

        pressEnter(activeTarget);
        return done.future;
      });
    });

    group('nested input inside button', () {
      test('space in light child input does not trigger a button click event',
          () async {
        var done = new Completer();
        var item = fixture('ButtonWithNativeInput');
        var input = item.querySelector('#input');

        var callCount = 0;
        item.on['click'].take(1).listen((_) {
          callCount++;
        });

        input.focus();
        pressSpace(input);
        await wait(100);
        expect(callCount, 0);
      });

      test('space in button triggers a button click event', () async {
        var item = fixture('ButtonWithNativeInput');
        var input = item.querySelector('#input');

        var callCount = 0;
        item.on['click'].take(1).listen((_) {
          callCount++;
        });

        pressSpace(item);

        await wait(100);
        expect(callCount, 1);
      });
    });

    group('nested paper-input inside button', () {
      test('space in light child input does not trigger a button click event', () async {
        var item = fixture('ButtonWithPaperInput');
        var input = item.querySelector('#input');

        var callCount = 0;
        item.on['click'].take(1).listen((_) {
          callCount++;
        });

        input.focus();
        pressSpace(input);
        await wait(0);
        expect(callCount, 0);
      });

      test('space in button triggers a button click event', () async {
        var item = fixture('ButtonWithPaperInput');
        var input = item.querySelector('#input');

        var callCount = 0;
        item.on['click'].take(1).listen((_) {
          callCount++;
        });

        pressSpace(item);
        await wait(0);
        expect(callCount, 1);
      });
    });
  });
}
