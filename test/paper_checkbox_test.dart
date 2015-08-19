@TestOn('browser')
library polymer_elements.test.paper_checkbox_test;

import 'dart:async';
import 'package:polymer_elements/paper_checkbox.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('defaults', () {
    PaperCheckbox c1;

    setUp(() {
      c1 = fixture('NoLabel');
    });

    test('check checkbox via click', () {
      Completer done = new Completer();

      c1.on['click'].take(1).listen((_) {
        expect(c1.getAttribute('aria-checked'), equals('true'));
        expect(c1.checked, isTrue);
        done.complete();
      });
      tap(c1);

      return done.future;
    });

    test('toggle checkbox via click', () {
      Completer done = new Completer();
      c1.checked = true;

      c1.on['click'].take(1).listen((_) {
        expect(c1.getAttribute('aria-checked'), equals('false'));
        expect(c1.checked, isFalse);
        done.complete();
      });
      tap(c1);

      return done.future;
    });

    test('disabled checkbox cannot be clicked', () {
      Completer done = new Completer();
      c1.disabled = true;
      c1.checked = true;

      c1.on['click'].take(1).listen((_) {
        expect(c1.getAttribute('aria-checked'), equals('true'));
        expect(c1.checked, isTrue);
        done.complete();
      });
      tap(c1);

      return done.future;
    });
  });

  group('a11y', () {
    PaperCheckbox c1;
    PaperCheckbox c2;

    setUp(() {
      c1 = fixture('NoLabel');
      c2 = fixture('WithLabel');
    });

    test('has aria role "checkbox"', () {
      expect(c1.getAttribute('role'), equals('checkbox'));
      expect(c2.getAttribute('role'), equals('checkbox'));
    });

    test('checkbox with no label has no aria label', () {
      expect(c1.getAttribute('aria-label'), isNull);
    });

    test('checkbox with a label sets an aria label', () {
      expect(c2.getAttribute('aria-label'), equals("Batman"));
    });

    test('checkbox respects the user set aria-label', () {
      PaperCheckbox c = fixture('AriaLabel');
      expect(c.getAttribute('aria-label'), equals("Batman"));
    });
  });
}
