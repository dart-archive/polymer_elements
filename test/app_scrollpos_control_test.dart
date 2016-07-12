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
import 'package:polymer_elements/app_layout/app_scrollpos_control/app_scrollpos_control.dart';

/// Used tests: [IronIcon], [iron_icons]
main() async {
  await initPolymer();

  suite('basic features', () {
    AppScrollposControl scrollposControl;

    setup(() {
      scrollposControl = fixture('basicScrollposControl')[0];
    });

    test('default settings', () {
      $assert.isFalse(scrollposControl.reset);
    });

    testAsync('store and retrieve', (done) async {
      // page0 selected
      scrollposControl.selected = 'page0';
      $assert.equal(window.pageYOffset, 0);
      // scroll down to 200px on page0
      window.scrollTo(0, 200);
      // change to page1
      scrollposControl.selected = 'page1';
      await wait(10);
      $assert.equal(window.pageYOffset, 0, 'should be reset to 0');
      // change it back to page0
      scrollposControl.selected = 'page0';
      await wait(50);
      $assert.equal(window.pageYOffset, 200, 'should update to previous scrollpos on page0');
      done();
    });
  });
}
