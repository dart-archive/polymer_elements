// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_iconset_svg_test;

import 'dart:html';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer_elements/iron_iconset_svg.dart';
import 'package:polymer_elements/iron_meta.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

/// Used imports: [IronIconsetSvg]
main() async {
  await initWebComponents();

  group('<iron-iconset>', () {
    group('basic behavior', () {
      IronIconsetSvg iconset;
      IronMeta meta;

      setUp(() {
        var elements = fixture('TrivialIconsetSvg');
        iconset = elements[0];
        meta = elements[1];
      });

      test('it can be accessed via iron-meta', () {
        expect(meta.byKey('foo'), iconset);
      });

      test('it does not have a size', () {
        var rect = iconset.getBoundingClientRect();
        expect(rect.width, 0);
        expect(rect.height, 0);
      });

      test('it fires an iron-iconset-added event on the window', () {
        return window.on['iron-iconset-added'].first.then((ev) {
          ev = convertToDart(ev);
          expect(ev, isNotNull);
          expect(ev.detail, iconset);
        });
      });
    });

    group('when paired with a size and SVG definition', () {
      IronIconsetSvg iconset;
      var div;

      setUp(() {
        var elements = fixture('StandardIconsetSvg');
        iconset = elements[0];
        div = elements[1];
      });

      test('it does not have a size', () {
        var rect = iconset.getBoundingClientRect();
        expect(rect.width, 0);
        expect(rect.height, 0);
      });

      test('appends a child to the target element', () {
        expect(div.children.length, 0);
        iconset.applyIcon(div, 'circle');
        expect(div.children.length, 1);
      });

      test('can be queried for all available icons', () {
        expect(iconset.getIconNames(),
            ['my-icons:circle', 'my-icons:square', 'my-icons:rect']);
      });

      test('supports any icon defined in the svg', () {
        var lastSvgIcon;
        iconset.getIconNames().forEach((iconName) {
          iconset.applyIcon(div, iconName.split(':').removeLast());
          expect(div.children.first, isNot(lastSvgIcon));
          lastSvgIcon = div.children.first;
        });
      });

      test('prefers a viewBox attribute over the iconset size', () {
        iconset.applyIcon(div, 'rect');
        expect(div.children.first.getAttribute('viewBox'), '0 0 50 25');
      });

      test('uses the iconset size when viewBox is not defined on the element',
          () {
        iconset.applyIcon(div, 'circle');
        expect(div.children.first.getAttribute('viewBox'), '0 0 20 20');
      });
    });
  });
}
