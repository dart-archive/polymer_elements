@TestOn('browser')
library polymer_elements.test.paper_header_panel_basic_test;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_header_panel.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

bool hasShadow(PaperHeaderPanel panel) {
  return panel.visibleShadow;
}

main() async {
  await initWebComponents();

  group('<paper-header-panel>', () {
    PaperHeaderPanel standard,
        seamed,
        seamedShadow,
        waterfall,
        waterfallTall,
        scroll,
        cover;

    setUp(() {
      standard = fixture('standard');
      seamed = fixture('seamed');
      seamedShadow = fixture('seamed-shadow');
      waterfall = fixture('waterfall');
      waterfallTall = fixture('waterfall-tall');
      scroll = fixture('scroll');
      cover = fixture('cover');
    });

    test('has shadow in standard mode', () {
      expect(hasShadow(standard), isTrue);
    });

    test('no shadow in seamed mode', () {
      expect(hasShadow(seamed), isFalse);
    });

    test('no shadow in waterfall mode', () {
      expect(hasShadow(waterfall), isFalse);
    });

    test('no shadow in waterfall-tall mode', () {
      expect(hasShadow(waterfallTall), isFalse);
    });

    test('no shadow in scroll mode', () {
      expect(hasShadow(scroll), isFalse);
    });

    test('no shadow in cover mode', () {
      expect(hasShadow(cover), isFalse);
    });

    test('shadow property forces shadow to show', () {
      expect(hasShadow(seamedShadow), isTrue);
    });
  });
}
