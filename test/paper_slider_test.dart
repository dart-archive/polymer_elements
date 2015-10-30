// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_slider_test;

import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/paper_slider.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<paper-slider>', () {
    PaperSlider slider;

    setUp(() {
      slider = fixture('trivialProgress');
    });

    test('check default', () {
      expect(slider.min, 0);
      expect(slider.max, 100);
      expect(slider.value, 0);
    });

    test('set value', () async {
      slider.value = 50;
      await wait(1);
      expect(slider.value, 50);
      // test clamp value
      slider.value = 60.1;
      await wait(1);
      expect(slider.value, 60);
    });

    test('set max', () async {
      slider.max = 10;
      slider.value = 11;
      await wait(1);
      expect(slider.value, slider.max);
    });

    test('ratio', () async {
      slider.max = 10;
      slider.value = 5;
      await wait(1);
      expect(slider.ratio, 0.5);
    });

    test('snaps', () async {
      slider.snaps = true;
      slider.step = 10;
      slider.max = 100;
      slider.value = 25;
      await wait(1);
      expect(slider.value, 30);

      slider.value = 51.1;

      await wait(1);
      expect(slider.value, 50);
      slider.snaps = false;
      slider.step = 1;
    });

    test('secondary progress', () async {
      slider.max = 10;
      slider.secondaryProgress = 50;
      await wait(1);
      expect(slider.secondaryProgress, slider.max);
    });

    test('increment', () async {
      slider.min = 0;
      slider.max = 10;
      slider.step = 2;
      slider.value = 0;
      slider.increment();

      await wait(1);
      expect(slider.value, slider.step);
      slider.step = 1;
    });

    test('decrement', () async {
      slider.min = 0;
      slider.max = 10;
      slider.step = 2;
      slider.value = 8;
      slider.decrement();

      await wait(1);
      expect(slider.value, 6);
      slider.step = 1;
    });

    test('editable', () async {
      slider.min = 0;
      slider.max = 10;
      slider.step = 1;
      slider.editable = true;

      await wait(1);
      slider.value = 2;
      expect((slider.$$('#input') as PaperInput).value, slider.value);
    });

    test('decimal values', () async {
      slider.min = 0;
      slider.max = 1;
      slider.value = slider.min;
      slider.step = 0.1;

      slider.increment();

      await wait(1);
      expect(slider.value, slider.step);
      expect(slider.$['sliderBar'].value, slider.step);
    });

    test('snap to the correct value on tapping', () async {
      var cursor = topLeftOfNode(slider.$['sliderBar']);
      cursor.x += slider.$['sliderBar'].getBoundingClientRect().width * 0.9;

      slider.min = 0;
      slider.max = 2;
      slider.step = 1;
      slider.value = 0;

      down(slider.$['sliderBar'], cursor);

      await wait(1);
      expect(slider.value, slider.max);
      slider.step = 1;
    });

    test('value should notify', () {
      var targetValue = 10;

      var done = slider.on['value-changed'].first.then((e) {
        expect(convertToDart(e).detail['value'], targetValue);
      });

      slider.min = 0;
      slider.max = 100;
      slider.value = targetValue;

      return done;
    });

    test('immediateValue should notify', () {
      var targetValue = 50;

      var done = slider.on['immediate-value-changed'].first.then((e) {
        expect(convertToDart(e).detail['value'], targetValue);
        expect(slider.immediateValue, targetValue);
      });

      var cursor = topLeftOfNode(slider.$['sliderBar']);
      cursor.x += slider.$['sliderBar'].getBoundingClientRect().width *
          targetValue /
          100;

      slider.min = 0;
      slider.max = 100;
      down(slider.$['sliderBar'], cursor);

      return done;
    });
  });
}
