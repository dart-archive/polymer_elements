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
import 'fixtures/x_list.dart';
import 'dart:math' as Math;

/// Uses [XList].
main() async {
  await initPolymer();

  group('basic features', () {
    IronList list;
    XList container;

    setUp(() {
      container = fixture('trivialList');
      list = container.list;
    });

    test('defaults', () {
      expect(list.items, null,reason:"items");
      expect(list.as, 'item',reason:"as");
      expect(list.indexAs, 'index',reason:"indexAs");
      expect(list.selectedAs, 'selected', reason:'selectedAs');
      expect(list.scrollTarget, list,reason: 'scrollTarget');
      expect(list.selectionEnabled,isFalse,reason: 'selectionEnabled');
      expect(list.multiSelection,isFalse,reason: 'multiSelection');
    });

    test('check items length', () {
      container.set('data', buildDataSet(100));
      return new Future(() {}).then((_) {
        expect(list.items.length, container.data.length);
      });
    });

    test('check physical item heights', () {
      container.set('data', buildDataSet(100));
      return new Future(() {}).then((_) {
        var rowHeight = list.jsElement['_physicalItems'][0].offsetHeight;
        list.jsElement['_physicalItems'].forEach((item) {
          expect(item.offsetHeight, rowHeight);
        });
      });
    });

    test('check physical item size', () {
      var setSize = 10;
      container.set('data', buildDataSet(setSize));
      return new Future(() {}).then((_) {
        expect(list.items.length, setSize);
      });
    });

    test('first visible index', () {
      var done = new Completer();
      container.set('data', buildDataSet(100));
      new Future(() {}).then((_) {
        var rowHeight = container.itemHeight;
        var viewportHeight = list.offsetHeight;
        var scrollToItem;
        checkFirstVisible() {
          expect(list.firstVisibleIndex, scrollToItem);
          expect(getFirstItemFromList(list).text, scrollToItem.toString());
        }

        checkLastVisible() {
          var visibleItemsCount = (viewportHeight / rowHeight).floorToDouble();
          expect(list.lastVisibleIndex, scrollToItem + visibleItemsCount - 1);
          // dam0vm3nt : getLastItem not working ????
          // expect(getLastItemFromList(list).text, (scrollToItem + visibleItemsCount - 1).floor().toString());
        }

         doneScrollUp([_]) {
          checkFirstVisible();
          checkLastVisible();
          done.complete();
        }
        doneScrollDown([_]) {
          checkFirstVisible();
          checkLastVisible();
          scrollToItem = 1;
          new Future(() {}).then((_) {
            simulateScroll({
              'list': list,
              'contribution': rowHeight,
              'target': scrollToItem * rowHeight,
              'onScrollEnd' : doneScrollUp
            });
          });
        }
        scrollToItem = 50;
        simulateScroll({
          'list': list,
          'contribution': 50,
          'target': scrollToItem * rowHeight,
          'onScrollEnd': doneScrollDown
        });
      });
      return done.future;
    });

    test('scroll to index', () async {
      //var done = new Completer();
      list.items = buildDataSet(100);

      await new Future.delayed(new Duration(milliseconds: 100));

      {
        list.scrollToIndex(30);
        expect(list.firstVisibleIndex, 30);
        list.scrollToIndex(0);
        expect(list.firstVisibleIndex, 0);
        var rowHeight = getFirstItemFromList(list).offsetHeight;
        var viewportHeight = list.offsetHeight;
        var itemsPerViewport = (viewportHeight / rowHeight).floor();
        list.scrollToIndex(99);
        expect(list.firstVisibleIndex, list.items.length - itemsPerViewport);
        // make the height of the viewport same as the height of the row
        // and scroll to the last item
        list.style.height =
            '${list.jsElement['_physicalItems'][0].offsetHeight}px';

        await new Future.delayed(new Duration(milliseconds: 100));

        {
          list.scrollToIndex(99);
          expect(list.firstVisibleIndex, 99);
        }
      }


    });

    test('reset items', () async {
      list.items = buildDataSet(100);

      await wait(1);
      var firstItem = getFirstItemFromList(list);
      expect(firstItem.text, '0');

      list.items = null;

      await wait(1);
      expect(getFirstItemFromList(list).text, isNot('0'));
      list.items = buildDataSet(100);

      await wait(1);
      expect(getFirstItemFromList(list).text, '0');
    });
  });
}
