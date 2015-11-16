// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_drawer_panel_small_devices_test;

import 'package:polymer_elements/paper_drawer_panel.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';
import 'dart:async';
import 'dart:html';

main() async {
  await initWebComponents();

  group('on small devices', () {

    test('drawer is hidden by default', () async {
      PaperDrawerPanel f;
      Element panel, drawer, main;
      f = fixture('left-drawer');
      drawer = f.querySelector('#drawer');
      main = f.querySelector('#main');

      f.set('forceNarrow', true);
      f.jsElement.callMethod('_forceNarrowChanged');

      await wait(1);
      var drawerBoundingRect = drawer.getBoundingClientRect();
      CssStyleDeclaration mainStyle = main.getComputedStyle();
      expect(f.jsElement.callMethod('_isMainSelected'), isTrue);
      expect(drawerBoundingRect.left, -256);
      expect(drawerBoundingRect.width, 256);
    });

    test('right-drawer is hidden by default', () async {
      PaperDrawerPanel f;
      Element panel, drawer, main;
      f = fixture('right-drawer');
      drawer = f.querySelector('#drawer');
      main = f.querySelector('#main');

      f.set('forceNarrow', true);
      f.jsElement.callMethod('_forceNarrowChanged');

      await wait(1);
      var drawerBoundingRect = drawer.getBoundingClientRect();
      CssStyleDeclaration mainStyle = main.getComputedStyle();
      expect(drawerBoundingRect.right, f.offsetWidth + 256);
      expect(drawerBoundingRect.width, 256);
    });

    test('drawer is can be opened', () async {
      PaperDrawerPanel f;
      Element panel, drawer, main;
      f = fixture('left-drawer');
      drawer = f.querySelector('#drawer');
      main = f.querySelector('#main');

      f.set('forceNarrow', true);
      f.jsElement.callMethod('_forceNarrowChanged');
      f.openDrawer();

      await wait(1);
      var drawerBoundingRect = drawer.getBoundingClientRect();
      CssStyleDeclaration mainStyle = main.getComputedStyle();
      expect(f.selected, 'drawer');
      expect(f.jsElement.callMethod('_isMainSelected'), isFalse);
      expect(drawerBoundingRect.left, 0);
      expect(drawerBoundingRect.width, 256);

    });

    test('right-drawer can be closed', () async {
      PaperDrawerPanel f;
      Element panel, drawer, main;
      f = fixture('right-drawer');
      drawer = f.querySelector('#drawer');
      main = f.querySelector('#main');

      f.set('forceNarrow', true);
      f.jsElement.callMethod('_forceNarrowChanged');
      f.openDrawer();

      await wait(1);
      var drawerBoundingRect = drawer.getBoundingClientRect();
      CssStyleDeclaration mainStyle = main.getComputedStyle();
      expect(drawerBoundingRect.right, f.offsetWidth);
      expect(drawerBoundingRect.width, 256);

    });

  });

}
