// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_list_focus_test;

import 'dart:async';
import 'dart:js';
import 'package:polymer_elements/iron_list.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'iron_list_test_helpers.dart';
import 'fixtures/x_list.dart';

Future flush(Future x()) async {
  await new Future( (){});
  return await x();
}

/// Uses [XList].
main() async {
  await initPolymer();

  group('basic features', () {
    IronList list;
    var container;

    setUp(() {
      container = fixture('trivialList');
      list = container.list;
    });

    test('first item should be focusable', () async {
      container.data = buildDataSet(100);

      await flush(() async {
        //console.log(getFirstItemFromList(list));
        expect(getFirstItemFromList(list).tabIndex, -1);
      });
    });

    test('focus the first item and then reset the items', () async {
      list.items = buildDataSet(100);

      await flush(() {
        getFirstItemFromList(list).focus();

        Completer done = new Completer();
        simulateScroll({
                         "list": list,
                         "contribution": 200,
                         "target": 3000,
                         "onScrollEnd": () {
                           list.items = [];
                           flush(() async {
                             done.complete();
                           });
                         }
                       });
        return done.future;
      });
    });

    test('focus the first item and then splice all the items', () async {
      list.items = buildDataSet(100);

      await flush(() {
        getFirstItemFromList(list).focus();

        Completer done = new Completer();
        simulateScroll({
                         "list": list,
                         "contribution": 200,
                         "target": 3000,
                         "onScrollEnd": () {
                           list.removeRange('items', 0, list.items.length);
                           flush(() {
                             done.complete();
                           });
                         }
                       });

        return done.future;
      });
    });

    test('should not hide the list', () async {
      list.items = buildDataSet(100);
      Completer done = new Completer();

      await flush(() {
        // this index isn't rendered yet
        list.jsElement["_focusedIndex"] = list.items.length - 1;
        list.scrollTarget.onScroll.listen((_) {
          var rect = list.getBoundingClientRect();
          expect(rect.top + rect.height > 0, isTrue);
          done.complete();
        });
        // trigger the scroll event
        list.jsElement["_scrollTop"] = 1000;
      });
    });
  });
}
