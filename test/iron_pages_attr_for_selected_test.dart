// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_pages_attr_for_selected_test;

import 'package:polymer_elements/iron_pages.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    IronPages pages;

    group('honor the selected attribute', () {
      setUp(() {
        pages = fixture('basic');
      });

      test('selected value', () {
        expect(pages.selected, 'page0');
      });

      test('selected item', () async {
        await wait(1);
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

    group('set selected attribute', () {
      setUp(() {
        pages = fixture('basic');
        pages.selected = 'page2';
      });

      test('selected value', () {
        expect(pages.selected, 'page2');
      });

      test('selected item', () async {
        await wait(1);
        expect(pages.selectedItem, pages.items[2]);
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
