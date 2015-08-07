@TestOn('browser')
library polymer_elements.test.iron_list_physical_count_test;

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
  
  group('dynamic physical count', () {
    IronList list;
    JsObject container;

    setUp(() {
      container = new JsObject.fromBrowserObject(fixture('trivialList'));
      list = container['list'];
    });

    test('increase pool size', () {
      list.items = buildDataSet(1000);
      return new Future(() {}).then((_) {
        var lastItem = getLastItemFromList(list);
        var lastItemHeight = lastItem.offsetHeight;
        var expectedFinalItem = (list.offsetHeight / lastItemHeight).floor();
        expect(lastItemHeight, 1);
        expect(getLastItemFromList(list).text, expectedFinalItem.toString());
      });
    });
  });
}
