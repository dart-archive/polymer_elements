// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_selector_basic_test;

import 'dart:async';
import 'dart:html';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer_elements/iron_selector.dart';
import 'package:polymer/polymer.dart';
import 'fixtures/attr_for_selected_elements.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:async';

main() async {
  await initPolymer();

  group('inline attributes', () {
    IronSelector selector;
    List items;

    setUp(() {
      selector = fixture('inlineAttributes');
      items = new List.from(selector.querySelectorAll('div[some-attr]'));
    });

    test('selecting value programatically selects correct item', () {
      selector.select('value1');
      expect(selector.selectedItem, items[1]);
    });

    test('selecting item sets the correct selected value', when((done) {
      downAndUp(items[2], () {
        expect(selector.selected, 'value2');
        done();
      });
    }));
  });

  group('reflected properties as attributes', () {
    IronSelector selector;
    List items;

    setUp(() {
      selector = fixture('reflectedProperties');
      items = new List.from(selector.querySelectorAll('attr-reflector'));
      for (var i = 0; i < items.length; i++) {
        items[i].set('someAttr', "value$i");
      }
    });

    test('selecting value programatically selects correct item', () {
      selector.select('value1');
      expect(selector.selectedItem, items[1]);
    });

    test('selecting item sets the correct selected value', when((done) {
      downAndUp(items[2], () {
        expect(selector.selected, 'value2');
        done();
      });
    }));
  });

  group('mixed properties and inline attributes', () {
    IronSelector selector;
    List items;

    setUp(() {
      selector = fixture('mixedPropertiesAndAttributes');
      items = new List.from(selector.querySelectorAll('attr-reflector, div[some-attr]'));
      for (var i = 0; i < items.length; i++) {
        if (items[i] is AttrReflector) {
          items[i].set('someAttr', "value$i");
        } else {
          items[i].attributes['someAttr'] = "value$i";
        }
      }
    });

    test('selecting value programatically selects correct item', () {
      for (var i = 0; i < items.length; i++) {
        selector.select('value$i');
        expect(selector.selectedItem, items[i]);
      }
    });

    test('selecting item sets the correct selected value', when((done) {
      var i = 0;

      testSelectItem(i) {
        if (i >= items.length) {
          done();
          return;
        }

        downAndUp(items[i], () {
          expect(selector.selected, 'value$i');

          testSelectItem(i + 1);
        });
      }

      testSelectItem(i);
    }));
  });

  suite('default attribute', () {
    IronSelector selector;
    List items;

    setup(() {
      selector = fixture('defaultAttribute');
      items = new List.from(selector.querySelectorAll('div[some-attr]'));
    });

    test('setting non-existing value sets default', () {
      selector.select('non-existing-value');
      $assert.equal(selector.selected, 'default');
      $assert.equal(selector.selectedItem, items[2]);
    });

    test('setting non-existing value sets default', () {
      selector.multi = true;
      selector.select(['non-existing-value']);
      $assert.deepEqual(selector.selectedValues, ['default']);
      $assert.deepEqual(selector.selectedItems, [items[2]]);
    });

    test('default not used when there was at least one match', () {
      selector.multi = true;
      selector.selectedValues = ['non-existing-value', 'value0'];
      $assert.deepEqual(selector.selectedValues, ['non-existing-value', 'value0']);
      $assert.deepEqual(selector.selectedItems, [items[0]]);
    });

    test('default element not found does not result in infinite loop', () {
      selector.fallbackSelection = 'non-existing-fallback';
      selector.select('non-existing-value');
      $assert.equal(selector.selectedItem, null);
      selector.multi = true;
      selector.selectedValues = ['non-existing-value'];
      $assert.deepEqual(selector.selectedItems, [null]);
      selector.fallbackSelection = 'default';
      $assert.deepEqual(selector.selectedItems, [items[2]]);
    });

    test('selection is updated after fallback is set', () {
      selector.fallbackSelection = null;
      selector.select('non-existing-value');
      selector.fallbackSelection = 'default';
      $assert.equal(selector.selectedItem, items[2]);
    });

    test('multi-selection is updated after fallback is set', () {
      selector.fallbackSelection = null;
      selector.selectedValues = ['non-existing-value'];
      selector.fallbackSelection = 'default';
      $assert.equal(selector.selectedItem, items[2]);
    });
  });
}
