// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_label_basic_test;

import 'dart:async';
import 'dart:html';

import 'package:polymer_elements/iron_label.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';

import 'common.dart';

main() async {
  await initWebComponents();

  group('event handling', () {

    group('target inside', () {
      IronLabel inside;
      CheckboxInputElement target;
      setUp(() {
        inside = fixture('Inside');
        target = inside.children.first;
      });

      test('target has aria-labelledby', () {
        var label = target.getAttribute('aria-labelledby');
        expect(label, 'inside');
      });

      test('tap on label goes to the target', () {
        var count = 0;
        var sub = target.on['tap'].listen((_) {
          count++;
        });
        tap(inside);
        expect(count, 1);
        sub.cancel();
      });

      test('tap on target does not recurse', () {
        var count = 0;
        var sub = target.on['tap'].listen((_) {
          count++;
        });
        tap(target);
        expect(count, 1);
        sub.cancel();
      });

      test('tap on label will "activate" target', () {
        target.checked = false;
        tap(inside);
        expect(target.checked, true);
      });
    });

    group('target outside', () {
      IronLabel outside;
      CheckboxInputElement target;
      setUp(() {
        var temp = fixture('Outside');
        outside = temp[0];
        target = temp[1];
      });

      test('target has aria-labelledby', () {
        var label = target.getAttribute('aria-labelledby');
        expect(label, 'outside');
      });

      test('tap on label goes to the target', () {
        var count = 0;
        // TODO(jakemac): Only `click` gets fired?
        var sub = target.on['click'].listen((_) {
          count++;
        });
        tap(outside);
        expect(count, 1);
        sub.cancel();
      });

      test('tap on label will "activate" target', () {
        target.checked = false;
        tap(outside);
        expect(target.checked, true);
      });
    });

    group('target by reordered', () {
      IronLabel reordered;
      CheckboxInputElement target;

      setUp(() {
        reordered = fixture('Reordered');
        target =
          Polymer.dom(reordered).querySelector('[iron-label-target]');
      });

      test('target has aria-labelledby', () {
        var label = target.getAttribute('aria-labelledby');
        expect(label, 'reordered');
      });

      test('tap on label goes to the target', () {
        var count = 0;
        var sub = target.on['tap'].listen((_) {
          count++;
        });
        tap(reordered);
        expect(count, 1);
        sub.cancel();
      });

      test('tap on label will "activate" target', () {
        target.checked = false;
        tap(reordered);
        expect(target.checked, true);
      });
    });

  });
}
