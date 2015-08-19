@TestOn('browser')
library polymer_elements.test.paper_radio_button_basic_test;

import 'dart:async';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_elements/paper_radio_button.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('defaults', () {
    PaperRadioButton r1;
    setUp(() {
      r1 = fixture('NoLabel');
    });
    test('check button via click', () async {
      var completer = new Completer();
      r1.on['click'].take(1).listen((event) {
        expect(r1.attributes['aria-checked'], 'true');
        expect(r1.checked, isTrue);
        completer.complete();
      });
      // **Dart Note**: Using `tap` instead of `down` to get test to pass.
      tap(r1);
      await completer.future;
    });

    test('toggle button via click', () async {
      r1.checked = true;
      var completer = new Completer();
      r1.on['click'].take(1).listen((event) {
        expect(r1.attributes['aria-checked'], 'false');
        expect(r1.checked, isFalse);
        completer.complete();
      });
      // **Dart Note**: Using `tap` instead of `down` to get test to pass.
      tap(r1);
      await completer.future;
    });

    test('disabled button cannot be clicked', () async {
      r1.disabled = true;
      var completer = new Completer();
      r1.on['click'].take(1).listen((event) {
        // **Dart Note**: Expect `false`, js test is wrong.
        expect(r1.attributes['aria-checked'], 'false');
        expect(r1.checked, isFalse);
        completer.complete();
      });
      // **Dart Note**: Using `tap` instead of `down` to get test to pass.
      tap(r1);
      await completer.future;
    });
  });

  group('a11y', () {
    PaperRadioButton r1;
    PaperRadioButton r2;

    setUp(() {
      r1 = fixture('NoLabel');
      r2 = fixture('WithLabel');
    });

    test('has aria role "radio"', () {
      expect(r1.attributes['role'], equals('radio'));
      expect(r2.attributes['role'], equals('radio'));
    });

    test('button with no label has no aria label', () {
      expect(r1.attributes.containsKey('aria-label'), isFalse);
    });

    test('button with a label sets an aria label', () {
      expect(r2.attributes['aria-label'], equals("Batman"));
    });

    test('button respects the user set aria-label', () {
      var c = fixture('AriaLabel');
      expect(c.attributes['aria-label'], equals("Batman"));
    });
  });
}
