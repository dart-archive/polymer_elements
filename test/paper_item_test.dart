// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_item_test;

import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/paper_icon_item.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('item a11y tests', () {
    PaperItem item;
    PaperIconItem iconItem;
    setUp(() {
      item = fixture('item');
      iconItem = fixture('iconItem');
    });

    test('item has role="listitem"', () {
      expect(item.getAttribute('role'), equals('listitem'),
          reason: 'should have role="item"');
    });

    test('icon item has role="listitem"', () {
      expect(iconItem.getAttribute('role'), equals('listitem'),
          reason: 'should have role="item"');
    });
  });
}
