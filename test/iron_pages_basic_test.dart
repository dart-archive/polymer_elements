// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_pages_basic_test;

import 'package:polymer_elements/iron_pages.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    IronPages pages;

    group('defaults', () {
      setUp(() {
        pages = fixture('basic');
      });

      test('to nothing selected', () {
        expect(pages.selected, isNull);
      });

      test('null activateEvent', () {
        // `activateEvent` is not a useful feature for iron-pages and it can interfere
        // with ux; ensure iron-pages has cleared any default `activateEvent`
        expect(pages.activateEvent, isNull);
      });

      test('to iron-selected as selectedClass', () {
        expect(pages.selectedClass, 'iron-selected');
      });

      test('as many items as children', () {
        expect(pages.items.length, 4);
      });

      test('all pages are display:none', () {
        pages.items.forEach((p) {
          expect(p.getComputedStyle().display, 'none');
        });
      });
    });

    group('set the selected attribute', () {
      setUp(() {
        pages = fixture('basic');
        pages.selected = '0';
      });

      test('selected value', () {
        expect(pages.selected, '0');
      });

      test('selected item', () {
        expect(pages.selectedItem, pages.items[0]);
      });

      test('selected item is display:block and all others are display:none',
          () {
        pages.items.forEach((p) {
          expect(p.getComputedStyle().display,
              p == pages.selectedItem ? 'block' : 'none');
        });
      });
    });
  });
}
