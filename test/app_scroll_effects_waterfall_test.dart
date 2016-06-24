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

    testAsync('show waterfall when needed', (done) {
      flush(() {
        container.updateScrollState(0);
        $assert.isFalse(container.attributes.containsKey('shadow'));
        container.jsElement['isOnScreen'] = new JsFunction.withThis(() {
          return true;
        });

        container.updateScrollState(0);
        $assert.isFalse(container.attributes.containsKey('shadow'));
        container.jsElement['isContentBelow'] = new JsFunction.withThis(() {
          return true;
        });

        container.updateScrollState(0);
        $assert.isTrue(container.attributes.containsKey('shadow'));
        container.jsElement['isOnScreen'] = new JsFunction.withThis(() {
          return false;
        });

        container.updateScrollState(0);
        $assert.isFalse(container.attributes.containsKey('shadow'));
        container.jsElement['isContentBelow'] = new JsFunction.withThis(() {
          return false;
        });

        container.updateScrollState(0);
        $assert.isFalse(container.attributes.containsKey('shadow'));
        done();
      });
    },skip:'fails in test runner, need investigation');
  });
}
