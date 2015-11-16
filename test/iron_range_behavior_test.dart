@TestOn('browser')
library polymer_elements.test.iron_range_behavior_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_range_behavior.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initPolymer();

  group('<x-progressbar>', () {
    XProgressBar range;
    setUp(() {
      range = fixture('trivialRange');
    });

    test('check default', () {
      expect(range.min, 0);
      expect(range.max, 100);
      expect(range.value, 0);
    });

    test('set value', () async {
      range.value = 50;
      await wait(1);
      expect(range.value, 50);
      // test clamp value
      range.value = 60.1;
      await wait(1);
      expect(range.value, 60);
    });

    test('set max', () async {
      range.max = 10;
      range.value = 11;
      await wait(1);
      expect(range.value, range.max);
    });

    test('test ratio', () async {
      range.max = 10;
      range.value = 5;
      await wait(1);
      expect(range.ratio, 50);
    });

    test('set min', () async {
      range.min = 10;
      range.max = 50;
      range.value = 30;
      await wait(1);
      expect(range.ratio, 50);
      range.value = 0;
      await wait(1);
      expect(range.value, range.min);
    });

    test('set step', () async {
      range.min = 0;
      range.max = 10;
      range.value = 5.1;
      await wait(1);
      expect(range.value, 5);
      range.step = 0.1;
      range.value = 5.1;
      await wait(1);
      expect(range.value, 5.1);
    });

    test('odd values', () async {
      range.min = 1;
      range.max = 7;
      range.step = 2;
      range.value = 3;

      await wait(1);
      expect(range.value, 3);

      range.value += range.step;
      expect(range.value, 5);

      range.value += range.step;
      expect(range.value, 7);
    });

    test('negative values should round up', () async {
      range.min = -10;
      range.max = 10;
      range.step = 0.1;
      range.value = -8.4252;

      await wait(1);
      expect(range.value, -8.4);
    });

    test('positive values should round up', () async {
      range.min = 10;
      range.max = 100;
      range.step = 0.25;
      range.value = 19.34567;

      await wait(1);
      expect(range.value, 19.25);
    });
  });
}

@PolymerRegister('x-progressbar')
class XProgressBar extends PolymerElement with IronRangeBehavior {
  XProgressBar.created() : super.created();
}
