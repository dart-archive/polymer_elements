// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_list_basic_test;

import 'dart:async';
import 'dart:js';
import 'package:polymer_elements/iron_list.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'iron_list_test_helpers.dart';
import 'fixtures/x_grid.dart';
import 'dart:math' as Math;

/// Uses [XGrid].
main() async {
  await initPolymer();

  suite('basic features', () {
    IronList list;
    XGrid container;

    setup(() {
      container = fixture('trivialList');
      list = container.list;
    });

    test('check horizontal rendering', when((done) async {
      container.data = buildDataSet(100);

      await wait(1);
      // Validate the first viewport
      for (var i = 0; i < 9; i++) {
        $assert.equal(getNthItemFromGrid(list, i).text, i.toString());
      }
      done();
    }),skip: 'https://github.com/dart-lang/polymer_elements/issues/53');

    test('first visible index', when((done) async {
      container.set('data',buildDataSet(100));

      await wait(1); // flush ??
      var setSize = list.items.length;
      var rowHeight = container.itemSize;
      var viewportHeight = list.offsetHeight;
      var scrollToItem;

      checkFirstVisible() {
        $assert.equal(list.firstVisibleIndex, getNthItemRowStart(list, scrollToItem));
        $assert.equal(getNthItemFromGrid(list, 0).text, getNthItemRowStart(list, scrollToItem).toString());
      }

      checkLastVisible() {
        var visibleItemsCount = (viewportHeight / rowHeight).floor() * list.jsElement['_itemsPerRow'];
        var visibleItemStart = getNthItemRowStart(list, scrollToItem);
        $assert.equal(list.lastVisibleIndex, visibleItemStart + visibleItemsCount - 1);
        $assert.equal(getNthItemFromGrid(list, 8).text, visibleItemStart + visibleItemsCount - 1);
      }

      doneScrollUp() {
        checkFirstVisible();
        checkLastVisible();
        done();
      }

      doneScrollDown() {
        checkFirstVisible();
        checkLastVisible();
        scrollToItem = 1;
        flush(() {
          simulateScroll({'list': list, 'contribution': rowHeight, 'target': getGridRowFromIndex(list, scrollToItem) * rowHeight, 'onScrollEnd': doneScrollUp});
        });
      }

      scrollToItem = 50;

      simulateScroll({'list': list, 'contribution': rowHeight, 'target': getGridRowFromIndex(list, scrollToItem) * rowHeight, 'onScrollEnd': doneScrollDown});
    }),skip: 'https://github.com/dart-lang/polymer_elements/issues/53');

    test('scroll to index', when((done) {
      list.items = buildDataSet(100);

      flush(() {
        list.scrollToIndex(30);
        $assert.equal(list.firstVisibleIndex, 30);

        list.scrollToIndex(0);
        $assert.equal(list.firstVisibleIndex, 0);

        list.scrollToIndex(60);
        $assert.equal(list.firstVisibleIndex, 60);

        var rowHeight = getNthItemFromGrid(list, 0).offsetHeight;
        var viewportHeight = list.offsetHeight;
        var itemsPerViewport = (viewportHeight / rowHeight).floor() * list.jsElement['_itemsPerRow'];

        list.scrollToIndex(99);
        // $assert.equal(list.firstVisibleIndex, list.items.length - 7);

        // make the height of the viewport same as the height of the row
        // and scroll to the last item
        list.style.height = '${list.jsElement['_physicalItems'][0].offsetHeight}px';

        flush(() {
          var idx = 99;
          list.scrollToIndex(idx);
          $assert.equal(list.firstVisibleIndex, idx);
          done();
        });
      });
    }));

    test('reset items', when((done) {
      list.items = buildDataSet(100);

      flush(() {
        $assert.equal(getNthItemFromGrid(list, 0).text, '0');

        list.items = null;

        flush(() {
          $assert.notEqual(getNthItemFromGrid(list, 0).text, '0');
          list.items = buildDataSet(100);

          flush(() {
            $assert.equal(getNthItemFromGrid(list, 0).text, '0');
            done();
          });
        });
      });
    }));
  });
}
