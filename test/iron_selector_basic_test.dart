// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_selector_basic_test;

import 'dart:async';
import 'dart:html';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer_elements/iron_selector.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:async';

main() async {
  await initWebComponents();

  group('defaults', () {
    IronSelector s1;

    setUp(() async {
      s1 = fixture('defaults');
      await new Future(() {});
    });

    test('to nothing selected', () {
      expect(s1.selected, isNull);
    });

    test('to iron-selected as selectedClass', () {
      expect(s1.selectedClass, 'iron-selected');
    });

    test('to false as multi', () {
      expect(s1.multi, isFalse);
    });

    test('to tap as activateEvent', () {
      expect(s1.activateEvent, 'tap');
    });

    test('to nothing as attrForSelected', () {
      expect(s1.attrForSelected, isNull);
    });

    test('as many items as children', () {
      expect(s1.items.length, s1.querySelectorAll('div').length);
    });
  });

  group('basic', () {
    IronSelector s2;

    setUp(() async {
      s2 = fixture('basic');
      await new Future(() {});
    });

    test('honors the attrForSelected attribute', () async {
      await wait(1);
      expect(s2.attrForSelected, 'id');
      expect(s2.selected, 'item2');
      expect(s2.selectedItem, document.querySelector('#item2'));
    });

    test('allows assignment to selected', () {
      // set selected
      s2.selected = 'item4';
      // check selected class
      expect(s2.children[4].classes.contains('iron-selected'), isTrue);
      // check item
      expect(s2.selectedItem, s2.children[4]);
    });

    test('fire iron-select when selected is set', () {
      // setUp listener for iron-select event
      var selectedEventCounter = 0;
      s2.on['iron-select'].take(1).listen((e) {
        selectedEventCounter++;
      });
      // set selected
      s2.selected = 'item4';
      // check iron-select event
      expect(selectedEventCounter, 1);
    });

    test('set selected to old value', () {
      // setUp listener for iron-select event
      var selectedEventCounter = 0;
      s2.on['iron-select'].take(1).listen((e) {
        selectedEventCounter++;
      });
      // selecting the same value shouldn't fire iron-select
      s2.selected = 'item2';
      expect(selectedEventCounter, 0);
    });

    test('force synchronous item update', () {
      $expect(s2.items.length).to.be.equal(5);
      new PolymerDom(s2).append(document.createElement('div'));
      $expect(s2.items.length).to.be.equal(5);
      s2.forceSynchronousItemUpdate();
      $expect(s2.items.length).to.be.equal(6);
    });

    suite('`select()` and `selectIndex()`', () {
      test('`select()` selects an item with the given value', () {
        s2.select('item1');
        $assert.equal(s2.selected, 'item1');

        s2.select('item3');
        $assert.equal(s2.selected, 'item3');

        s2.select('item2');
        $assert.equal(s2.selected, 'item2');
      });

      test('`selectIndex()` selects an item with the given index', () {
        s2.selectIndex(-1);
        $assert.equal(s2.selectedItem, null);

        s2.selectIndex(1);
        $assert.equal(s2.selected, 'item1');
        $assert.equal(s2.selectedItem, s2.items[1]);

        s2.selectIndex(3);
        $assert.equal(s2.selected, 'item3');
        $assert.equal(s2.selectedItem, s2.items[3]);

        s2.selectIndex(4);
        $assert.equal(s2.selected, 'item4');
        $assert.equal(s2.selectedItem, s2.items[4]);
      });
    });

    group('items changing', () {
      test('cause iron-items-changed to fire', () async {
        var newItem = document.createElement('div');
        var changeCount = 0;

        newItem.id = 'item999';

        var sub = s2.on['iron-items-changed'].listen((Event event) {
          changeCount++;
          CustomEventWrapper w = new CustomEventWrapper(event);
          var mutation = w.detail;
          $assert.notEqual(mutation, null);
          $assert.notEqual(mutation['addedNodes'], null);
          $assert.notEqual(mutation['removedNodes'], null);
        });

        Polymer.dom(s2).append(newItem);

        await wait(1);
        Polymer.dom(s2).removeChild(newItem);

        await wait(1);
        expect(changeCount, 2);

        sub.cancel();
      });
    });

    group('dynamic selector', () {
      test('selects dynamically added child automatically', () async {
        var selector = document.createElement('iron-selector');
        var child = document.createElement('div');

        selector.selected = '0';
        child.text = 'Item 0';

        Polymer.dom(selector).append(child);
        document.body.append(selector);

        await wait(1);
        expect(child.className, 'iron-selected');
        selector.remove();
      });
    });
  });
}
