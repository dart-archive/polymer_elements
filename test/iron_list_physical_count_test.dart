// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_list_physical_count_test;

import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_list.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'iron_list_test_helpers.dart';
import 'fixtures/x_list.dart';

main() async {
  await initPolymer();

  group('dynamic physical count', () {
    IronList list;
    XList container;

    setUp(() {
      container = fixture('trivialList');
      list = container.list;
    });

    test('increase pool size', () {
      list.items = buildDataSet(1000);
      return new Future(() {}).then((_) {
        var lastItem = getLastItemFromList(list);
        var lastItemHeight = lastItem.offsetHeight;
        var expectedFinalItem = (list.offsetHeight / lastItemHeight).floor();
        expect(lastItemHeight, 2);
        expect(getLastItemFromList(list).text, expectedFinalItem.toString());
      });
    });

    test('increase pool size on resize', () async {
      list.items = buildDataSet(1000);

      await wait(1);
      // change the height of the list
      container.set('listHeight', 500);
      // resize
      list.fire('iron-resize');

      await wait(1);
      var lastItem = getLastItemFromList(list);
      var lastItemHeight = lastItem.offsetHeight;
      int expectedFinalItem = (list.offsetHeight / lastItemHeight).round();

      expect(lastItemHeight, 2);
      expect(getLastItemFromList(list).text, '$expectedFinalItem');
    });
  });
}
