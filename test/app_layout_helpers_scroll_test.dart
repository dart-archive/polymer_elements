// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.app_scroll_effects_fade_background_test;

import 'package:polymer_interop/polymer_interop.dart';

import 'sinon/sinon.dart' as sinon;
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'dart:js';
import 'fixtures/x_container.dart';
import 'package:polymer_elements/app_layout/app_scroll_effects/effects/fade_background.dart';
import 'package:polymer_elements/app_layout_helpers.dart';

/// Used tests: [IronIcon], [iron_icons]

main() async {
  await initPolymer();

  suite('AppLayout.scroll', () {
    setUp(() {
      showTestRunnerFrame();
      document.body.style.overflow = 'hidden';
      document.body.parent.style.overflow = 'auto';
    });


    testAsync('document scrolling', (done) {
      var x = 500;
      var y = 500;
      var region = document.querySelector('#region');

      AppLayout.scroll(new JsObject.jsify({"left": x, "top": y}));

      $async(() {
        $assert.equal(window.pageXOffset, x, 'document scrollLeft');
        $assert.equal(window.pageYOffset, y, 'document scrollTop');
        done();
      }, 100);
    });

    testAsync('scrolling region', (done) {
      var x = 500;
      var y = 500;
      var region = document.querySelector('#region');

      AppLayout.scroll({"left": x, "top": y, "target": region});

      $async(() {
        $assert.equal(region.scrollLeft, x, 'region scrollLeft');
        $assert.equal(region.scrollTop, y, 'region scrollTop');
        done();
      }, 100);
    });

    test('behavior: silent', () {
      AppLayout.scroll({"left": 100, "top": 200, behavior: 'silent'});

      $assert.isTrue(document.documentElement.classes.contains('app-layout-silent-scroll'));
    });

    testAsync('behavior: smooth', (done) async {
      sinon.DartSpyEventHandler scrollSpy = new sinon.DartSpyEventHandler.on(window,'scroll');
      AppLayout.scroll({"top": 0});
      AppLayout.scroll({"top": 500, behavior: 'smooth'});

      await wait(300);
      $assert.isAbove(scrollSpy.callCount, 1, 'scroll top should be fired multiple times');
      done();
    });

    testAsync('smooth scrolling to the top', (done) {
      AppLayout.scroll({"top": 1000});
      AppLayout.scroll({"top": 0, behavior: 'smooth'});

      window.onScroll.listen((_) async {
        await wait(200);
        $assert.equal(window.pageYOffset, 0, 'document scrollTop');
        done();
      });
    });
  },skip:"not working in test runnner, need investigation");
}
