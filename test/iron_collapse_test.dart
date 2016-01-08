// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_collapse_test;

import 'dart:async';
import 'package:polymer_elements/iron_collapse.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    IronCollapse collapse;
    var collapseHeight;

    setUp(() {
      collapse = fixture('basic');
      collapseHeight = collapse.getComputedStyle().height;
    });

    test('opened attribute', () {
      expect(collapse.opened, true);
    });

    test('animated by default', () {
      expect(!collapse.noAnimation,isTrue,reason: '`noAnimation` is falsy');
    });

    test('horizontal attribute', () {
      expect(collapse.horizontal, false);
    });

    test('default opened height', () {
      expect(collapse.style.height, 'auto');
    });

    test('set opened to false triggers animation', () async {
      collapse.opened = false;
      // Animation got enabled.
      expect(collapse.style.transitionDuration, isNot('0s'));
      await collapse.on['transitionend'].first;
      expect(collapse.style.transitionDuration, '0s');
    });

    test('enableTransition(false) disables animations', () {
      collapse.enableTransition(false);
      expect(collapse.noAnimation, isTrue,reason:'`noAnimation` is true');
      // trying to animate the size update
      collapse.updateSize('0px', true);
      // Animation immediately disabled.
      expect(collapse.style.height, '0px');
    });

    test('set opened to false, then to true', () async {
      // this listener will be triggered twice (every time `opened` changes)

      // Trigger 1st toggle.
      collapse.opened = false;
      // Size should be immediately set.
      expect(collapse.style.height, '0px');

      await for (var _ in collapse.on['transitionend']) {

        if (collapse.opened) {
          // Check finalSize after animation is done.
          expect(collapse.style.height, 'auto');
          break;
        } else {
          // Check if size is still 0px.
          expect(collapse.style.height, '0px');
          // Trigger 2nd toggle.
          collapse.opened = true;
          // Size should be immediately set.
          expect(collapse.style.height, collapseHeight);
        }
      }
    });

  });

  group('horizontal', ()
  {
    IronCollapse collapse;
    var collapseWidth;

    setUp(() {
      collapse = fixture('horizontal');
      collapseWidth = collapse.getComputedStyle().width;

    });

    test('opened attribute', () {
      expect(collapse.opened, true);
    });

    test('horizontal attribute', () {
      expect(collapse.horizontal, true);
    });

    test('default opened width', () {
      expect(collapse.style.width, 'auto');
    });

    test('set opened to false, then to true', () async {
      // this listener will be triggered twice (every time `opened` changes)

      // Trigger 1st toggle.
      collapse.opened = false;
      // Size should be immediately set.
      expect(collapse.style.width, '0px');

      await for (var _ in collapse.on['transitionend']) {

        if (collapse.opened) {
          // Check finalSize after animation is done.
          expect(collapse.style.width, 'auto');
          break;
        } else {
          // Check if size is still 0px.
          expect(collapse.style.width, '0px');
          // Trigger 2nd toggle.
          collapse.opened = true;
          // Size should be immediately set.
          expect(collapse.style.width, collapseWidth);
        }
      }

    });
  });
}
