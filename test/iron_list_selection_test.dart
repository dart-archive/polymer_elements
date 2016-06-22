// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_list_selection_test;

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

  group('selection', () {
    IronList list;
    XList container;

    setUp(() {
      container = fixture('trivialList');
      list = container.list;
    });

    test('single selection by item index', () async {
      list.items = buildDataSet(100);

      await wait(1);
      expect(list.selectedItem, isNull);

      list.selectItem(0);

      expect(list.selectedItem, list.items[0]);

      list.deselectItem(0);

      expect(list.selectedItem, isNull);

      list.selectItem(99);

      expect(list.selectedItem, list.items[99]);
    });

    test('single selection by item object', () async {
      list.items = buildDataSet(100);

      await wait(1);
      expect(list.selectedItem, isNull);

      list.selectItem(list.items[50]);

      expect(list.selectedItem, list.items[50]);
    });

    test('multi selection by item index', () async {
      list.items = buildDataSet(100);

      await wait(1);
      list.multiSelection = true;

      expect(list.selectedItems is List, isTrue);

      list.selectItem(0);
      list.selectItem(50);
      list.selectItem(99);

      expect(list.selectedItems.length, 3);
      expect(list.selectedItems.indexOf(list.items[0]), isNot(-1));
      expect(list.selectedItems.indexOf(list.items[50]), isNot(-1));
      expect(list.selectedItems.indexOf(list.items[99]), isNot(-1));
      expect(list.selectedItems.indexOf(list.items[2]), -1);
    });

    test('multi selection by item object', () async {
      list.items = buildDataSet(100);

      await wait(1);
      list.multiSelection = true;

      expect(list.selectedItems is List, isTrue);

      list.selectItem(list.items[0]);
      list.selectItem(list.items[50]);
      list.selectItem(list.items[99]);

      expect(list.selectedItems.length, 3);
      expect(list.selectedItems.indexOf(list.items[0]), isNot(-1));
      expect(list.selectedItems.indexOf(list.items[50]), isNot(-1));
      expect(list.selectedItems.indexOf(list.items[99]), isNot(-1));
      expect(list.selectedItems.indexOf(list.items[2]), -1);
    });

    test('clear selection', () async {
      list.items = buildDataSet(100);

      await wait(1);
      list.multiSelection = true;

      expect(list.selectedItems is List, isTrue);

      list.items.forEach((item) {
        list.selectItem(item);
      });

      expect(list.selectedItems.length, list.items.length);

      list.clearSelection();

      expect(list.selectedItems.length, 0);
    });

    test('toggle selection by item index', () async {
      list.items = buildDataSet(100);

      await wait(1);
      list.toggleSelectionForItem(0);

      expect(list.selectedItem, list.items[0]);

      list.toggleSelectionForItem(0);

      expect(list.selectedItem, isNull);
    });

    test('toggle selection by item object', () async {
      list.items = buildDataSet(100);

      await wait(1);
      list.toggleSelectionForItem(list.items[0]);

      expect(list.selectedItem, list.items[0]);

      list.toggleSelectionForItem(list.items[0]);

      expect(list.selectedItem, isNull);
    });

    test('change multi property', () async {
      list.items = buildDataSet(100);

      await wait(1);
      list.multiSelection = true;

      expect(list.selectedItems is List, isTrue);

      list.multiSelection = false;

      expect(list.selectedItems is List, isFalse);
      expect(list.selectedItems, isNull);

      list.multiSelection = true;

      expect(list.selectedItems is List, isTrue);
    });

    test('selectionEnabled with single selection', () async {
      list.items = buildDataSet(100);

      await wait(1);
      list.selectionEnabled = true;

      expect(list.selectedItem, isNull);

      // select item[0]
      tap(list.jsElement['_physicalItems'][0]);

      expect(list.selectedItem, list.items[0]);

      // select item[5] and deselect item[0]
      tap(list.jsElement['_physicalItems'][5]);

      // select item[1] and deselect item[5]
      tap(list.jsElement['_physicalItems'][1]);

      expect(list.selectedItem, list.items[1]);
    });

    test('selectionEnabled with multiple selection', () async {
      list.items = buildDataSet(100);

      await wait(1);
      list.multiSelection = true;

      tap(list.jsElement['_physicalItems'][0]);
      expect(list.selectedItems.length, 0);

      // enable the feature
      list.selectionEnabled = true;

      // select item[0]
      tap(list.jsElement['_physicalItems'][0]);

      expect(list.selectedItems.indexOf(list.items[0]), isNot(-1));

      // multiple selection
      tap(list.jsElement['_physicalItems'][1]);
      tap(list.jsElement['_physicalItems'][5]);
      tap(list.jsElement['_physicalItems'][10]);
      tap(list.jsElement['_physicalItems'][12]);

      list.selectItem(0);
      list.deselectItem(1);

      expect(list.selectedItems.indexOf(list.items[1]), -1);
      expect(list.selectedItems.indexOf(list.items[0]), isNot(-1));
      expect(list.selectedItems.indexOf(list.items[5]), isNot(-1));
      expect(list.selectedItems.indexOf(list.items[10]), isNot(-1));
      expect(list.selectedItems.indexOf(list.items[12]), isNot(-1));

      list.clearSelection();

      expect(list.selectedItems.length, 0);

      // disable the feature
      list.selectionEnabled = false;

      tap(list.jsElement['_physicalItems'][1]);

      expect(list.selectedItems.length, 0);
    });

    test('toggle', () async {
      list.items = buildDataSet(100);

      await wait(1);
      list.selectionEnabled = true;

      tap(list.jsElement['_physicalItems'][0]);

      expect(list.selectedItem, list.items[0]);

      tap(list.jsElement['_physicalItems'][0]);

      expect(list.selectedItem, isNull);

      tap(list.jsElement['_physicalItems'][0]);
      list.clearSelection();

      expect(list.selectedItem, isNull);
    });

    test('selectedAs', () async {
      list.items = buildDataSet(100);

      await wait(1);
      // multi selection
      list.multiSelection = true;

      // Work around dart2js error where template instance isn't a JsObject.
      JsObject _getTemplateInstance(HtmlElement item) {
        var instance = new JsObject.fromBrowserObject(item)['_templateInstance'];
        return instance is JsObject ? instance : new JsObject.fromBrowserObject(instance);
      }

      expect(_getTemplateInstance(list.jsElement['_physicalItems'][0])['selected'], isFalse);

      list.selectItem(0);

      expect(_getTemplateInstance(list.jsElement['_physicalItems'][0])['selected'], isTrue);

      list.toggleSelectionForItem(0);

      expect(_getTemplateInstance(list.jsElement['_physicalItems'][0])['selected'], isFalse);

      // single selection
      list.multiSelection = false;

      list.selectItem(0);
      list.selectItem(10);

      expect(_getTemplateInstance(list.jsElement['_physicalItems'][0])['selected'], isFalse);
      expect(_getTemplateInstance(list.jsElement['_physicalItems'][10])['selected'], isTrue);
    });

    test('splice a selected item', () async {
      list.items = buildDataSet(100);

      await wait(1);
      // multi selection
      list.multiSelection = true;

      // select the first two items
      list.selectItem(0);
      list.selectItem(1);

      expect(list.selectedItems.length, 2);

      // remove the first two items
      list.removeRange('items', 0, 2);

      expect(list.selectedItems.length, 0);
    });

    test('single selection of a primitive type', () {
      container.set('primitive',true);
      list.items = ['a', 'b', 'c', 'd'];
      list.selectionEnabled = true;
      PolymerDom.flush();
      list.selectItem(0);
      $assert.equal(list.selectedItem, 'a', 'single selection 1');
      list.clearSelection();
      $assert.isNull(list.selectedItem);
      list.selectItem(2);
      list.set('items.0', 'z');
      list.set('items.1', 'y');
      $assert.equal(list.selectedItem, 'c', 'single selection 2');
    });

    test('multi selection of a primitive types', () {
      container.set('primitive',true);
      list.items = ['a', 'b', 'c', 'd'];
      list.selectionEnabled = true;
      list.multiSelection = true;
      PolymerDom.flush();
      list.selectItem(0);
      list.selectItem(1);
      $assert.deepEqual(list.selectedItems, ['a', 'b'], 'multiple selection 1');
      list.clearSelection();
      $assert.equal(list.selectedItems.length, 0, 'multiple selection 2');
    });

    test('modify primitive item while being selected', () {
      container.set('primitive',true);
      list.items = ['a', 'b', 'c', 'd'];
      list.selectionEnabled = true;
      PolymerDom.flush();
      list.selectItem(0);
      list.set('items.0', 'z');
      $assert.equal(list.selectedItem, 'z', 'single selection 1');
      list.selectItem(2);
      $assert.equal(list.selectedItem, 'c', 'single selection 2');
      list.clearSelection();
      $assert.isNull(list.selectedItem);

      // test multi selection
      list.multiSelection = true;
      list.selectItem(0);
      list.selectItem(1);
      $assert.deepEqual(list.selectedItems, ['z', 'b'], 'multiple selection 1');
      list.set('items.1', 'y');
      $assert.deepEqual(list.selectedItems, ['z', 'y'], 'multiple selection 2');
      list.deselectItem('y');
      $assert.deepEqual(list.selectedItems, ['z'], 'multiple selection 3');
      list.deselectItem('z');
      $assert.equal(list.selectedItems.length, 0);
    });

    test('tapping on a focusable child should not change the selection', () {
      list.items = buildDataSet(1);
      list.selectionEnabled = true;
      PolymerDom.flush();
      var node = document.createElement('div');
      node.text = 'focusable';
      node.tabIndex = 0;
      new PolymerDom(getFirstItemFromList(list)).append(node);
      PolymerDom.flush();
      node.focus();
      tap(node);
      $assert.isNull(list.selectedItem);
    });
  });
}
