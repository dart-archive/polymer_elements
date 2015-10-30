// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_selector_template_repeat_test;

import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_selector.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('dom-repeat', () {
    DomBind scope;
    DomRepeat t;
    IronSelector s;

    setUp(() {
      scope = document.querySelector('template[is="dom-bind"]');
      s = scope.$['selector'];
      t = scope.$['t'];
      t.items = [
        {'name': 'item0'},
        {'name': 'item1'},
        {'name': 'item2'},
        {'name': 'item3'}
      ];
    });

    tearDown(() {
      t.items = [];
    });

    test('supports repeated items', () {
      return wait(1).then((_) {
        // check items
        expect(s.items.length, 4);
        // check selected
        expect(s.selected, '1');
        // check selected item
        var item = s.selectedItem;
        expect(s.items[1], item);
        // check selected class
        expect(item.classes.contains('iron-selected'), isTrue);
      });
    });

    test('update items', () {
      var done = new Completer();
      wait(1).then((_) {
        // check items
        expect(s.items.length, 4);
        // check selected
        expect(s.selected, '1');
        // update items
        t.items = [{'name': 'foo'}, {'name': 'bar'}];
        wait(1).then((_) {
          // check items
          expect(s.items.length, 2);
          // check selected (should still honor the selected)
          expect(s.selected, '1');
          // check selected class
          expect(s.querySelector('#bar').classes.contains('iron-selected'),
              isTrue);
          done.complete();
        });
      });
      return done.future;
    });

    test('set selected to something else', () {
      return wait(1).then((_) {
        // set selected to something else
        s.selected = 3;
        // check selected item
        var item = s.selectedItem;
        expect(s.items[3], item);
        // check selected class
        expect(item.classes.contains('iron-selected'), isTrue);
      });
    });
  });
}
