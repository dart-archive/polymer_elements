@TestOn('browser')
library polymer_elements.test.iron_behavior_active_state_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'fixtures/iron_behavior_elements.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('active-state', () {
    TestButton activeTarget;

    setUp(() {
      activeTarget = fixture('TrivialActiveState');
    });

    group('non-primary pointer input source', () {
      test('does not cause state to change', () {
        var rightClickMouseEvent = new CustomEvent('mousedown');
        new JsObject.fromBrowserObject(rightClickMouseEvent)['buttons'] = 2;
        activeTarget.dispatchEvent(rightClickMouseEvent);
        expect(activeTarget.pressed, false);
      });
    });

    group('active state with toggles attribute', () {
      setUp(() {
        activeTarget = fixture('ToggleActiveState');
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
  });
}
