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
    });

    testAsync('effect outputs', (done) {
      flush(() {
        container.updateScrollState(0);

        $assert.isTrue(sameCSS(container.backgroundFrontLayer, 'will-change: opacity; transition-property: opacity; ' + 'transition-duration: 0.5s;'),
            'backgroundFrontLayer when progress = 0');

        $assert.isTrue(
            sameCSS(container.backgroundRearLayer, 'will-change: opacity; transition-property: opacity;' + 'transition-duration: 0.5s;'), 'backgroundRearLayer when progress = 0');

        container.backgroundFrontLayer.style.transition = 'none';
        container.backgroundRearLayer.style.transition = 'none';

        $assert.isTrue(sameCSS(container.backgroundFrontLayer, 'opacity: 1'), 'backgroundFrontLayer when progress = 0');

        $assert.isTrue(sameCSS(container.backgroundRearLayer, 'opacity: 0'), 'backgroundRearLayer when progress = 0');

        container.updateScrollState(container.offsetHeight);

        $assert.isTrue(sameCSS(container.backgroundFrontLayer, 'opacity: 0'), 'backgroundFrontLayer when progress = 1');

        $assert.isTrue(sameCSS(container.backgroundRearLayer, 'opacity: 1'), 'backgroundRearLayer when progress = 1');

        done();
      });
    });
  });
}
