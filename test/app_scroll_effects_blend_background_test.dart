// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.app_scroll_effects_behavior_test;

import 'package:polymer_interop/polymer_interop.dart';

import 'sinon/sinon.dart' as sinon;
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'dart:js';
import 'fixtures/x_container.dart';
import 'package:polymer_elements/app_layout/app_scroll_effects/effects/blend_background.dart';

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
        container.jsElement.callMethod('_updateScrollState', [0]);

        $assert.isTrue(sameCSS(container.$['backgroundFrontLayer'], 'will-change: opacity; transform: matrix(1, 0, 0, 1, 0, 0); opacity: 1;'), 'backgroundFrontLayer when progress = 0');

        $assert.isTrue(sameCSS(container.$['backgroundRearLayer'], 'will-change: opacity; transform: matrix(1, 0, 0, 1, 0, 0); opacity: 0;'), 'backgroundRearLayer when progress = 0');

        container.jsElement.callMethod('_updateScrollState', [container.offsetHeight]);

        $assert.isTrue(sameCSS(container.$['backgroundFrontLayer'], 'will-change: opacity; transform: matrix(1, 0, 0, 1, 0, 0); opacity: 0;'), 'backgroundFrontLayer when progress = 1');

        $assert.isTrue(sameCSS(container.$['backgroundRearLayer'], 'will-change: opacity; transform: matrix(1, 0, 0, 1, 0, 0); opacity: 1;'), 'backgroundRearLayer when progress = 1');

        done();
      });
    });
  });
}
