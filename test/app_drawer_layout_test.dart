// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.app_drawer_layout_test;

import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer_elements/app_layout/app_drawer_layout/app_drawer_layout.dart';
import 'package:polymer_elements/app_layout/app_drawer/app_drawer.dart';
import 'package:polymer_elements/iron_resizable_behavior.dart';
import 'sinon/sinon.dart' as sinon;
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'dart:js';

/// Used tests: [IronIcon], [iron_icons]
main() async {
  await initPolymer();
  suite('basic features', () {
    AppDrawerLayout drawerLayout;
    AppDrawer drawer;

    setup(() {
      drawerLayout = fixture('testDrawerLayout');
      drawer = drawerLayout.querySelector('app-drawer');
    });

    test('default values', () {
      $assert.isFalse(drawerLayout.forceNarrow);
      $assert.equal(drawerLayout.responsiveWidth, '640px');
    });

    test('get drawer', () {
      $assert.equal(drawerLayout.drawer, drawer);
    });

    test('forceNarrow', () {
      drawerLayout.responsiveWidth = '0px';
      drawerLayout.forceNarrow = true;

      $assert.isTrue(drawerLayout.narrow);
    });

    testAsync('responsiveWidth', (done) async {
      var drawerToggle = drawerLayout.querySelector('[drawer-toggle]');
      drawerLayout.responsiveWidth = '0px';

      await wait(50);
      $assert.isFalse(drawerLayout.narrow);
      $assert.equal(drawerToggle.getComputedStyle().display, 'none');

      drawerLayout.responsiveWidth = '10000px';

      await wait(50);
      $assert.isTrue(drawerLayout.narrow);
      $assert.notEqual(drawerToggle.getComputedStyle().display, 'none');

      done();
    });

    test('drawer-toggle', () {
      drawerLayout.responsiveWidth = '10000px';

      $assert.isFalse(drawer.opened);

      drawerLayout.fire('tap', node: drawerLayout.querySelector('p'));

      $assert.isFalse(drawer.opened);

      drawerLayout.fire('tap', node: drawerLayout.querySelector('[drawer-toggle]'));

      $assert.isTrue(drawer.opened);
    });

    testAsync('content layout', (done) async {
      var xResizeable = drawerLayout.querySelector('x-resizeable');
      sinon.DartSpyEventHandler listenerSpy = new sinon.DartSpyEventHandler.on(xResizeable, 'iron-resize');
      xResizeable.addEventListener('iron-resize', listenerSpy);
      drawerLayout.responsiveWidth = '10000px';

      await wait(50);
      $assert.equal(drawerLayout.$['contentContainer'].style.marginLeft, '');
      $assert.equal(drawerLayout.$['contentContainer'].style.marginRight, '');
      $assert.isTrue(listenerSpy.called);
      listenerSpy.reset();

      drawerLayout.responsiveWidth = '0px';

      await wait(50);
      $assert.equal(drawerLayout.$['contentContainer'].style.marginLeft, '256px');
      $assert.equal(drawerLayout.$['contentContainer'].style.marginRight, '');
      $assert.isTrue(listenerSpy.called);
      listenerSpy.reset();

      drawer.align = 'end';

      await wait(50);
      $assert.equal(drawerLayout.$['contentContainer'].style.marginLeft, '');
      $assert.equal(drawerLayout.$['contentContainer'].style.marginRight, '256px');
      $assert.isTrue(listenerSpy.called);

      done();
    });
  });
}

@PolymerRegister('x-resizeable')
class FocusDrawer extends PolymerElement with IronResizableBehavior {
  FocusDrawer.created() : super.created();
}
