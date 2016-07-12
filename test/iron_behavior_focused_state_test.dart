@TestOn('browser')
library polymer_elements.test.iron_behavior_focused_state_test;

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
import 'sinon/sinon.dart';

main() async {
  await initPolymer();

  group('focused-state', () {
    TestControl focusTarget;

    setUp(() {
      focusTarget = fixture('TrivialFocusedState');
    });

    group('when is focused', () {
      test('receives a focused attribute', () {
        expect(focusTarget.getAttribute('focused'), isNull);
        focus(focusTarget);
        expect(focusTarget.getAttribute('focused'), isNotNull);
      });

      test('focused property is true', () {
        expect(focusTarget.focused, isFalse);
        focus(focusTarget);
        expect(focusTarget.focused, true);
      });
    });

    group('when is blurred', () {
      test('loses the focused attribute', () {
        focus(focusTarget);
        expect(focusTarget.getAttribute('focused'), isNotNull);
        blur(focusTarget);
        expect(focusTarget.getAttribute('focused'), isNull);
      });

      test('focused property is false', () {
        focus(focusTarget);
        expect(focusTarget.focused, true);
        blur(focusTarget);
        expect(focusTarget.focused, false);
      });
    });

    group('when the focused state is disabled', () {
      test('will not be focusable', () async {
        Spy blurSpy = spy(focusTarget.jsElement, 'blur');

        focus(focusTarget);
        focusTarget.disabled = true;
        expect(focusTarget.getAttribute('tabindex'), '-1');
        expect(blurSpy.called, true);
      });
    });
  });

  group('nested focusable', () {
    var focusable;

    setUp(() {
      focusable = fixture('NestedFocusedState');
    });

    test('focus/blur events fired on host element', () {
      var nFocusEvents = 0;
      var nBlurEvents = 0;

      focusable.on['focus'].take(1).listen((_) {
        nFocusEvents += 1;
        expect(focusable.focused, true);
        blur(focusable.$['input']);
      });
      focusable.on['blur'].take(1).listen((_) {
        expect(focusable.focused, false);
        nBlurEvents += 1;
      });

      focus(focusable.$['input']);

      expect(nBlurEvents, greaterThan(0));
      expect(nFocusEvents, greaterThan(0));
    });
  });

  group('elements in the light dom', () {
    var lightDOM, input;
    var lightDescendantShadowInput;

    setUp(() {
      lightDOM = fixture('LightDOM');
      input = document.querySelector('#input');
      lightDescendantShadowInput = (new PolymerDom(lightDOM).querySelector('nested-focusable') as PolymerElement).$['input'];
    });

    test('should not fire the focus event', () {
      var nFocusEvents = 0;

      lightDOM.on['focus'].take(1).listen((_) {
        nFocusEvents += 1;
      });

      focus(input);

      expect(nFocusEvents, 0);
    });

    test('should not fire the focus event from shadow descendants', () {
      var nFocusEvents = 0;

      lightDOM.on['focus'].take(1).listen((_) {
        nFocusEvents += 1;
      });

      focus(lightDescendantShadowInput);

      $expect(nFocusEvents).to.be.equal(0);
    });
  });
}
