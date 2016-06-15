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
import 'sinon/sinon.dart';

main() async {
  await initWebComponents();

  suite('a11y',() {
    PaperSlider slider;

    setup(() {
      slider = fixture('trivialSlider');
    });

    test('has aria role "slider"', () {
      $assert.equal(slider.getAttribute('role'), 'slider');
      $assert.equal(slider.getAttribute('aria-valuemin'), slider.min.toString());
      $assert.equal(slider.getAttribute('aria-valuemax'), slider.max.toString());
      $assert.equal(slider.getAttribute('aria-valuenow'), slider.value.toString());
    });

    test('ripple is added after keyboard event on knob', () {
      $assert.isFalse(slider.hasRipple());
      down(slider.$['sliderKnob']);
      $assert.isTrue(slider.hasRipple());
    });

    test('interacting without keyboard causes no ripple', () {
      focus(slider);
      down(slider.$['sliderKnob']);
      var ripple = slider.getRipple();
      $assert.equal(ripple.offsetHeight, 0);
      $assert.equal(ripple.offsetWidth, 0);
    });

    test('interacting with keyboard causes ripple', () {
      focus(slider);
      pressSpace(slider.$['sliderKnob']);
      var ripple = slider.getRipple();
      $assert.isAbove(ripple.offsetHeight, 0);
      $assert.isAbove(ripple.offsetWidth, 0);
    });

    test('slider has focus after click event on bar"', () {
      Spy focusSpy = spy(slider.jsElement, 'focus');
      down(slider.$['sliderBar']);
      $assert.isTrue(focusSpy.called);
    });
  });
}
