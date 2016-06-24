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

/// Used tests: [IronIcon], [iron_icons]

main() async {
  await initPolymer();

  suite('basic features', () {
    XContainer container;

    setup(() {
      container = fixture('testHeader');
    //  showTestRunnerFrame();
    //  document.body.style.overflow = 'hidden';
    //  document.body.parent.style.overflow = 'auto';
    });

    testAsync('effect outputs', (done) {
      flush(() async {
        container.updateScrollState(0);

        $assert.isTrue(sameCSS(container.backgroundFrontLayer, 'transform: matrix(1, 0, 0, 1, 0, 0);'), 'backgroundFrontLayer when progress = 0');

        $assert.isTrue(sameCSS(container.backgroundRearLayer, 'transform: matrix(1, 0, 0, 1, 0, 0);'), 'backgroundRearLayer when progress = 0');

        container.updateScrollState(container.offsetHeight);

        $assert.isTrue(sameCSS(container.backgroundFrontLayer, 'transform: translate3d(0px, 200px, 0px);'), 'backgroundFrontLayer when progress = 1');

        $assert.isTrue(sameCSS(container.backgroundRearLayer, 'transform: translate3d(0px, 200px, 0px);'), 'backgroundRearLayer when progress = 1');
        done();
      });
    },skip:'fails in test runner, need investigation');
  });
}
