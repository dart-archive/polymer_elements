// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.app_header_layout_test;

import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer_elements/app_layout/app_header_layout/app_header_layout.dart';

import 'package:polymer_elements/iron_resizable_behavior.dart';
import 'sinon/sinon.dart' as sinon;
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'dart:js';
import 'package:polymer_elements/app_layout/app_toolbar/app_toolbar.dart';
import 'package:polymer_elements/app_layout/app_header/app_header.dart';

/// Used tests: [IronIcon], [iron_icons]
main() async {
  await initPolymer();

  suite('basic features', () {
    AppHeaderLayout headerLayout;
    AppHeader header;
    AppToolbar toolbar;

    setup(() {
      headerLayout = fixture('trivialHeader');
      header = headerLayout.querySelector('app-header');
      toolbar = headerLayout.querySelector('app-toolbar');
    });

    test('default values', () {
      $assert.isFalse(headerLayout.hasScrollingRegion);
      $assert.equal(header.scrollTarget, document.documentElement);
    });

    test('scrolling region', () {
      headerLayout.hasScrollingRegion = true;
      $assert.isTrue(header.scrollTarget != document.documentElement, 'scroller should not point to the document element');
    });

    testAsync('header box size', (done) {
      headerLayout.hasScrollingRegion = false;

      flush(() {
        $assert.equal(headerLayout.offsetWidth, header.offsetWidth, 'should have the same width of app-header-layout');

        headerLayout.style.width = '200px';

        headerLayout.resetLayout();

        flush(() {
          $assert.equal(headerLayout.offsetWidth, header.offsetWidth, 'should have the same width of app-header-layout even after setting a width');
          done();
        });
      });
    });
  });
}
