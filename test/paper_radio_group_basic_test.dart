// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_radio_group_basic_test;

import 'dart:async';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_elements/paper_radio_group.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('defaults', () {
    var LEFT_ARROW = 37;
    var RIGHT_ARROW = 39;

    test('group can have no selection', () async {
      PaperRadioGroup g = fixture('NoSelection');
      await new Future(() {});
      expect(g.selected, isNull);
      var items = g.items;
      expect(items.length, equals(3));
      expect(items[0].checked, isFalse);
      expect(items[1].checked, isFalse);
      expect(items[2].checked, isFalse);
    });

    test('group can have a selection', () async {
      PaperRadioGroup g = fixture('WithSelection');
      await new Future(() {});
      expect(g.selected, isNotNull);
      var items = g.items;
      expect(items.length, equals(3));
      expect(items[0].checked, isTrue);
      expect(items[1].checked, isFalse);
      expect(items[2].checked, isFalse);
      expect(items[0].attributes['name'], equals(g.selected));
    });

    test('right arrow advances the selection', () async {
      PaperRadioGroup g = fixture('WithSelection');
      focus(g);
      await new Future(() {});
      var items = g.items;
      expect(items[0].checked, isTrue);
      var completer = new Completer();
      g.on['paper-radio-group-changed'].listen((e) {
        expect(items[0].checked, isFalse);
        expect(items[1].checked, isTrue);
        expect(items[2].checked, isFalse);
        completer.complete();
      });
      keyDownOn(g, RIGHT_ARROW);
      await completer.future;
    });

    test('left arrow reverses the selection', () async {
      PaperRadioGroup g = fixture('WithSelection');
      focus(g);
      await new Future(() {});
      var items = g.items;
      expect(items[0].checked, isTrue);
      var completer = new Completer();

      g.on['paper-radio-group-changed'].listen((e) {
        expect(items[0].checked, isFalse);
        expect(items[1].checked, isFalse);
        expect(items[2].checked, isTrue);
        completer.complete();
      });
      keyDownOn(g, LEFT_ARROW);
      await completer.future;
    });

    test('selection should skip disabled items', () async {
      PaperRadioGroup g = fixture('WithDisabled');
      focus(g);
      await new Future(() {});
      var items = g.items;
      expect(items[0].checked, isTrue);
      var completer = new Completer();
      g.on['paper-radio-group-changed'].listen((e) {
        expect(items[0].checked, isFalse);
        expect(items[1].checked, isFalse);
        expect(items[2].checked, isTrue);
        completer.complete();
      });
      keyDownOn(g, RIGHT_ARROW);
      await completer.future;
    });

    test('clicking should change the selection', () async {
      PaperRadioGroup g = fixture('WithSelection');
      focus(g);
      await new Future(() {});
      var items = g.items;
      expect(items[0].checked, isTrue);
      var completer = new Completer();
      g.on['paper-radio-group-changed'].listen((e) {
        expect(items[0].checked, isFalse);
        expect(items[1].checked, isTrue);
        expect(items[2].checked, isFalse);
        completer.complete();
      });
      tap(items[1]);
      await completer.future;
    });

    test('clicking the selected item should not deselect', () async {
      PaperRadioGroup g = fixture('WithSelection');
      focus(g);
      await new Future(() {});
      var items = g.items;
      expect(items[0].checked, isTrue);
      tap(items[0]);
      // The selection should not change, but wait for a little bit just
      // in case it would and an event would be fired.
      await wait(1);

      expect(items[0].checked, isTrue);
      expect(items[1].checked, isFalse);
      expect(items[2].checked, isFalse);
    });

    test(
        'clicking the selected item should deselect if allow-empty-selection is set',
        () async {
      var g = fixture('WithSelection');
      await new Future(() {});
      g.allowEmptySelection = true;
      var items = g.items;

      expect(items[0].checked, true);
      tap(items[0]);

      // The selection should not change, but wait for a little bit just
      // in case it would and an event would be fired.
      await wait(1);

      expect(items[0].checked, false);
      expect(items[1].checked, false);
      expect(items[2].checked, false);
    });

    test('arrow keys cause iron-activate events', () async {
      var done = new Completer();
      var g = fixture('WithSelection');
      focus(g);

      // Needs to be async since the underlying iron-selector uses observeNodes.
      await wait(1);
      g.items[0].focus();

      var i = 0;
      g.on['iron-activate'].listen((_) {
        switch (i++) {
          case 0:
            pressAndReleaseKeyOn(g, 38);
            break;

          case 1:
            pressAndReleaseKeyOn(g, 39);
            break;

          case 2:
            pressAndReleaseKeyOn(g, 40);
            break;

          default:
            done.complete();
        }
      });

      pressAndReleaseKeyOn(g, 37);
      return done.future;
    });
  });
}
