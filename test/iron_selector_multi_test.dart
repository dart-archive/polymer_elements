// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_selector_multi_test;

import 'dart:async';
import 'dart:html';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer_elements/iron_selector.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('multi', () {
    IronSelector s;
    TemplateElement t;

    setUp(() async {
      s = fixture('test');
      t = Polymer.dom(s).querySelector('[is="dom-repeat"]');
      await new Future(() {});
    });

    test('honors the multi attribute', () {
      expect(s.multi, isTrue);
    });

    test('has sane defaults', () {
      expect(s.selectedValues, isNull);
      expect(s.selectedClass, 'iron-selected');
      expect(s.items.length, 5);
    });

    test('set multi-selection via selected property', () {
      // set selectedValues
      s.selectedValues = [0, 2];
      // check selected class
      expect(s.children[0].classes.contains('iron-selected'), isTrue);
      expect(s.children[2].classes.contains('iron-selected'), isTrue);
      // check selectedItems
      expect(s.selectedItems.length, 2);
      expect(s.selectedItems[0], s.children[0]);
      expect(s.selectedItems[1], s.children[2]);
    });

    test('set multi-selection via tap', () {
      // set selectedValues
      s.children[0].dispatchEvent(new CustomEvent('tap', canBubble: true));
      s.children[2].dispatchEvent(new CustomEvent('tap', canBubble: true));
      // check selected class
      expect(s.children[0].classes.contains('iron-selected'), isTrue);
      expect(s.children[2].classes.contains('iron-selected'), isTrue);
      // check selectedItems
      expect(s.selectedItems.length, 2);
      expect(s.selectedItems[0], s.children[0]);
      expect(s.selectedItems[1], s.children[2]);
    });

    test('fire iron-select/deselect events', () {
      // setUp listener for iron-select event
      var selectEventCounter = 0;
      s.addEventListener('iron-select', (e) {
        selectEventCounter++;
      });
      // setUp listener for core-deselect event
      var deselectEventCounter = 0;
      s.addEventListener('iron-deselect', (e) {
        deselectEventCounter++;
      });
      // tap to select an item
      s.children[0].dispatchEvent(new CustomEvent('tap', canBubble: true));
      // check events
      expect(selectEventCounter, 1);
      expect(deselectEventCounter, 0);
      // tap on already selected item should deselect it
      s.children[0].dispatchEvent(new CustomEvent('tap', canBubble: true));
      // check selectedValues
      expect(s.selectedValues.length, 0);
      // check class
      expect(s.children[0].classes.contains('iron-selected'), isFalse);
      // check events
      expect(selectEventCounter, 1);
      expect(deselectEventCounter, 1);
    });

    test('fires selected-values-changed when selection changes', () {
      var selectedValuesChangedEventCounter = 0;

      s.on['selected-values-changed'].listen((e) {
        selectedValuesChangedEventCounter++;
      });

      tap(Polymer.dom(s).children[0]);
      tap(Polymer.dom(s).children[0]);
      tap(Polymer.dom(s).children[0]);

      expect(selectedValuesChangedEventCounter, isNot(0));
    });

    test('selects from items created by dom-repeat', () async {
      var selectEventCounter = 0;
      var firstChild;

      s = document.querySelector('#repeatedItems');
      s.on['iron-select'].first.then((e) {
        selectEventCounter++;
      });

      // NOTE(cdata): I guess `dom-repeat` doesn't stamp synchronously..
      await wait(1);
      firstChild = Polymer.dom(s).querySelector('div');
      tap(firstChild);

      expect(s.selectedItems[0].text, 'foo');
    });

    test('updates selection when dom changes', () async {
      var selectEventCounter = 0;

      s = fixture('test');

      await wait(1);
      var firstChild = Polymer.dom(s).querySelector(':first-child');
      var lastChild = Polymer.dom(s).querySelector(':last-child');

      tap(firstChild);
      tap(lastChild);

      expect(s.selectedItems.length, 2);

      Polymer.dom(s).removeChild(lastChild);

      await wait(1);
      expect(s.selectedItems.length, 1);
    });

    suite('`select()` and `selectIndex()`', () {
      var selector;

      setup(() {
        selector = fixture('valueById');
      });

      test('`select()` selects an item with the given value', () {
        selector.select('item1');
        $assert.equal(selector.selectedValues.length, 1);
        $assert.equal(selector.selectedValues.indexOf('item1'), 0);

        selector.select('item3');
        $assert.equal(selector.selectedValues.length, 2);
        $assert.isTrue(selector.selectedValues.indexOf('item3') >= 0);

        selector.select('item2');
        $assert.equal(selector.selectedValues.length, 3);
        $assert.isTrue(selector.selectedValues.indexOf('item2') >= 0);
      });

      test('`selectIndex()` selects an item with the given index', () {
        selector.selectIndex(1);
        $assert.equal(selector.selectedValues.length, 1);
        $assert.isTrue(selector.selectedValues.indexOf('item1') >= 0);
        $assert.equal(selector.selectedItems.length, 1);
        $assert.isTrue(selector.selectedItems.indexOf(selector.items[1]) >= 0);

        selector.selectIndex(3);
        $assert.equal(selector.selectedValues.length, 2);
        $assert.isTrue(selector.selectedValues.indexOf('item3') >= 0);
        $assert.equal(selector.selectedItems.length, 2);
        $assert.isTrue(selector.selectedItems.indexOf(selector.items[3]) >= 0);

        selector.selectIndex(0);
        $assert.equal(selector.selectedValues.length, 3);
        $assert.isTrue(selector.selectedValues.indexOf('item0') >= 0);
        $assert.equal(selector.selectedItems.length, 3);
        $assert.isTrue(selector.selectedItems.indexOf(selector.items[0]) >= 0);
      });
    });

    /* test('toggle multi from true to false', () {
      // set selected
      s.selected = [0, 2];
      var first = s.selected[0];
      // set mutli to false, so to make it single-selection
      s.multi = false;
      // selected should not be an array
      assert.isNotArray(s.selected);
      // selected should be the first value from the old array
      expect(s.selected, first);
    }); */
  });
}
