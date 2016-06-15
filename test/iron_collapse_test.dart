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
import 'sinon/sinon.dart';

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
      expect(collapse.noAnimation, isNot(true), reason: '`noAnimation` is falsy');
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
    }, skip: 'https://github.com/dart-lang/polymer_elements/issues/116');

    test('enableTransition(false) disables animations', () {
      collapse.enableTransition(false);
      expect(collapse.noAnimation, isTrue, reason: '`noAnimation` is true');
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
    }, skip: 'https://github.com/dart-lang/polymer_elements/issues/116');

    test('opened changes trigger iron-resize', () {
      Stub spy = new Stub();
      collapse.addEventListener('iron-resize', spy);
      // No animations for faster test.
      collapse.noAnimation = true;
      collapse.opened = false;
      expect(spy.calledOnce, isTrue, reason: 'iron-resize was fired');
    });

    test('overflow is hidden while animating', () async {
      expect(collapse.getComputedStyle().overflow, 'visible');
      collapse.opened = false;
      // Immediately updated style.
      expect(collapse.getComputedStyle().overflow, 'hidden');

      await collapse.on['transitionend'].first;
      // Should still be hidden.
      expect(collapse.getComputedStyle().overflow, 'hidden');
    }, skip: 'https://github.com/dart-lang/polymer_elements/issues/116');

    test('toggle horizontal updates size', () {
      collapse.horizontal = false;
      expect(collapse.style.width, '');
      expect(collapse.style.height, 'auto');
      expect(collapse.style.transitionProperty, 'height');

      collapse.horizontal = true;
      expect(collapse.style.width, 'auto');
      expect(collapse.style.height, '');
      expect(collapse.style.transitionProperty, 'width');
    });
  });

  group('horizontal', () {
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
    }, skip: 'https://github.com/dart-lang/polymer_elements/issues/116');
  });

  group('nested', () {
    var outerCollapse;
    var innerCollapse;

    setUp(() {
      outerCollapse = fixture('nested');
    });

    group('vertical', () {
      setUp(() {
        innerCollapse = outerCollapse.querySelector('#inner-collapse-vertical');
      });

      test('inner collapse default opened attribute', () {
        expect(innerCollapse.opened, false);
      });

      test('inner collapse default style height', () {
        expect(innerCollapse.style.height, '0px');
      });

      test('open inner collapse updates size without animation', () {
        innerCollapse.opened = true;

        // Animation disabled
        expect(innerCollapse.style.transitionDuration, '0s');
      });

      test('open inner collapse then open outer collapse reveals inner collapse with expanded height', () {
        innerCollapse.opened = true;
        outerCollapse.opened = true;

        expect(innerCollapse.getBoundingClientRect().height, 100);
      });
    });

    group('horizontal', () {
      setUp(() {
        innerCollapse = outerCollapse.querySelector('#inner-collapse-horizontal');
      });

      test('inner collapse default style width', () {
        expect(innerCollapse.style.width, '0px');
      });

      test('open inner collapse updates size without animation', () {
        innerCollapse.opened = true;

        // Animation disabled
        expect(innerCollapse.style.transitionDuration, '0s');
      });

      test('open inner collapse then open outer collapse reveals inner collapse with expanded width', () {
        innerCollapse.opened = true;
        outerCollapse.opened = true;

        expect(innerCollapse.getBoundingClientRect().width, 100);
      });
    });
  });
}
