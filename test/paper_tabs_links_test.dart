// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_tabs_links_test;

import 'dart:async';
import 'dart:html';
import 'package:polymer_elements/paper_tabs.dart';
import 'package:polymer_elements/paper_tab.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';
import 'package:polymer/polymer.dart';

/**
 * Original tests:
 * https://github.com/PolymerElements/paper-tabs/tree/master/test
 */

main() async {
  await initPolymer();


  suite('links', () {
    suite('has link attribute', () {
      PaperTabs tabs;
      PaperTab tab;
      AnchorElement anchor;

      setup(()  {
        tabs = fixture('links');
        tab = tabs.querySelectorAll('paper-tab')[1];
        anchor = tab.querySelector('a');
      });


      test('pressing space on tab causes anchor click', when((done) {
        tab.onClick.take(1).listen((event) {
          $expect(event.target).to.be.equal(anchor);
          done();
        });

        pressSpace(tab);
      }),skip:"works but hangs test runner ????????");

      test('pressing enter on tab causes anchor click', when((done) {
        tab.onClick.take(1).listen((event) {
          $expect(event.target).to.be.equal(anchor);
          done();
        });

        pressEnter(tab);
      }),skip:"works but hangs test runner ????????");


    });

    suite('does not have link attribute', () {
      PaperTabs tabs;
      PaperTab tab;
      AnchorElement anchor;

      setup(() {
        tabs = fixture('not-links');
        tab = tabs.querySelectorAll('paper-tab')[1];
        anchor = tab.querySelector('a');
      });

      test('pressing enter on tab does not cause anchor click', when((done) {
        tab.onClick.take(1).listen((event) {
          $expect(event.target).to.not.equal(anchor);
          $expect(event.target).to.be.equal(tab);
          done();
        });

        pressEnter(tab);
      }));
    },skip:"works but hangs test runner ????????");

    suite('not first child', () {
      PaperTabs tabs;
      PaperTab tab;
      AnchorElement anchor;

      setup(() {
        tabs = fixture('links');
        tab = tabs.querySelectorAll('paper-tab')[1];
        anchor = tab.querySelector('a');
      });

      test('pressing enter on tab causes anchor click', when((done) {
        tab.onClick.take(1).listen((event) {
          $expect(event.target).to.be.equal(anchor);
          done();
        });

        pressEnter(tab);
      }));
    },skip:"works but hangs test runner ????????");
  });
  
}
