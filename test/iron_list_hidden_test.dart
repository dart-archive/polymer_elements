// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_list_hidden_test;

import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_list.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'iron_list_test_helpers.dart';

main() async {
  await initWebComponents();
  
  group('hidden list', () {
    IronList list;
    JsObject container;

    setUp(() {
      container = new JsObject.fromBrowserObject(fixture('trivialList'));
      list = container['list'];
    });

    test('list size', () {
      list.items = buildDataSet(100);
      return new Future(() {}).then((_) {
        expect(list.offsetWidth, 0);
        expect(list.offsetHeight, 0);
      });
    });

    test('resize', () {
      list.items = buildDataSet(100);
      list.dispatchEvent(new Event('resize'));
      return new Future(() {}).then((_) {
        expect(getFirstItemFromList(list).text, isNot('0'));
        container.callMethod('removeAttribute', ['hidden']);
        return new Future(() {}).then((_) {
          expect(getFirstItemFromList(list).text, isNot('0'));
          list.dispatchEvent(new Event('resize'));
          return new Future(() {}).then((_) {
            expect(getFirstItemFromList(list).text, '0');
          });
        });
      });
    });
  });

}
