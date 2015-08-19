@TestOn('browser')
library polymer_elements.test.iron_list_basic_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_list.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'iron_list_test_helpers.dart';

main() async {
  await initWebComponents();
  
  group('basic features', () {
    IronList list;
    JsObject container;
    
    setUp(() {
      container = new JsObject.fromBrowserObject(fixture('trivialList'));
      list = container['list'];
    });
    
    test('defaults', () {
      expect(list.items, null);
      expect(list.as, 'item');
      expect(list.indexAs, 'index');
    });
    
    test('check items length', () {
      container['data'] = buildDataSet(100);
      return new Future(() {}).then((_) {
        expect(list.items.length, container['data'].length);
      });
    });
    
    test('check physical item heights', () {
      container['data'] = buildDataSet(100);
      return new Future(() {}).then((_) {
        var rowHeight = list.jsElement['_physicalItems'][0].offsetHeight;
        list.jsElement['_physicalItems'].forEach((item) {
          expect(item.offsetHeight, rowHeight);
        });
      });
    });
    
    test('check physical item size', () {
      var setSize = list.jsElement['_physicalCount'] - 1;
      container['data'] = buildDataSet(setSize);
      return new Future(() {}).then((_) {
        expect(list.items.length, setSize);
      });
    });
    
    test('first visible index', () {
      var done = new Completer();
      container['data'] = buildDataSet(100);
      new Future(() {}).then((_) {
        var rowHeight = list.jsElement['_physicalItems'][0].offsetHeight;
        var viewportHeight = list.offsetHeight;
        var scrollToItem;
        checkFirstVisible() {
          expect(list.firstVisibleIndex, scrollToItem);
          expect(getFirstItemFromList(list).text, scrollToItem.toString());
        }
        doneScrollUp([_]) {
          checkFirstVisible();
          done.complete();
        }
        doneScrollDown([_]) {
          checkFirstVisible();
          scrollToItem = 1;
          new Future(() {}).then((_) {
            simulateScroll({
              'list': list,
              'contribution': rowHeight,
              'target': scrollToItem * rowHeight
            }, doneScrollUp);
          });
        }
        scrollToItem = 50;
        simulateScroll({
          'list': list,
          'contribution': 50,
          'target': scrollToItem * rowHeight
        }, doneScrollDown);
      });
      return done.future;
    });

    test('scroll to index', () {
      var done = new Completer();
      list.items = buildDataSet(100);

      new Future(() {}).then((_) {
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
        wait(100).then((_) {
          list.scrollToIndex(99);
          expect(list.firstVisibleIndex, 99);
          done.complete();
        });
      });
      return done.future;
    });
  });
}
