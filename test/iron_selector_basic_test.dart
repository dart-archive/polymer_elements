@TestOn('browser')
library polymer_elements.test.iron_selector_basic_test;

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

  group('defaults', () {
    IronSelector s1;

    setUp( () {
      s1 = fixture('defaults');
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

    setUp( () {
      s2 = fixture('basic');
    });

    test('honors the attrForSelected attribute', () {
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

  });
}
