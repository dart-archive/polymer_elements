@TestOn('browser')
library polymer_elements.test.iron_iconset_svg_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_iconset_svg.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();
  
  group('<iron-iconset>', () {
    group('basic behavior', () {
      var iconset;
      var meta;

      setUp(() {
        var elements = fixture('TrivialIconsetSvg');
        iconset = elements[0];
        meta = elements[1];
      });

      test('it can be accessed via iron-meta', () {
        expect(meta.byKey('foo'), iconset);
      });
    });
    group('when paired with a size and SVG definition', () {
      var iconset;
      var div;

      setUp(() {
        var elements = fixture('StandardIconsetSvg');
        iconset = elements[0];
        div = elements[1];
      });

      test('appends a child to the target element', () {
        expect(div.children.length, 0);
        iconset.applyIcon(div, 'circle');
        expect(div.children.length, 1);
      });

      test('can be queried for all available icons', () {
        expect(iconset.getIconNames(), ['my-icons:circle', 'my-icons:square']);
      });

      test('supports any icon defined in the svg', () {
        var lastSvgIcon;
        iconset.getIconNames().forEach((iconName) {
          iconset.applyIcon(div, iconName.split(':').removeLast());
          expect(div.children.first, isNot(lastSvgIcon));
          lastSvgIcon = div.children.first;
        });
      });
    });
  });
}
