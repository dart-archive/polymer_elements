@TestOn('browser')
library polymer_elements.test.iron_selector_content_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_selector.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'fixtures/content_element.dart';

main() async {
  await initWebComponents();

  TestContentElement s1 = document.querySelector('#selector1');
  TestContentElement s2 = document.querySelector('#selector2');
  TestContentElement s3 = document.querySelector('#selector3');

  // TODO(jakemac): Remove JsObject conversion once
  // https://github.com/dart-lang/polymer_interop/issues/7 is implemented.
  var t = new JsObject.fromBrowserObject(document.querySelector('#t'));

  group('content', () {

    test('attribute selected', () {
      // check selected class
      expect(s1.querySelector('#item0').classes.contains('iron-selected'), isTrue);
    });

    test('set selected', () {
      // set selected
      s1.selected = 'item1';
      // check selected class
      expect(s1.querySelector('#item1').classes.contains('iron-selected'), isTrue);
    });

    test('get items', () {
      expect(s1.$['selector'].items.length, 4);
    });

    test('activate event', () {
      var item = s1.querySelector('#item2');
      item.dispatchEvent(new CustomEvent('tap', canBubble: true));
      // check selected class
      expect(item.classes.contains('iron-selected'), isTrue);
    });

    test('add item dynamically', () {
      var item = document.createElement('div');
      item.id = 'item4';
      item.text = 'item4';
      Polymer.dom(s1).append(item);
      PolymerDom.flush();
      // set selected
      s1.selected = 'item4';
      // check items length
      expect(s1.$['selector'].items.length, 5);
      // check selected class
      expect(s1.querySelector('#item4').classes.contains('iron-selected'), isTrue);
    });

  });

  group('content with selectable', () {

    test('attribute selected', () {
      // check selected class
      expect(s2.querySelector('#item0').classes.contains('iron-selected'), isTrue);
    });

    test('set selected', () {
      // set selected
      s2.selected = 'item1';
      // check selected class
      expect(s2.querySelector('#item1').classes.contains('iron-selected'), isTrue);
    });

    test('get items', () {
      expect(s2.$['selector'].items.length, 4);
    });

    test('activate event', () {
      var item = s2.querySelector('#item2');
      item.dispatchEvent(new CustomEvent('tap', canBubble: true));
      // check selected class
      expect(item.classes.contains('iron-selected'), isTrue);
    });

    test('add item dynamically', () {
      var item = document.createElement('item');
      item.id = 'item4';
      item.text = 'item4';
      Polymer.dom(s2).append(item);
      PolymerDom.flush();
      // set selected
      s2.selected = 'item4';
      // check items length
      expect(s2.$['selector'].items.length, 5);
      // check selected class
      expect(s2.querySelector('#item4').classes.contains('iron-selected'), isTrue);
    });

  });

  group('content with dom-repeat', () {

    test('supports repeated children', () {
      var done = new Completer();
      t['items'] = new JsObject.jsify([{'name':'item0'}, {'name': 'item1'}, {'name': 'item2'}, {'name': 'item3'}]);
      wait(1).then((_) {
        // check selected
        expect(s3.selected, 'item0');
        // check selected class
        expect(s3.querySelector('#item0').classes.contains('iron-selected'), isTrue);
        // set selected
        s3.selected = 'item2';
        // check selected class
        expect(s3.querySelector('#item2').classes.contains('iron-selected'), isTrue);
        done.complete();
      });

      return done.future;
    });

  });
}
