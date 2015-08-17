@TestOn('browser')
library polymer_elements.test.paper_card_test;

import 'package:polymer_elements/paper_card.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('a11y', () {
    test('aria-label set on card', () {
      PaperCard f = fixture('basic');
      expect(f.getAttribute('aria-label'), equals(f.heading));
    });
    test('aria-label can be updated', () {
      PaperCard f = fixture('basic');
      expect(f.getAttribute('aria-label'), equals(f.heading));
      f.heading = 'batman';
      expect(f.getAttribute('aria-label'), equals('batman'));
    });
  });
}
