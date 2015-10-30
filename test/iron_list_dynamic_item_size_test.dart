// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_list_dynamic_item_size_test;

import 'dart:async';
import 'dart:js';
import 'package:polymer_elements/iron_list.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'iron_list_test_helpers.dart';
import 'fixtures/x_list.dart';

/// Uses [XList].
main() async {
  await initPolymer();

  group('Dynamic item size', () {
    IronList list;
    XList container;

    setUp(() {
      container = fixture('trivialList');
      list = container.list;
    });

    test('update size using item index', () async {
      list.items = buildDataSet(100);

      await wait(1);

      var firstItem = getFirstItemFromList(list);
      var initHeight = firstItem.offsetHeight;

      list.set('items.0.index', '1\n2\n3\n4');
      list.updateSizeForItem(0);
      expect(firstItem.offsetHeight, greaterThan(initHeight * 3));

      list.set('items.0.index', '1');
      list.updateSizeForItem(0);
      expect(firstItem.offsetHeight, initHeight);
    });

    test('update size using item object', () async {
      list.items = buildDataSet(100);

      await wait(1);

      var firstItem = getFirstItemFromList(list);
      var initHeight = firstItem.offsetHeight;

      list.set('items.0.index', '1\n2\n3\n4');
      list.updateSizeForItem(list.items[0]);
      expect(firstItem.offsetHeight, greaterThan(initHeight * 3));

      list.set('items.0.index', '1');
      list.updateSizeForItem(list.items[0]);
      expect(firstItem.offsetHeight, initHeight);
    });

    test('ignore items that are not rendered', () async {
      list.items = buildDataSet(100);

      await wait(1);
      list.updateSizeForItem(list.items[list.jsElement['_physicalCount'] + 1]);
    });

    test('throw if the item is invalid', () async {
      list.items = buildDataSet(100);

      await wait(1);
      var firstItem = getFirstItemFromList(list);
      var initHeight = firstItem.offsetHeight;
      var throws = 0;

      try {
        list.updateSizeForItem(100);
      } catch (error) {
        throws++;
      }

      try {
        list.updateSizeForItem({});
      } catch (error) {
        throws++;
      }

      expect(throws, 2);
    });
  });
}
