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
import 'package:polymer_elements/iron_flex_layout.dart';

bool positionEquals(Element node, top, bottom, left, right) {
  Rectangle rect = node.getBoundingClientRect();
  //print ("NODE : ${rect.top},${rect.bottom},${rect.left},${rect.right}");
  return rect.top == top && rect.bottom == bottom && rect.left == left && rect.right == right;
}

@behavior
abstract class FlexLayoutTestBehavior implements PolymerBase {
  DivElement get container => new PolymerDom(root).querySelector(".container");
  DivElement get c1 => $['c1'];
  DivElement get c2 => $['c2'];
  DivElement get c3 => $['c3'];
  DivElement get c4 => $['c4'];
  DivElement get c5 => $['c5'];
}

@PolymerRegister('test-styles')
class TestStyles extends PolymerElement {
  TestStyles.created() : super.created();
}

@PolymerRegister('basic-test')
class BasicTest extends PolymerElement with FlexLayoutTestBehavior {
  BasicTest.created() : super.created();
}

@PolymerRegister('flex-test')
class FlexTest extends PolymerElement  with FlexLayoutTestBehavior {
  FlexTest.created() : super.created();
}

@PolymerRegister('single-child-test')
class SingleChildTest extends PolymerElement with FlexLayoutTestBehavior {
  SingleChildTest.created() : super.created();
}


@PolymerRegister('positioning-test')
class PositioningTest extends PolymerElement with FlexLayoutTestBehavior {
  PositioningTest.created() : super.created();
}


@PolymerRegister('align-content-test')
class AlignContentTest extends PolymerElement with FlexLayoutTestBehavior {
  AlignContentTest.created() : super.created();
}


main() async {
  await initPolymer();

  suite('basic layout', () {
    BasicTest basicTest;
    DivElement container;
    DivElement c1, c2, c3;

    setup(() {
      basicTest = fixture('basic');
      container = basicTest.container;
      c1 = basicTest.c1;
      c2 = basicTest.c2;
      c3 = basicTest.c3;
    });

    test('--layout-horizontal', () {
      container.classes.add('horizontal');
      $assert.isTrue(positionEquals(container, 0, 50, 0, 300), "container position ok");
      // |c1| |c2| |c3|
      $assert.isTrue(positionEquals(c1, 0, 50, 0, 50), "child 1 position ok");
      $assert.isTrue(positionEquals(c2, 0, 50, 50, 100), "child 2 position ok");
      $assert.isTrue(positionEquals(c3, 0, 50, 100, 150), "child 3 position ok");
    });

    test('--layout-horizontal-reverse', () {
      container.classes.add('horizontal-reverse');
      $assert.isTrue(positionEquals(container, 0, 50, 0, 300), "container position ok");
      //     |c3| |c2| |c1|
      $assert.isTrue(positionEquals(c1, 0, 50, 250, 300), "child 1 position ok");
      $assert.isTrue(positionEquals(c2, 0, 50, 200, 250), "child 2 position ok");
      $assert.isTrue(positionEquals(c3, 0, 50, 150, 200), "child 3 position ok");
    });

    test('--layout-vertical', () {
      container.classes.add('vertical');
      $assert.isTrue(positionEquals(container, 0, 150, 0, 300), "container position ok");
      // vertically, |c1| |c2| |c3|
      $assert.isTrue(positionEquals(c1, 0, 50, 0, 50), "child 1 position ok");
      $assert.isTrue(positionEquals(c2, 50, 100, 0, 50), "child 2 position ok");
      $assert.isTrue(positionEquals(c3, 100, 150, 0, 50), "child 3 position ok");
    });

    test('--layout-vertical-reverse', () {
      container.classes.add('vertical-reverse');
      $assert.isTrue(positionEquals(container, 0, 150, 0, 300), "container position ok");
      // vertically, |c3| |c2| |c1|
      $assert.isTrue(positionEquals(c1, 100, 150, 0, 50), "child 1 position ok");
      $assert.isTrue(positionEquals(c2, 50, 100, 0, 50), "child 2 position ok");
      $assert.isTrue(positionEquals(c3, 0, 50, 0, 50), "child 3 position ok");
    });

    test('--layout-wrap', () {
      container.classes.add('horizontal');
      container.classes.add('wrap');
      container.classes.add('small');
      $assert.isTrue(positionEquals(container, 0, 100, 0, 120), "container position ok");
      // |c1| |c2|
      // |c3|
      $assert.isTrue(positionEquals(c1, 0, 50, 0, 50), "child 1 position ok");
      $assert.isTrue(positionEquals(c2, 0, 50, 50, 100), "child 2 position ok");
      $assert.isTrue(positionEquals(c3, 50, 100, 0, 50), "child 3 position ok");
    });

    test('--layout-wrap-reverse', () {
      container.classes.add('horizontal');
      container.classes.add('wrap-reverse');
      container.classes.add('small');
      $assert.isTrue(positionEquals(container, 0, 100, 0, 120), "container position ok");
      // |c3|
      // |c1| |c2|
      $assert.isTrue(positionEquals(c1, 50, 100, 0, 50), "child 1 position ok");
      $assert.isTrue(positionEquals(c2, 50, 100, 50, 100), "child 2 position ok");
      $assert.isTrue(positionEquals(c3, 0, 50, 0, 50), "child 3 position ok");
    });
  });

  suite('flex', () {
    FlexTest flexTest;
    DivElement container;
    DivElement c1, c2, c3;

    setup(() {
      flexTest = fixture('flex');
      container = flexTest.container;
      c1 = flexTest.c1;
      c2 = flexTest.c2;
      c3 = flexTest.c3;
    });

    test('--layout-flex child in a horizontal layout', () {
      container.classes.add('horizontal');
      c2.classes.add('flex');
      $assert.isTrue(positionEquals(container, 0, 50, 0, 300), "container position ok");
      // |c1| |    c2    | |c3|
      $assert.isTrue(positionEquals(c1, 0, 50, 0, 50), "child 1 position ok");
      $assert.isTrue(positionEquals(c2, 0, 50, 50, 250), "child 2 position ok");
      $assert.isTrue(positionEquals(c3, 0, 50, 250, 300), "child 3 position ok");
    });

    test('--layout-flex child in a vertical layout', () {
      container.classes.add('vertical');
      container.classes.add('tall');
      c2.classes.add('flex');
      $assert.isTrue(positionEquals(container, 0, 300, 0, 300), "container position ok");
      // vertically, |c1| |    c2    | |c3|
      $assert.isTrue(positionEquals(c1, 0, 50, 0, 50), "child 1 position ok");
      $assert.isTrue(positionEquals(c2, 50, 250, 0, 50), "child 2 position ok");
      $assert.isTrue(positionEquals(c3, 250, 300, 0, 50), "child 3 position ok");
    });

    test('--layout-flex, --layout-flex-2, --layout-flex-3 in a horizontal layout', () {
      container.classes.add('horizontal');
      c1.classes.add('flex');
      c2.classes.add('flex2');
      c3.classes.add('flex3');
      $assert.isTrue(positionEquals(container, 0, 50, 0, 300), "container position ok");
      // |c1| | c2 | |  c3  |
      $assert.isTrue(positionEquals(c1, 0, 50, 0, 50), "child 1 position ok");
      $assert.isTrue(positionEquals(c2, 0, 50, 50, 150), "child 2 position ok");
      $assert.isTrue(positionEquals(c3, 0, 50, 150, 300), "child 3 position ok");
    });

    test('--layout-flex, --layout-flex-2, --layout-flex-3 in a vertical layout', () {
      container.classes.add('vertical');
      container.classes.add('tall');
      c1.classes.add('flex');
      c2.classes.add('flex2');
      c3.classes.add('flex3');
      $assert.isTrue(positionEquals(container, 0, 300, 0, 300), "container position ok");
      // vertically, |c1| | c2 | |  c3  |
      $assert.isTrue(positionEquals(c1, 0, 50, 0, 50), "child 1 position ok");
      $assert.isTrue(positionEquals(c2, 50, 150, 0, 50), "child 2 position ok");
      $assert.isTrue(positionEquals(c3, 150, 300, 0, 50), "child 3 position ok");
    });
  });

  suite('alignment', () {
    SingleChildTest singleChildTest;
    DivElement container;
    DivElement c1;

    setup(() {
      singleChildTest = fixture('single-child');
      container = singleChildTest.container;
      container.classes.add('horizontal');
      c1 = singleChildTest.c1;
    });

    test('stretch (default)', () {
      container.classes.add('tall');
      $assert.isTrue(positionEquals(container, 0, 300, 0, 300), "container position ok");
      $assert.isTrue(positionEquals(c1, 0, 300, 0, 50), "child 1 position ok");
    });

    test('--layout-center', () {
      container.classes.add('center');
      container.classes.add('tall');
      $assert.isTrue(positionEquals(container, 0, 300, 0, 300), "container position ok");
      var center = (300 - 50) / 2;
      $assert.isTrue(positionEquals(c1, center, center + 50, 0, 50), "child 1 position ok");
    });

    test('--layout-start', () {
      container.classes.add('start');
      container.classes.add('tall');
      $assert.isTrue(positionEquals(container, 0, 300, 0, 300), "container position ok");
      $assert.isTrue(positionEquals(c1, 0, 50, 0, 50), "child 1 position ok");
    });

    test('--layout-end', () {
      container.classes.add('end');
      container.classes.add('tall');
      $assert.isTrue(positionEquals(container, 0, 300, 0, 300), "container position ok");
      $assert.isTrue(positionEquals(c1, 250, 300, 0, 50), "child 1 position ok");
    });

    test('--layout-start-justified', () {
      container.classes.add('start-justified');
      $assert.isTrue(positionEquals(container, 0, 50, 0, 300), "container position ok");
      $assert.isTrue(positionEquals(c1, 0, 50, 0, 50), "child 1 position ok");
    });

    test('--layout-end-justified', () {
      container.classes.add('end-justified');
      $assert.isTrue(positionEquals(container, 0, 50, 0, 300), "container position ok");
      $assert.isTrue(positionEquals(c1, 0, 50, 250, 300), "child 1 position ok");
    });

    test('--layout-center-justified', () {
      container.classes.add('center-justified');
      $assert.isTrue(positionEquals(container, 0, 50, 0, 300), "container position ok");
      var center = (300 - 50) / 2;
      $assert.isTrue(positionEquals(c1, 0, 50, center, center + 50), "child 1 position ok");
    });
  });

  suite('justification', () {
    FlexTest flexTest;
    DivElement container, c1, c2, c3;

    setup(() {
      flexTest = fixture('flex');
      container = flexTest.container;
      container.classes.add('horizontal');
      c1 = flexTest.c1;
      c2 = flexTest.c2;
      c3 = flexTest.c3;
    });

    test('--layout-justified', () {
      container.classes.add('justified');
      $assert.isTrue(positionEquals(container, 0, 50, 0, 300), "container position ok");
      var center = (300 - 50) / 2;
      $assert.isTrue(positionEquals(c1, 0, 50, 0, 50), "child 1 position ok");
      $assert.isTrue(positionEquals(c2, 0, 50, center, center + 50), "child 2 position ok");
      $assert.isTrue(positionEquals(c3, 0, 50, 250, 300), "child 3 position ok");
    });

    test('--layout-around-justified', () {
      container.classes.add('around-justified');
      $assert.isTrue(positionEquals(container, 0, 50, 0, 300), "container position ok");
      var spacing = (300 - 50 * 3) / 6;
      // Every child gets `spacing` on its left and right side.
      $assert.isTrue(positionEquals(c1, 0, 50, spacing, spacing + 50), "child 1 position ok");
      var end = spacing + 50 + spacing;
      $assert.isTrue(positionEquals(c2, 0, 50, end + spacing, end + spacing + 50), "child 2 position ok");
      end = end + spacing + 50 + spacing;
      $assert.isTrue(positionEquals(c3, 0, 50, end + spacing, end + spacing + 50), "child 3 position ok");
    });
  });

  suite('align-content', () {
    AlignContentTest alignContentTest;
    DivElement container, c1, c2, c3, c4, c5;

    setup(() {
      alignContentTest = fixture('align-content');
      container = alignContentTest.container;
      c1 = alignContentTest.c1;
      c2 = alignContentTest.c2;
      c3 = alignContentTest.c3;
      c4 = alignContentTest.c4;
      c5 = alignContentTest.c5;
    });

    test('default is stretch', () {
      $assert.isTrue(positionEquals(container, 0, 300, 0, 120), "container position ok");
      $assert.isTrue(positionEquals(c1, 0, 100, 0, 50), "child 1 position ok");
      $assert.isTrue(positionEquals(c2, 0, 100, 50, 100), "child 2 position ok");
      $assert.isTrue(positionEquals(c3, 100, 200, 0, 50), "child 3 position ok");
      $assert.isTrue(positionEquals(c4, 100, 200, 50, 100), "child 4 position ok");
      $assert.isTrue(positionEquals(c5, 200, 300, 0, 50), "child 5 position ok");
    });

    test('--layout-start-aligned', () {
      container.classes.add('start-aligned');
      $assert.isTrue(positionEquals(container, 0, 300, 0, 120), "container position ok");
      $assert.isTrue(positionEquals(c1, 0, 50, 0, 50), "child 1 position ok");
      $assert.isTrue(positionEquals(c2, 0, 50, 50, 100), "child 2 position ok");
      $assert.isTrue(positionEquals(c3, 50, 100, 0, 50), "child 3 position ok");
      $assert.isTrue(positionEquals(c4, 50, 100, 50, 100), "child 4 position ok");
      $assert.isTrue(positionEquals(c5, 100, 150, 0, 50), "child 5 position ok");
    });

    test('--layout-end-aligned', () {
      container.classes.add('end-aligned');
      $assert.isTrue(positionEquals(container, 0, 300, 0, 120), "container position ok");
      $assert.isTrue(positionEquals(c1, 150, 200, 0, 50), "child 1 position ok");
      $assert.isTrue(positionEquals(c2, 150, 200, 50, 100), "child 2 position ok");
      $assert.isTrue(positionEquals(c3, 200, 250, 0, 50), "child 3 position ok");
      $assert.isTrue(positionEquals(c4, 200, 250, 50, 100), "child 4 position ok");
      $assert.isTrue(positionEquals(c5, 250, 300, 0, 50), "child 5 position ok");
    });

    test('--layout-center-aligned', () {
      container.classes.add('center-aligned');
      $assert.isTrue(positionEquals(container, 0, 300, 0, 120), "container position ok");
      var center = (300 - 50) / 2;
      $assert.isTrue(positionEquals(c1, center - 50, center, 0, 50), "child 1 position ok");
      $assert.isTrue(positionEquals(c2, center - 50, center, 50, 100), "child 2 position ok");
      $assert.isTrue(positionEquals(c3, center, center + 50, 0, 50), "child 3 position ok");
      $assert.isTrue(positionEquals(c4, center, center + 50, 50, 100), "child 4 position ok");
      $assert.isTrue(positionEquals(c5, center + 50, center + 100, 0, 50), "child 5 position ok");
    });

    test('--layout-between-aligned', () {
      container.classes.add('between-aligned');
      $assert.isTrue(positionEquals(container, 0, 300, 0, 120), "container position ok");
      var center = (300 - 50) / 2;
      $assert.isTrue(positionEquals(c1, 0, 50, 0, 50), "child 1 position ok");
      $assert.isTrue(positionEquals(c2, 0, 50, 50, 100), "child 2 position ok");
      $assert.isTrue(positionEquals(c3, center, center + 50, 0, 50), "child 3 position ok");
      $assert.isTrue(positionEquals(c4, center, center + 50, 50, 100), "child 4 position ok");
      $assert.isTrue(positionEquals(c5, 250, 300, 0, 50), "child 5 position ok");
    });

    test('--layout-around-aligned', () {
      container.classes.add('around-aligned');
      $assert.isTrue(positionEquals(container, 0, 300, 0, 120), "container position ok");
      var center = (300 - 50) / 2;
      $assert.isTrue(positionEquals(c1, 25, 75, 0, 50), "child 1 position ok");
      $assert.isTrue(positionEquals(c2, 25, 75, 50, 100), "child 2 position ok");
      $assert.isTrue(positionEquals(c3, center, center + 50, 0, 50), "child 3 position ok");
      $assert.isTrue(positionEquals(c4, center, center + 50, 50, 100), "child 4 position ok");
      $assert.isTrue(positionEquals(c5, 225, 275, 0, 50), "child 5 position ok");
    });
  });

  suite('positioning', () {
    PositioningTest positioningTest;
    DivElement container, c1;

    setup(() {
      positioningTest =fixture('positioning');
      container = positioningTest.container;
      container.classes.add('tall');
      c1 = positioningTest.c1;
    });

    test('--layout-fit', () {
      c1.classes.add('fit');
      $assert.isTrue(positionEquals(container, 0, 300, 0, 300), "container position ok");
      $assert.isTrue(positionEquals(container, 0, 300, 0, 300), "child 1 position ok");
    });
  });
}
