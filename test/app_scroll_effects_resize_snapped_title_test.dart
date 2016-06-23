// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file

// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.app_scroll_effects_fade_background_test;

import 'package:polymer/polymer.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'fixtures/x_container.dart';

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

        $assert.isTrue(sameCSS(container.titleH, 'transition-property: opacity; transition-duration: 0.2s; opacity: 1;'), 'title when progress = 0');

        $assert.isTrue(sameCSS(container.condensedTitle, 'transition-property: opacity; transition-duration: 0.2s;'), 'condensed-title when progress = 0');

        container.titleH.style.transition = 'none';
        container.condensedTitle.style.transition = 'none';

        $assert.isTrue(sameCSS(container.condensedTitle, 'opacity: 0'), 'condensed-title when progress = 0');

        container.updateScrollState(container.offsetHeight);

        $assert.isTrue(sameCSS(container.titleH, 'opacity: 0;'), 'title when progress = 1');

        $assert.isTrue(sameCSS(container.condensedTitle, 'opacity: 1;'), 'condensed-title when progress = 1');

        done();
      });
    },skip:'fails in test runner, need investigation');
  });
}
