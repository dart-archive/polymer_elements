// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_list_mutations_test;

import 'dart:async';
import 'dart:js';
import 'dart:math';
import 'package:polymer_elements/iron_list.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'iron_list_test_helpers.dart';
import 'fixtures/x_list.dart';

var rand = new Random();

flush(x()) {
  new Future((){}).then((_) => x());
}

main() async {
  await initPolymer();

  group('mutations to the collection of items', () {
    IronList list;
    XList container;

    setUp(() {
      container = fixture('trivialList');
      list = container.list;
    });

    test('update physical item', () {
      var setSize = 100;
      var phrase = 'It works!';
      list.items = buildDataSet(setSize);
      list.set('items.0.index', phrase);
      return new Future(() {}).then((_) {
        expect(getFirstItemFromList(list).text, phrase);
      });
    });

    test('update virtual item', () {
      var done = new Completer();
      var setSize = 100;
      var phrase = 'It works!';
      list.items = buildDataSet(setSize);

      scrollBackUp([_]) {
        simulateScroll({'list': list, 'contribution': 200, 'target': 0, "onScrollEnd" :() {
          new Future(() {}).then((_) {
            expect(getFirstItemFromList(list).text, phrase);
            done.complete();
          });
        }});
      }

      new Future(() {}).then((_) {
        var rowHeight = list.jsElement['_physicalItems'][0].offsetHeight;
        // scroll down
        simulateScroll(
            {'list': list, 'contribution': 200, 'target': setSize * rowHeight,
              "onScrollEnd": () {
                list.set('items.0.index', phrase);
                new Future(() {}).then(scrollBackUp);
              }});
      });

      return done.future;
    });

    test('push', () {
      var done = new Completer();
      var setSize = 100;
      list.items = buildDataSet(setSize);
      setSize = list.items.length;
      list.add('items', buildItem(setSize));
      expect(list.items.length, setSize + 1);
      new Future(() {}).then((_) {
        var rowHeight = list.jsElement['_physicalItems'][0].offsetHeight;
        var viewportHeight = list.offsetHeight;
        var itemsPerViewport = (viewportHeight / rowHeight).floor();
        expect(getFirstItemFromList(list).text, '0');
        simulateScroll({
                         'list': list,
                         'contribution': rowHeight,
                         'target': list.items.length * rowHeight
                         , "onScrollEnd": () {
            expect(getFirstItemFromList(list).text,
                       (list.items.length - itemsPerViewport).toString());
            done.complete();
          }});
      });
      return done.future;
    });

    test('push and scroll to bottom', () {
      Completer done = new Completer();
      list.items = [buildItem(0)];

      new Future(() {}).then((_) {
        var rowHeight = getFirstItemFromList(list).offsetHeight;
        var viewportHeight = list.offsetHeight;
        var itemsPerViewport = (viewportHeight / rowHeight).floor();

        while (list.items.length < 200) {
          list.add('items', buildItem(list.items.length));
        }

        list.scrollToIndex(list.items.length - 1);
        expect(isFullOfItems(list), isTrue);
        expect(getFirstItemFromList(list).text.trim(),
                   list.items.length - itemsPerViewport);
        done.complete();
      });

      return done.future;
    });

    test('pop', () {
      var done = new Completer();
      var setSize = 100;
      list.items = buildDataSet(setSize);
      new Future(() {}).then((_) {
        var rowHeight = getFirstItemFromList(list).offsetHeight;
        simulateScroll({
                         'list': list,
                         'contribution': rowHeight,
                         'target': setSize * rowHeight,
                         'onScrollEnd': () {
                           var viewportHeight = list.offsetHeight;
                           var itemsPerViewport = (viewportHeight / rowHeight).floor();
                           // TODO(jakemac): Update once we resolve
                           // https://github.com/dart-lang/polymer_interop/issues/6
                           list.removeLast('items');
                           new Future(() {}).then((_) {
                             expect(list.items.length, setSize - 1);
                             expect(getFirstItemFromList(list).text, '${setSize - 3 - 1}');
                             done.complete();
                           });
                         }});
      });
      return done.future;
    });

    test('splice', () {
      var setSize = 45;
      var phrase = 'It works!';
      list.items = buildDataSet(setSize);
      list.removeRange('items', 0, setSize);
      list.add('items', buildItem(phrase));
      return new Future(() {}).then((_) {
        expect(list.items.length, 1);
        expect(getFirstItemFromList(list).text, phrase);
      });
    });

    test('delete item and scroll to bottom', () {
      var setSize = 100, index;

      list.items = buildDataSet(setSize);

      while (list.items.length > 10) {
        index = (list.items.length * rand.nextDouble()).floor();
        list.removeItem('items', list.items[index]);
        list.scrollToIndex(list.items.length - 1);
        expect(
            new RegExp(r'^[0-9]*$').hasMatch(getFirstItemFromList(list).text),
            isTrue);
      }
    });

    test('reassign items', () {
      Completer done = new Completer();
      list.items = buildDataSet(100);
      container.itemHeight =null;// 'auto';

      flush(() {
        var itemHeight = getFirstItemFromList(list).offsetHeight;
        var hasRepeatedItems = checkRepeatedItems(list);

        simulateScroll({
                         "list": list,
                         "contribution": 200,
                         "target": itemHeight * list.items.length,
                         "onScrollEnd": () {
                           list.items = [list.items.removeAt(0)];
                           simulateScroll({
                                            "list": list,
                                            "contribution": itemHeight,
                                            "target": itemHeight * list.items.length,
                                            "onScroll": () {
                                              expect(hasRepeatedItems(), isFalse, reason: 'List should not have repeated items');
                                            },
                                            "onScrollEnd": done.complete()
                                          });
                         }
                       });
      });

      return done.future;
    });

    test('empty items array', () {
      Completer done = new Completer();
      list.items = buildDataSet(100);

      flush(() {
        list.items = [];
        flush(() {
          expect(getFirstItemFromList(list).text, isNot('0'));
          done.complete();
        });
      });
      return done.future;
    });

    test('should notify path to the right physical item', () {
      Completer done = new Completer();
      list.items = buildDataSet(100);
      flush(() {
        var idx = list.jsElement["_physicalCount"] + 1;

        list.scrollToIndex(idx);
        list.notifyPath('items.1.index', 'bad');
        expect(getFirstItemFromList(list).text, idx);
        done.complete();
      });
      return done.future;
    });


  });
}
