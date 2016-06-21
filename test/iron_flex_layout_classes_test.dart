@TestOn('browser')
library polymer_elements.test.iron_flex_layout_classes_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
// ignore: UNUSED_IMPORT
import 'dart:js';
// ignore: UNUSED_IMPORT
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
// ignore: UNUSED_IMPORT
import 'package:web_components/web_components.dart';
import 'common.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/iron_flex_layout_classes.dart';

bool positionEquals(Element node, top, bottom, left, right) {
  Rectangle rect = node.getBoundingClientRect();
  //print ("NODE : ${rect.top},${rect.bottom},${rect.left},${rect.right}");
  return rect.top == top && rect.bottom == bottom && rect.left == left && rect.right == right;
}

main() async {
  await initPolymer();

  group('basic layout', () {
    Element container, c1, c2, c3;

    setUp(() {
      container = fixture('basic');
      c1 = container.querySelector("#c1");
      c2 = container.querySelector("#c2");
      c3 = container.querySelector("#c3");
    });

    test('layout-horizontal', () async {
      container.classes.add('horizontal');
      await new Future(() {});
      expect(positionEquals(container, 0, 50, 0, 300), isTrue, reason: "container position ok");
      // |c1| |c2| |c3|
      expect(positionEquals(c1, 0, 50, 0, 50), isTrue, reason: "child 1 position ok");
      expect(positionEquals(c2, 0, 50, 50, 100), isTrue, reason: "child 2 position ok");
      expect(positionEquals(c3, 0, 50, 100, 150), isTrue, reason: "child 3 position ok");
    });

    test('layout-horizontal-reverse', () {
      container.classes.add('horizontal-reverse');
      expect(positionEquals(container, 0, 50, 0, 300), isTrue, reason: "container position ok");
      //     |c3| |c2| |c1|
      expect(positionEquals(c1, 0, 50, 250, 300), isTrue, reason: "child 1 position ok");
      expect(positionEquals(c2, 0, 50, 200, 250), isTrue, reason: "child 2 position ok");
      expect(positionEquals(c3, 0, 50, 150, 200), isTrue, reason: "child 3 position ok");
    });

    test('layout-vertical', () {
      container.classes.add('vertical');
      expect(positionEquals(container, 0, 150, 0, 300), isTrue, reason: "container position ok");
      // vertically, |c1| |c2| |c3|
      expect(positionEquals(c1, 0, 50, 0, 50), isTrue, reason: "child 1 position ok");
      expect(positionEquals(c2, 50, 100, 0, 50), isTrue, reason: "child 2 position ok");
      expect(positionEquals(c3, 100, 150, 0, 50), isTrue, reason: "child 3 position ok");
    });

    test('layout-vertical-reverse', () {
      container.classes.add('vertical-reverse');
      expect(positionEquals(container, 0, 150, 0, 300), isTrue, reason: "container position ok");
      // vertically, |c3| |c2| |c1|
      expect(positionEquals(c1, 100, 150, 0, 50), isTrue, reason: "child 1 position ok");
      expect(positionEquals(c2, 50, 100, 0, 50), isTrue, reason: "child 2 position ok");
      expect(positionEquals(c3, 0, 50, 0, 50), isTrue, reason: "child 3 position ok");
    });

    test('layout-wrap', () {
      container.classes..add('horizontal')..add('wrap')..add('small');
      expect(positionEquals(container, 0, 100, 0, 120), isTrue, reason: "container position ok");
      // |c1| |c2|
      // |c3|
      expect(positionEquals(c1, 0, 50, 0, 50), isTrue, reason: "child 1 position ok");
      expect(positionEquals(c2, 0, 50, 50, 100), isTrue, reason: "child 2 position ok");
      expect(positionEquals(c3, 50, 100, 0, 50), isTrue, reason: "child 3 position ok");
    });

    test('layout-wrap-reverse', () {
      container.classes..add('horizontal-reverse')..add('wrap-reverse');
      container.style.width = '100px';
      expect(positionEquals(container, 0, 100, 0, 100), isTrue, reason: "container position ok");
      //      |c3|
      // |c2| |c1|
      expect(positionEquals(c1, 50, 100, 50, 100), isTrue, reason: "child 1 position ok");
      expect(positionEquals(c2, 50, 100, 0, 50), isTrue, reason: "child 2 position ok");
      expect(positionEquals(c3, 0, 50, 50, 100), isTrue, reason: "child 3 position ok");
    });
  },skip:'custom-style not applied in test runner');

  group('flex', () {
    Element container, c1, c2, c3;

    setUp(() {
      container = fixture('flex');
      c1 = container.querySelector("#c1");
      c2 = container.querySelector("#c2");
      c3 = container.querySelector("#c3");
    });

    test('layout-flex child in a horizontal layout', () {
      container.classes.add('horizontal');
      c2.classes.add('flex');
      expect(positionEquals(container, 0, 50, 0, 300), isTrue, reason: "container position ok");
      // |c1| |    c2    | |c3|
      expect(positionEquals(c1, 0, 50, 0, 50), isTrue, reason: "child 1 position ok");
      expect(positionEquals(c2, 0, 50, 50, 250), isTrue, reason: "child 2 position ok");
      expect(positionEquals(c3, 0, 50, 250, 300), isTrue, reason: "child 3 position ok");
    });

    test('layout-flex child in a vertical layout', () {
      container.classes.add('vertical');
      container.classes.add('tall');
      c2.classes.add('flex');
      expect(positionEquals(container, 0, 300, 0, 300), isTrue, reason: "container position ok");
      // vertically, |c1| |    c2    | |c3|
      expect(positionEquals(c1, 0, 50, 0, 50), isTrue, reason: "child 1 position ok");
      expect(positionEquals(c2, 50, 250, 0, 50), isTrue, reason: "child 2 position ok");
      expect(positionEquals(c3, 250, 300, 0, 50), isTrue, reason: "child 3 position ok");
    });

    test('layout-flex, layout-flex-2, layout-flex-3 in a horizontal layout', () {
      container.classes.add('horizontal');
      c1.classes.add('flex');
      c2.classes.add('flex-2');
      c3.classes.add('flex-3');
      expect(positionEquals(container, 0, 50, 0, 300), isTrue, reason: "container position ok");
      // |c1| | c2 | |  c3  |
      expect(positionEquals(c1, 0, 50, 0, 50), isTrue, reason: "child 1 position ok");
      expect(positionEquals(c2, 0, 50, 50, 150), isTrue, reason: "child 2 position ok");
      expect(positionEquals(c3, 0, 50, 150, 300), isTrue, reason: "child 3 position ok");
    });

    test('layout-flex, layout-flex-2, layout-flex-3 in a vertical layout', () {
      container.classes.add('vertical');
      container.classes.add('tall');
      c1.classes.add('flex');
      c2.classes.add('flex-2');
      c3.classes.add('flex-3');
      expect(positionEquals(container, 0, 300, 0, 300), isTrue, reason: "container position ok");
      // vertically, |c1| | c2 | |  c3  |
      expect(positionEquals(c1, 0, 50, 0, 50), isTrue, reason: "child 1 position ok");
      expect(positionEquals(c2, 50, 150, 0, 50), isTrue, reason: "child 2 position ok");
      expect(positionEquals(c3, 150, 300, 0, 50), isTrue, reason: "child 3 position ok");
    });
  },skip:'custom-style not applied in test runner');

  group('alignment', () {
    Element container, c1, c2, c3;

    setUp(() {
      container = fixture('single-child');
      container.classes.add('horizontal');
      c1 = container.querySelector("#c1");
      c2 = container.querySelector("#c2");
      c3 = container.querySelector("#c3");
    });

    test('stretch (default)', () {
      container.classes.add('tall');
      expect(positionEquals(container, 0, 300, 0, 300), isTrue, reason: "container position ok");
      expect(positionEquals(c1, 0, 300, 0, 50), isTrue, reason: "child 1 position ok");
    });

    test('layout-center', () {
      container.classes.add('center');
      container.classes.add('tall');
      expect(positionEquals(container, 0, 300, 0, 300), isTrue, reason: "container position ok");
      var center = (300 - 50) / 2;
      expect(positionEquals(c1, center, center + 50, 0, 50), isTrue, reason: "child 1 position ok");
    });

    test('layout-start', () {
      container.classes.add('start');
      container.classes.add('tall');
      expect(positionEquals(container, 0, 300, 0, 300), isTrue, reason: "container position ok");
      expect(positionEquals(c1, 0, 50, 0, 50), isTrue, reason: "child 1 position ok");
    });

    test('layout-end', () {
      container.classes.add('end');
      container.classes.add('tall');
      expect(positionEquals(container, 0, 300, 0, 300), isTrue, reason: "container position ok");
      expect(positionEquals(c1, 250, 300, 0, 50), isTrue, reason: "child 1 position ok");
    });

    test('layout-start-justified', () {
      container.classes.add('start-justified');
      expect(positionEquals(container, 0, 50, 0, 300), isTrue, reason: "container position ok");
      expect(positionEquals(c1, 0, 50, 0, 50), isTrue, reason: "child 1 position ok");
    });

    test('layout-end-justified', () {
      container.classes.add('end-justified');
      expect(positionEquals(container, 0, 50, 0, 300), isTrue, reason: "container position ok");
      expect(positionEquals(c1, 0, 50, 250, 300), isTrue, reason: "child 1 position ok");
    });

    test('layout-center-justified', () {
      container.classes.add('center-justified');
      expect(positionEquals(container, 0, 50, 0, 300), isTrue, reason: "container position ok");
      var center = (300 - 50) / 2;
      expect(positionEquals(c1, 0, 50, center, center + 50), isTrue, reason: "child 1 position ok");
    });
  },skip:'custom-style not applied in test runner');

  group('justification', () {
    Element container, c1, c2, c3;

    setUp(() {
      container = fixture('flex');
      container.classes.add('horizontal');
      c1 = container.querySelector("#c1");
      c2 = container.querySelector("#c2");
      c3 = container.querySelector("#c3");
    });

    test('layout-justified', () {
      container.classes.add('justified');
      expect(positionEquals(container, 0, 50, 0, 300), isTrue, reason: "container position ok");
      var center = (300 - 50) / 2;
      expect(positionEquals(c1, 0, 50, 0, 50), isTrue, reason: "child 1 position ok");
      expect(positionEquals(c2, 0, 50, center, center + 50), isTrue, reason: "child 2 position ok");
      expect(positionEquals(c3, 0, 50, 250, 300), isTrue, reason: "child 3 position ok");
    });

    test('layout-around-justified', () {
      container.classes.add('around-justified');
      expect(positionEquals(container, 0, 50, 0, 300), isTrue, reason: "container position ok");
      var spacing = (300 - 50 * 3) / 6;
      // Every child gets `spacing` on its left and right side.
      expect(positionEquals(c1, 0, 50, spacing, spacing + 50), isTrue, reason: "child 1 position ok");
      var end = spacing + 50 + spacing;
      expect(positionEquals(c2, 0, 50, end + spacing, end + spacing + 50), isTrue, reason: "child 2 position ok");
      end = end + spacing + 50 + spacing;
      expect(positionEquals(c3, 0, 50, end + spacing, end + spacing + 50), isTrue, reason: "child 3 position ok");
    });
  },skip:'custom-style not applied in test runner');

  group('align-content', () {
    Element container, c1, c2, c3, c4, c5;

    setUp(() {
      container = fixture('align-content');
      container.classes.add('small');
      container.classes.add('tall');
      container.classes.add('horizontal');
      container.classes.add('flex');
      container.classes.add('wrap');
      c1 = container.querySelector("#c1");
      c2 = container.querySelector("#c2");
      c3 = container.querySelector("#c3");
      c4 = container.querySelector("#c4");
      c5 = container.querySelector("#c5");
    });

    test('default is stretch', () {
      expect(positionEquals(container, 0, 300, 0, 120), isTrue, reason: "container position ok");
      expect(positionEquals(c1, 0, 100, 0, 50), isTrue, reason: "child 1 position ok");
      expect(positionEquals(c2, 0, 100, 50, 100), isTrue, reason: "child 2 position ok");
      expect(positionEquals(c3, 100, 200, 0, 50), isTrue, reason: "child 3 position ok");
      expect(positionEquals(c4, 100, 200, 50, 100), isTrue, reason: "child 4 position ok");
      expect(positionEquals(c5, 200, 300, 0, 50), isTrue, reason: "child 5 position ok");
    });

    test('layout-start-aligned', () {
      container.classes.add('start-aligned');
      expect(positionEquals(container, 0, 300, 0, 120), isTrue, reason: "container position ok");
      expect(positionEquals(c1, 0, 50, 0, 50), isTrue, reason: "child 1 position ok");
      expect(positionEquals(c2, 0, 50, 50, 100), isTrue, reason: "child 2 position ok");
      expect(positionEquals(c3, 50, 100, 0, 50), isTrue, reason: "child 3 position ok");
      expect(positionEquals(c4, 50, 100, 50, 100), isTrue, reason: "child 4 position ok");
      expect(positionEquals(c5, 100, 150, 0, 50), isTrue, reason: "child 5 position ok");
    });

    test('layout-end-aligned', () {
      container.classes.add('end-aligned');
      expect(positionEquals(container, 0, 300, 0, 120), isTrue, reason: "container position ok");
      expect(positionEquals(c1, 150, 200, 0, 50), isTrue, reason: "child 1 position ok");
      expect(positionEquals(c2, 150, 200, 50, 100), isTrue, reason: "child 2 position ok");
      expect(positionEquals(c3, 200, 250, 0, 50), isTrue, reason: "child 3 position ok");
      expect(positionEquals(c4, 200, 250, 50, 100), isTrue, reason: "child 4 position ok");
      expect(positionEquals(c5, 250, 300, 0, 50), isTrue, reason: "child 5 position ok");
    });

    test('layout-center-aligned', () {
      container.classes.add('center-aligned');
      expect(positionEquals(container, 0, 300, 0, 120), isTrue, reason: "container position ok");
      var center = (300 - 50) / 2;
      expect(positionEquals(c1, center - 50, center, 0, 50), isTrue, reason: "child 1 position ok");
      expect(positionEquals(c2, center - 50, center, 50, 100), isTrue, reason: "child 2 position ok");
      expect(positionEquals(c3, center, center + 50, 0, 50), isTrue, reason: "child 3 position ok");
      expect(positionEquals(c4, center, center + 50, 50, 100), isTrue, reason: "child 4 position ok");
      expect(positionEquals(c5, center + 50, center + 100, 0, 50), isTrue, reason: "child 5 position ok");
    });

    test('layout-between-aligned', () {
      container.classes.add('between-aligned');
      expect(positionEquals(container, 0, 300, 0, 120), isTrue, reason: "container position ok");
      var center = (300 - 50) / 2;
      expect(positionEquals(c1, 0, 50, 0, 50), isTrue, reason: "child 1 position ok");
      expect(positionEquals(c2, 0, 50, 50, 100), isTrue, reason: "child 2 position ok");
      expect(positionEquals(c3, center, center + 50, 0, 50), isTrue, reason: "child 3 position ok");
      expect(positionEquals(c4, center, center + 50, 50, 100), isTrue, reason: "child 4 position ok");
      expect(positionEquals(c5, 250, 300, 0, 50), isTrue, reason: "child 5 position ok");
    });

    test('layout-around-aligned', () {
      container.classes.add('around-aligned');
      expect(positionEquals(container, 0, 300, 0, 120), isTrue, reason: "container position ok");
      var center = (300 - 50) / 2;
      expect(positionEquals(c1, 25, 75, 0, 50), isTrue, reason: "child 1 position ok");
      expect(positionEquals(c2, 25, 75, 50, 100), isTrue, reason: "child 2 position ok");
      expect(positionEquals(c3, center, center + 50, 0, 50), isTrue, reason: "child 3 position ok");
      expect(positionEquals(c4, center, center + 50, 50, 100), isTrue, reason: "child 4 position ok");
      expect(positionEquals(c5, 225, 275, 0, 50), isTrue, reason: "child 5 position ok");
    });
  },skip:'custom-style not applied in test runner');

  group('positioning', () {
    Element container, c1;

    setUp(() {
      container = fixture('positioning');
      container.classes.add('tall');
      c1 = container.querySelector("#c1");
    });

    test('layout-fit', () {
      c1.classes.add('fit');
      expect(positionEquals(container, 0, 300, 0, 300), isTrue, reason: "container position ok");
      expect(positionEquals(container, 0, 300, 0, 300), isTrue, reason: "child 1 position ok");
    });
  },skip:'custom-style not applied in test runner');
}
