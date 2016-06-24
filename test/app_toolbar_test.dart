// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.app_toolbar_test;

import 'package:polymer_interop/polymer_interop.dart';

import 'sinon/sinon.dart' as sinon;
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'dart:js';
import 'fixtures/x_container.dart';
import 'package:polymer_elements/app_layout/app_scrollpos_control/app_scrollpos_control.dart';
import 'package:polymer_elements/app_layout/app_toolbar/app_toolbar.dart';

/// Used tests: [IronIcon], [iron_icons]
main() async {
  await initPolymer();

  suite('basic features', () {
    AppToolbar toolbar;

    setup(() {
      toolbar = fixture('trivialToolbar');
    });

    test('Items', () {
      var barHeight = toolbar.offsetHeight;
      var topItem = document.elementFromPoint(0, 0);
      var title = new PolymerDom(toolbar).querySelector('[title]');
      var titleRect = title.getBoundingClientRect();
      var barRect = toolbar.getBoundingClientRect();
      var bottomItem = document.elementFromPoint(0, barHeight - 1);

      $assert.isTrue(topItem.attributes.containsKey('top-item'));
      $assert.isTrue(bottomItem.attributes.containsKey('bottom-item'));
      $assert.isTrue(titleRect.top > 0 && barRect.bottom - titleRect.bottom > 0);
    });
  });
}
