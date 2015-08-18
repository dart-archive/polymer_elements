@TestOn('browser')
library polymer_elements.test.paper_icon_button_a11y_test;

import 'package:polymer_elements/paper_icon_button.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<paper-icon-button>', () {
    List<PaperIconButton> iconButtons;
    PaperIconButton b1, b2, b3, b4, b5;

    setUp(() {
      iconButtons = fixture('A11yIconButtons');
      b1 = iconButtons[0];
      b2 = iconButtons[1];
      b3 = iconButtons[2];
      b4 = iconButtons[3];
      b5 = iconButtons[4];
    });

    test('aria role is a button', () {
      expect(b1.getAttribute('role'), equals('button'));
    });

    test('aria-disabled is set', () {
      expect(b2.getAttribute('aria-disabled'), equals('true'));
      b2.attributes.remove('disabled');
      expect(b2.getAttribute('aria-disabled'), 'false');
    });

    test('user-defined aria-label is preserved', () {
      expect(b3.getAttribute('aria-label'), equals('custom'));
      b3.icon = 'arrow-forward';
      expect(b3.getAttribute('aria-label'), equals('custom'));
    });

    test('alt attribute is used for the aria-label', () {
      expect(b4.getAttribute('aria-label'), equals('alt text'));
      b4.icon = 'arrow-forward';
      expect(b4.getAttribute('aria-label'), equals('alt text'));
    });

    test('aria-label wins over alt attribute', () {
      expect(b5.getAttribute('aria-label'), equals('custom'));
      b5.icon = 'arrow-forward';
      b5.alt = 'other alt';
      expect(b5.getAttribute('aria-label'), equals('custom'));
    });

    test('alt attribute can be updated', () {
      expect(b4.getAttribute('aria-label'), equals('alt text'));
      b4.alt = 'alt again';
      expect(b4.getAttribute('aria-label'), equals('alt again'));
    });

  });
}
