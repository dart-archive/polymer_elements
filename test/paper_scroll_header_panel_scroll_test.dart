// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_scroll_header_panel_scroll_test;

import 'dart:async';
import 'package:polymer_elements/paper_scroll_header_panel.dart';
import 'package:polymer_elements/paper_toolbar.dart';
import 'package:smoke/mirrors.dart' as smoke;
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'fixtures/sample_content.dart';

/// Used imports: [PaperToolbar], [SampleContent]
main() async {
  smoke.useMirrors();
  await initWebComponents();

  group('scroll', () {
    PaperScrollHeaderPanel scrollHeaderPanel;

    setUp(() {
      scrollHeaderPanel = fixture('trivialProgress');
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
      scrollHeaderPanel.scroll(destination, true);
      check();
      return done.future;
    });

    test('condense smoothly', () {
      var done = new Completer();
      scrollHeaderPanel.condenses = true;

      wait(1).then((_) {
        var destination = 100;
        var adjustments = 0;
        check([_]) {
          if (scrollHeaderPanel.headerState ==
              scrollHeaderPanel.HEADER_STATE_CONDENSED) {
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

    test('condense immediately', () {
      var done = new Completer();
      scrollHeaderPanel.condenses = true;

      wait(1).then((_) {
        scrollHeaderPanel.condense(false);

        wait(100).then((_) {
          expect(scrollHeaderPanel.headerState,
              scrollHeaderPanel.HEADER_STATE_CONDENSED);
          done.complete();
        });
      });
      return done.future;
    });

    test('scroll to top smoothly', () {
      var done = new Completer();
      scrollHeaderPanel.scroll(100, false);

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
      scrollHeaderPanel.scroll(100, false);

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
