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
import 'package:polymer/polymer.dart';

main() async {
  await initPolymer();

  ensureDocumentHasFocus() {
   /* if (window.top!=null)
      focus(window.top);*/
  }

  suite('focus', () {
    var drawer, innerLink, outerLink;

    setup(() {
      drawer = fixture('drawer');
      innerLink = drawer.querySelector('#innerLink1');
      outerLink = drawer.querySelector('#outerLink');
      ensureDocumentHasFocus();
    });

    test('should not focus content in drawer if the drawer is closed', when((done) async {
      await wait(1);
      $expect(new PolymerDom(document).activeElement).to.not.be.equal(innerLink);
      done();

      focus(innerLink);
    }));
  });

  suite('nested drawers', () {
    var drawer1, drawer2, innerLink1, innerLink2;

    setup(() {
      drawer1 = fixture('nestedDrawer');
      drawer2 = drawer1.querySelector('#drawer2');
      innerLink1 = drawer1.querySelector('#innerLink1');
      innerLink2 = drawer1.querySelector('#innerLink2');
      ensureDocumentHasFocus();
    });

    test('should not cause stack overflow', when((done) async {
      var count = 0;
      drawer1.openDrawer();
      drawer2.openDrawer();

      document.addEventListener('focus', (_) {
        count++;
      }, true);

      focus(innerLink1);
      focus(innerLink2);

      await wait(100);
      if (count > 10) {
        throw 'stack overflow';
      }
      done();
    }));
  });
}
