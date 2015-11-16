// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_drawer_panel_positioning_test;

import 'package:polymer_elements/paper_drawer_panel.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';
import 'dart:async';
import 'dart:html';

main() async {
  await initWebComponents();

  group('positioning', () {

    test('drawer is positioned correctly', () async {
      Element f, drawer, main;
      f = fixture('left-drawer');
      drawer = f.querySelector('#drawer');
      main = f.querySelector('#main');

      await wait(1);
      var drawerStyle = drawer.getComputedStyle();
      expect(drawerStyle.left, '0px');
      try {
        expect(drawerStyle.right, 'auto');
      } catch (e) {
        // Firefox
        expect(drawerStyle.right, '${f.offsetWidth - drawer.offsetWidth}px');
      }
    });

    test('right-drawer is positioned correctly', () async {
      Element f, drawer, main;
      f = fixture('right-drawer');
      drawer = f.querySelector('#drawer');
      main = f.querySelector('#main');

      await wait(1);
      var drawerStyle = drawer.getComputedStyle();
      expect(drawerStyle.right,'0px');

      try {
        expect(drawerStyle.left,'auto');
      } catch (e) {
        // Firefox
        expect(drawerStyle.left,'${f.offsetWidth - drawer.offsetWidth}px');
      }

    });

  });
}
