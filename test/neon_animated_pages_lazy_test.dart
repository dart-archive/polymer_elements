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

/// Used imports: [AResizablePage], [BResizablePage], [CResizablePage]
main() async {
  await initPolymer();

  suite('animations found when `lazRegister` setting is true', () {
    test('animations are registered', when((done) {
      NeonAnimatedPages animatedPages = fixture('animate-initial-selection');

      List<JsArray> calls = [];
      animatedPages.jsElement['_completeAnimations'] = (JsArray args) {
        calls.add(args);
      };
      $assert.isUndefined(animatedPages.selected);
      var pages = Polymer
          .dom(animatedPages)
          .children;
      animatedPages.on['neon-animation-finish'].listen((_) {
        CustomEvent event = new CustomEventWrapper(_);
        if (animatedPages.selected == 0) {
          animatedPages.selected = 1;
          return;
        }
        $assert.strictEqual(animatedPages.selected, 1);
        $assert.equal(event.detail['fromPage'], pages[0]);
        $assert.equal(event.detail['toPage'], pages[1]);
        $assert.isTrue(calls.length == 2);
        var a$ = calls[1];
        $assert.isTrue((a$[0]['animation'] as NeonAnimationBehavior).isNeonAnimation, 'default animation is not a registered animation');
        $assert.isTrue((a$[1]['animation'] as NeonAnimationBehavior).isNeonAnimation, 'entry animation is not a registered animation');
        $assert.isTrue((a$[2]['animation'] as NeonAnimationBehavior).isNeonAnimation, 'exit animation is not a registered animation');
        done();
      });
      animatedPages.selected = 0;
    }));
  });
}
