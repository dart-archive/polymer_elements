@TestOn('browser')
library polymer_elements.test.paper_material_test;

import 'dart:html';
import 'package:polymer_elements/paper_material.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<paper-material>', () {
    group('with a non-zero elevation attribute', () {
      CssStyleDeclaration style;
      PaperMaterial card;
      setUp(() {
        card = fixture('TrivialCard');
        style = card.getComputedStyle();
      });

      test('has a shadow', () {
        expect(style.boxShadow, isNotNull);
        expect(style.boxShadow, isNot('none'));
      });

      test('loses shadow with elevation value 0', () {
        card.elevation = 0;
        expect(style.boxShadow, equals('none'));
      });
    });

    group('progressively increasing values of elevation', () {
      List cards;
      setUp(() {
        cards = fixture('ProgressiveElevations');
      });

      test('yield progressively "deeper" cards', () {
        CssStyleDeclaration lastStyle;
        CssStyleDeclaration style;

        expect(cards.length, equals(5));

        cards.forEach((PaperMaterial card) {
          style = card.getComputedStyle();

          expect(style.boxShadow, isNotNull);
          expect(style.boxShadow, isNot('none'));

          if (lastStyle != null) expect(
              style.boxShadow, isNot(lastStyle.boxShadow));

          lastStyle = style;
        });
      });
    });
  });
}
