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

/// Used imports: [AResizablePage], [BResizablePage], [CResizablePage]
main() async {
  await initPolymer();

  group('<neon-animated-pages>', () {
    group('notify-resize', () {
      test('only a destination page receives a resize event', () async {
        NeonAnimatedPages animatedPages = fixture('notify-resize');
        await new Future(() {});
        List<Element> resizables = Polymer.dom(animatedPages).children;
        Map receives = {};
        resizables.forEach((Element page) {
          page.on['iron-resize'].listen((Event e) {
            var pageName = (e.currentTarget as Element).tagName;
            receives[pageName] =
                receives.containsKey(pageName) ? receives[pageName] + 1 : 1;
          });
        });

        animatedPages.selected = 2;

        await wait(50);

        expect(receives, equals({'C-RESIZABLE-PAGE': 1}));
      });
    });
  });


  suite('animate-initial-selection', () {
    test('\'neon-animation-finish\' event fired after animating initial selection', when((done) {
      var animatedPages = fixture('animate-initial-selection');
      $assert.isUndefined(animatedPages.selected);
      var pages = new PolymerDom(animatedPages)
          .children;
      animatedPages.on['neon-animation-finish'].take(1).listen((event) {
        $assert.strictEqual(animatedPages.selected, 0);
        $assert.isFalse(new CustomEventWrapper(event).detail['fromPage']);
        $assert.deepEqual(new CustomEventWrapper(event).detail['toPage'], pages[0]);
        done();
      });
      animatedPages.selected = 0;
    }));
  });
}
