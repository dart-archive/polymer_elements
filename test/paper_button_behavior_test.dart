@TestOn('browser')
library polymer_elements.test.paper_button_behavior_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_a11y_keys_behavior.dart';
import 'package:polymer_elements/iron_button_state.dart';
import 'package:polymer_elements/iron_control_state.dart';
import 'package:polymer_elements/paper_button_behavior.dart';
import 'package:polymer_elements/paper_ripple_behavior.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initPolymer();

  group('basic', () {
    TestButton button;

    setUp(() {
      button = fixture('basic');
    });

    test('normal (no states)', () {
      expect(button.elevation, 1);
    });

    test('set disabled property', () {
      button.disabled = true;
      expect(button.elevation, 0);
    });

    test('pressed and released', () {
      down(button);
      expect(button.elevation, 4);
      up(button);
      expect(button.elevation, 1);
    });

    group('a button with toggles', () {
      setUp(() {
        button.toggles = true;
      });

      test('activated by tap', () {
        var done = new Completer();
        downAndUp(button, () {
          expect(button.elevation, 4);
          expect(button.hasRipple(), isTrue);
          done.complete();
        });
        return done.future;
      });
    });

    test('receives focused', () {
      focus(button);
      expect(button.elevation, 3);
      expect(button.hasRipple(), isTrue);
    });

    test('space key', when((done) {
      const SPACE_KEY_CODE = 32;
      var ripple;
      focus(button);

      $assert.ok(button.hasRipple());

      ripple = button.getRipple();
      keyDownOn(button, SPACE_KEY_CODE);

      $assert.equal(ripple.ripples.length, 1);

      keyDownOn(button, SPACE_KEY_CODE);

      $assert.equal(ripple.ripples.length, 1);

      keyUpOn(button, SPACE_KEY_CODE);

      var transitionEndCalled = false;
      ripple.on['transitionend'].take(1).listen((_) {
        if (!transitionEndCalled) {
          transitionEndCalled = true;
          $assert.equal(ripple.ripples.length, 0);
          done();
        }
      });
    }));
  });
}

@PolymerRegister('test-button')
class TestButton extends PolymerElement
    with
        IronA11yKeysBehavior,
        IronButtonState,
        IronControlState,
        PaperRippleBehavior,
        PaperButtonBehavior {
  TestButton.created() : super.created();
}
