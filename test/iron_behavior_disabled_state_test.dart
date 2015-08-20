@TestOn('browser')
library polymer_elements.test.iron_behavior_disabled_state_test;

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

  group('disabled-state', () {
    TestControl disableTarget;

    group('a trivial disabled state', () {
      setUp(() {
        disableTarget = fixture('TrivialDisabledState');
      });

      group('when disabled is true', () {
        test('receives a disabled attribute', () {
          disableTarget.disabled = true;
          expect(disableTarget.getAttribute('disabled'), isNotNull);
        });

        test('receives an appropriate aria attribute', () {
          disableTarget.disabled = true;
          expect(disableTarget.getAttribute('aria-disabled'), 'true');
        });
      });

      group('when disabled is false', () {
        test('loses the disabled attribute', () {
          disableTarget.disabled = true;
          expect(disableTarget.getAttribute('disabled'), isNotNull);
          disableTarget.disabled = false;
          expect(disableTarget.getAttribute('disabled'), isNull);
        });
      });
    });

    group('a state with an initially disabled target', () {
      setUp(() {
        disableTarget = fixture('InitiallyDisabledState');
      });

      test('preserves the disabled attribute on target', () {
        expect(disableTarget.getAttribute('disabled'), isNotNull);
        expect(disableTarget.disabled, true);
      });

      test('adds `aria-disabled` to the target', () {
        expect(disableTarget.getAttribute('aria-disabled'), 'true');
      });
    });
  });
}
