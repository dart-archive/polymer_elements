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

        $assert.isTrue(sameCSS(container..titleH, 'will-change: opacity; transform: translate(0px, 0px) scale3d(1, 1, 1); opacity: 1;'), 'title when progress = 0');

        $assert.isTrue(sameCSS(container..condensedTitle, 'will-change: opacity; transform: translateZ(0px); opacity: 0;'), 'condensed-title when progress = 0');

        container.updateScrollState(container.offsetHeight * 0.5);

        $assert.isTrue(sameCSS(container..titleH, 'will-change: opacity; transform: translate(50px, 50px) scale3d(1.5, 1.5, 1); opacity: 1;'), 'title when progress = 0.5');

        $assert.isTrue(sameCSS(container..condensedTitle, 'will-change: opacity; transform: translateZ(0px); opacity: 0;'), 'condensed-title when progress = 0.5');

        container.updateScrollState(container.offsetHeight);

        $assert.isTrue(sameCSS(container..titleH, 'will-change: opacity; transform: translate(100px, 100px) scale3d(2, 2, 1); opacity: 0;'), 'title when progress = 1');

        $assert.isTrue(sameCSS(container..condensedTitle, 'will-change: opacity; transform: translateZ(0px); opacity: 1;'), 'condensed-title when progress = 1');

        done();
      });
    },skip:'fails in test runner, need investigation');
  });
}
