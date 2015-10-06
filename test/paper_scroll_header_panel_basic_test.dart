// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_scroll_header_panel_basic_test;

import 'dart:async';
import 'package:polymer_elements/paper_scroll_header_panel.dart';
import 'package:polymer_elements/paper_toolbar.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'fixtures/sample_content.dart';

/// Used imports: [SampleContent]
main() async {
  await initPolymer();

  group('basic features', () {
    PaperScrollHeaderPanel scrollHeaderPanel;
    PaperToolbar toolbar;
    var content;

    setUp(() {
      scrollHeaderPanel = fixture('trivialProgress');

      toolbar = Polymer.dom(scrollHeaderPanel).querySelector('paper-toolbar');
      content = Polymer.dom(scrollHeaderPanel).querySelector('.content');
    });

    test('check default', () {
      expect(scrollHeaderPanel.header, toolbar);
      expect(scrollHeaderPanel.content, content);
      expect(scrollHeaderPanel.condenses, false);
      expect(scrollHeaderPanel.noReveal, false);
      expect(scrollHeaderPanel.fixed, false);
      expect(scrollHeaderPanel.scroller, isNotNull);
      expect(scrollHeaderPanel.keepCondensedHeader, false);
      expect(scrollHeaderPanel.keepCondensedHeader, false);
      expect(scrollHeaderPanel.headerHeight, toolbar.offsetHeight);
      expect(scrollHeaderPanel.condensedHeaderHeight,
          (toolbar.offsetHeight * 1 / 3).round());
    });

    test('condensation', () {
      var top1 = toolbar.getBoundingClientRect().top;

      scrollHeaderPanel.condenses = true;
      scrollHeaderPanel.headerHeight = 150;
      scrollHeaderPanel.condensedHeaderHeight = 50;
      scrollHeaderPanel.scroller.scrollTop = 300;

      return wait(1).then((_) {
        expect(top1, isNot(toolbar.getBoundingClientRect().top));
      });
    });

    test('paper-header-transform event', () {
      var done = new Completer();
      scrollHeaderPanel.condenses = false;
      if (scrollHeaderPanel.headerHeight == 0) {
        scrollHeaderPanel.headerHeight = 150;
      }

      scrollHeaderPanel.on['paper-header-transform'].take(1).listen((e) {
        e = convertToDart(e);
        expect(e.detail['y'], new isInstanceOf<num>());
        expect(e.detail['height'], scrollHeaderPanel.headerHeight);
        expect(e.detail['condensedHeight'],
            scrollHeaderPanel.condensedHeaderHeight);
        done.complete();
      });

      wait(1).then((_) {
        scrollHeaderPanel.scroller.scrollTop = 300;
      });
      return done.future;
    });

    test('content-scroll event', () {
      var done = new Completer();
      scrollHeaderPanel.condenses = false;

      scrollHeaderPanel.on['content-scroll'].take(1).listen((e) {
        e = convertToDart(e);
        expect(e.detail['target'], scrollHeaderPanel.scroller);
        done.complete();
      });

      wait(1).then((_) {
        scrollHeaderPanel.scroller.scrollTop = 300;
      });
      return done.future;
    });

    test('custom `condensedHeaderHeight`', () {
      var CUSTOM_HEIGHT = 100;
      scrollHeaderPanel.condensedHeaderHeight = CUSTOM_HEIGHT;
      scrollHeaderPanel.headerHeight = CUSTOM_HEIGHT;

      expect(scrollHeaderPanel.condensedHeaderHeight, CUSTOM_HEIGHT);
      expect(scrollHeaderPanel.headerHeight, CUSTOM_HEIGHT);
    });
  });
}
