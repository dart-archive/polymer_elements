// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_scroll_header_panel_scroll_test;

import 'dart:async';
import 'package:polymer_elements/paper_scroll_header_panel.dart';
import 'package:polymer_elements/paper_toolbar.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'fixtures/sample_content.dart';
import 'dart:js';

/// Used imports: [PaperToolbar], [SampleContent]
main() async {
  await initPolymer();
  final int Polymer_PaperScrollHeaderPanel_HEADER_STATE_EXPANDED =
      context['Polymer']['PaperScrollHeaderPanel']['HEADER_STATE_EXPANDED'];
  final int Polymer_PaperScrollHeaderPanel_HEADER_STATE_HIDDEN =
      context['Polymer']['PaperScrollHeaderPanel']['HEADER_STATE_HIDDEN'];
  final int Polymer_PaperScrollHeaderPanel_HEADER_STATE_CONDENSED =
      context['Polymer']['PaperScrollHeaderPanel']['HEADER_STATE_CONDENSED'];
  final int Polymer_PaperScrollHeaderPanel_HEADER_STATE_INTERPOLATED =
      context['Polymer']['PaperScrollHeaderPanel']['HEADER_STATE_INTERPOLATED'];

  group('scroll', () {
    PaperScrollHeaderPanel scrollHeaderPanel;

    setUp(() async {
      scrollHeaderPanel = fixture('trivialProgress');
      scrollHeaderPanel.measureHeaderHeight();
      await new Future(() {});
    });

    tearDown(() {
      scrollHeaderPanel.scrollAt(0,null);
    });

    test('scroll smoothly', () {
      var done = new Completer();
      var destination = 100;
      var adjustments = 0;

      check([_]) {
        if (scrollHeaderPanel.scroller.scrollTop == destination) {
          expect(adjustments, isNot(0));
          done.complete();
          return;
        }
        adjustments++;
        wait(0).then(check);
      }
      scrollHeaderPanel.scrollAt(destination, true);
      check();
      return done.future;
    });

    test('condense smoothly', () {
      var done = new Completer();

      wait(1).then((_) {
        var destination = 100;
        var adjustments = 0;
        check([_]) {
          if (scrollHeaderPanel.headerState ==
              Polymer_PaperScrollHeaderPanel_HEADER_STATE_CONDENSED) {
            expect(adjustments, isNot(0));
            done.complete();
            return;
          }
          adjustments++;
          wait(1).then(check);
        }
        scrollHeaderPanel.condense(true);
        check();
      });
      return done.future;
    });

    test('condense immediately', () async {
      await wait(1);
      scrollHeaderPanel.condense(false);
      await wait(100);

      expect(scrollHeaderPanel.headerState,
          Polymer_PaperScrollHeaderPanel_HEADER_STATE_CONDENSED);
    });

    test('scroll to top smoothly', () {
      var done = new Completer();
      scrollHeaderPanel.scrollAt(100, false);

      wait(1).then((_) {
        var adjustments = 0;
        check([_]) {
          if (scrollHeaderPanel.scroller.scrollTop == 0) {
            expect(adjustments, isNot(0));
            done.complete();
            return;
          }
          adjustments++;
          wait(0).then(check);
        }
        scrollHeaderPanel.scrollToTop(true);
        check();
      });
      return done.future;
    });

    test('scroll to top immediately', () {
      var done = new Completer();
      scrollHeaderPanel.scrollAt(100, false);

      wait(1).then((_) {
        expect(scrollHeaderPanel.scroller.scrollTop, 100);

        scrollHeaderPanel.scrollToTop(false);

        wait(100).then((_) {
          expect(scrollHeaderPanel.scroller.scrollTop, 0);
          done.complete();
        });
      });
      return done.future;
    });
  });
}
