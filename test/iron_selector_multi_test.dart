@TestOn('browser')
library polymer_elements.test.iron_selector_multi_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_selector.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('multi', () {
    IronSelector s;

    setUp( () {
      s = fixture('test');
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
