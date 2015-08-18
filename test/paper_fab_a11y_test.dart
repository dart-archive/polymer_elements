@TestOn('browser')
library polymer_elements.test.paper_fab_a11y_test;

import 'package:polymer_elements/paper_fab.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<paper-fab>', () {
    PaperFab f1;
    PaperFab f2;
    PaperFab f3;

    setUp(() {
      List<PaperFab> fabs = fixture('A11yFabs');
      f1 = fabs[0];
      f2 = fabs[1];
      f3 = fabs[2];
    });

    test('aria role is a button', () {
      expect(f1.getAttribute('role'), equals('button'));
    });

    test('aria-disabled is set', () {
      expect(f2.getAttribute('aria-disabled'), isNotNull);
      f2.jsElement.callMethod('removeAttribute', ['disabled']);
      expect(f2.getAttribute('aria-disabled'), equals('false'));
    });

    test('user-defined aria-label is preserved', () {
      expect(f3.getAttribute('aria-label'), equals('custom'));
      f3.icon = 'arrow-forward';
      expect(f3.getAttribute('aria-label'), equals('custom'));
    });
  });
}
