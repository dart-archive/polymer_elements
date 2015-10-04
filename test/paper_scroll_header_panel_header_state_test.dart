// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_scroll_header_panel_header_state_test;

import 'package:polymer_elements/paper_scroll_header_panel.dart';
import 'package:polymer_elements/paper_toolbar.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'fixtures/sample_content.dart';

/// Used imports: [SampleContent]
main() async {
  await initWebComponents();

  group('`headerState`', () {
    PaperScrollHeaderPanel scrollHeaderPanel;
    PaperToolbar toolbar;

    setUp(() {
      scrollHeaderPanel = fixture('trivialProgress');
      toolbar = Polymer.dom(scrollHeaderPanel).querySelector('paper-toolbar');
    });

    test('HEADER_STATE_EXPANDED', () {
      expect(scrollHeaderPanel.headerState,
          scrollHeaderPanel.HEADER_STATE_EXPANDED);

      scrollHeaderPanel.scroller.scrollTop = 1;

      return wait(1).then((_) {
        expect(scrollHeaderPanel.headerState,
            isNot(scrollHeaderPanel.HEADER_STATE_EXPANDED));
      });
    });

    test('HEADER_STATE_HIDDEN', () {
      scrollHeaderPanel.scroller.scrollTop = toolbar.offsetHeight * 2;

      return wait(1).then((_) {
        expect(scrollHeaderPanel.headerState,
            scrollHeaderPanel.HEADER_STATE_HIDDEN);
      });
    });

    test('HEADER_STATE_CONDENSED', () {
      scrollHeaderPanel.jsElement['_prevScrollTop'] = toolbar.offsetHeight * 10;
      scrollHeaderPanel.scroller.scrollTop = toolbar.offsetHeight * 5;

      return wait(1).then((_) {
        expect(scrollHeaderPanel.headerState,
            scrollHeaderPanel.HEADER_STATE_CONDENSED);
      });
    });

    test('HEADER_STATE_INTERPOLATED', () {
      scrollHeaderPanel.scroller.scrollTop =
          (toolbar.offsetHeight * 0.5).round();

      return wait(1).then((_) {
        expect(scrollHeaderPanel.headerState,
            scrollHeaderPanel.HEADER_STATE_INTERPOLATED);
      });
    });
  });
}
