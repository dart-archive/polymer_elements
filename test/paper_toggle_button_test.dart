@TestOn('browser')
library polymer_elements.test.paper_toggle_button_test;

import 'dart:async';
import 'package:polymer_elements/paper_toggle_button.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

/**
 * Original tests:
 * https://github.com/PolymerElements/paper-toggle-button/tree/master/test
 */

main() async {
  await initWebComponents();

  group('defaults', () {
    PaperToggleButton b1;

    setUp(() {
      b1 = fixture('basic');
    });

    test('check button via click', () {
      Completer done = new Completer();

      b1.on['click'].take(1).listen((_) {
        expect(b1.getAttribute('aria-checked'), equals(isTrue));
        expect(b1.checked, isTrue);
        done.complete();
      });

      tap(b1);

      return done.future;
    }, skip: 'https://github.com/dart-lang/polymer_elements/issues/47');

    test('toggle button via click', () {
      Completer done = new Completer();

      b1.checked = true;

      b1.on['click'].take(1).listen((_) {
        expect(b1.getAttribute('aria-checked'), equals(isFalse));
        expect(b1.checked, isFalse);
        done.complete();
      });

      tap(b1);

      return done.future;
    }, skip: 'https://github.com/dart-lang/polymer_elements/issues/47');

    test('disabled button cannot be clicked', () {
      Completer done = new Completer();

      b1.disabled = true;

      b1.on['click'].take(1).listen((_) {
        expect(b1.getAttribute('aria-checked'), equals(isTrue));
        expect(b1.checked, isTrue);
        done.complete();
      });

      tap(b1);

      return done.future;
    }, skip: 'https://github.com/dart-lang/polymer_elements/issues/47');
  });

  group('a11y', () {
    PaperToggleButton b1;

    setUp(() {
      b1 = fixture('basic');
    });

    test('has aria role "button"', () {
      expect(b1.getAttribute('role'), equals('button'));
    });
  });
}
