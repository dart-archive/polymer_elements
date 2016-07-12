// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.neon_animated_pages_test;

import 'dart:async';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer_elements/neon_animated_pages.dart';
import 'package:test/test.dart';
import 'common.dart';
import 'fixtures/neon_test_resizable_pages.dart';
import 'package:polymer_elements/neon_animation/animations/slide_from_left_animation.dart';
import 'package:polymer_elements/neon_animation/animations/slide_right_animation.dart';
import 'package:polymer_elements/neon_animatable.dart';
import 'dart:js';
import 'package:polymer_elements/neon_animation/animations/opaque_animation.dart';
import 'package:polymer_elements/neon_animation_behavior.dart';
import 'package:polymer_elements/iron_selector.dart';

/// Used imports: [AResizablePage], [BResizablePage], [CResizablePage]
main() async {
  await initPolymer();

  suite('descendant selection', () {
    test('descendents of other selectors are not animated', () {
      NeonAnimatedPages animatedPages = fixture('descendant-selection');
      var selector = new PolymerDom(animatedPages).querySelector('#selector');
      var target = new PolymerDom(animatedPages).querySelector('#target');
      new PolymerDom(selector).setAttribute('selected', '1');
      $$assert("yep"!=target.getAttribute("animated"));
    });
    test('elements distributed as children are animated', () {
      TestElement testElement = fixture('distributed-children');
      var target = new PolymerDom(testElement).querySelector('#target');
      NeonAnimatedPages animatedPages = new PolymerDom(testElement.root).querySelector("neon-animated-pages");
      new PolymerDom(animatedPages).setAttribute('selected', '1');
      $$assert("yep"==target.getAttribute("animated"));
    });
    test('ignores selection from shadow descendants of its items', () {
      NeonAnimatedPages pages = fixture('selecting-item');
      var target = new PolymerDom(pages).querySelector('#target');
      XSelectingElement selecting = new PolymerDom(pages).querySelector('x-selecting-element');
      (selecting.$['selector'] as IronSelector).selected = 1;
      $$assert("yep"!=target.getAttribute("animated"));
    });
  });
}

@PolymerRegister('x-selecting-element')
class XSelectingElement extends PolymerElement {
  XSelectingElement.created() : super.created();
}

@PolymerRegister('test-element')
class TestElement extends PolymerElement with NeonAnimationBehavior {
  TestElement.created() : super.created();


}

@PolymerRegister('test-animation')
class TestAnimation extends PolymerElement with NeonAnimationBehavior {
  TestAnimation.created():super.created();

  @reflectable
  configure(config) {
    config['node'].setAttribute('animated',"yep");
  }
}
