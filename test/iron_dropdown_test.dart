// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_dropdown_test;

import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_dropdown.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

bool elementIsVisible(element) {
  var contentRect = element.getBoundingClientRect();
  var computedStyle = element.getComputedStyle();
  return computedStyle.display != 'none' &&
      contentRect.width > 0 &&
      contentRect.height > 0;
}

main() async {
  await initWebComponents();
  group('<iron-dropdown>', () {
    IronDropdown dropdown;
    DivElement content;

    group('basic', () {
      setUp(() {
        dropdown = fixture('TrivialDropdown');
        content = Polymer.dom(dropdown).querySelector('.dropdown-content');
      });

      test('effectively hides the dropdown content', () {
        expect(elementIsVisible(content), isFalse);
      });

      test('shows dropdown content when opened', () {
        dropdown.open();
        return new Future(() {
          expect(elementIsVisible(content), isTrue);
        });
      });

      test('hides dropdown content when outside is clicked', () {
        var done = new Completer();
        dropdown.open();
        new Future(() {
          expect(elementIsVisible(content), isTrue);
          downAndUp(document.body, () {
            new Future.delayed(new Duration(milliseconds: 100), () {
              expect(elementIsVisible(content), isFalse);
              done.complete();
            });
          });
        });
        return done.future;
      });

      group('when content is focusable', () {
        setUp(() {
          dropdown = fixture('FocusableContentDropdown');
          content = Polymer.dom(dropdown).querySelector('.dropdown-content');
        });
        test('focuses the content when opened', () {
          var done = new Completer();
          dropdown.open();

          dropdown.async(() {
            expect(document.activeElement, content);
            done.complete();
          });
          return done.future;
        });

        test('focuses a configured focus target', () {
          var done = new Completer();
          var focusableChild =
              Polymer.dom(content).querySelector('div[tabindex]');
          dropdown.focusTarget = focusableChild;

          dropdown.open();

          dropdown.async(() {
            expect(document.activeElement, isNot(content));
            expect(document.activeElement, focusableChild);
            done.complete();
          });

          return done.future;
        });
      });
    });

    group('locking scroll', () {
      IronDropdown dropdown;

      setUp(() {
        dropdown = fixture('NonLockingDropdown');
      });

      test('can be disabled with `allowOutsideScroll`', () {
        dropdown.open();

        expect(
            context['Polymer']['IronDropdownScrollManager']
                .callMethod('elementIsScrollLocked', [document.body]),
            false);
      }, skip: 'https://github.com/dart-lang/polymer_elements/issues/83');
    });

    group('aligned dropdown', () {
      var parent;
      setUp(() {
        parent = fixture('AlignedDropdown');
        dropdown = parent.querySelector('iron-dropdown');
      });

      test('can be re-aligned to the right and the top', () {
        var parentRect;
        var dropdownRect;
        dropdown.opened = true;
        return wait(1).then((_) {
          dropdownRect = dropdown.getBoundingClientRect();
          parentRect = parent.getBoundingClientRect();
          // NOTE(cdata): IE10 / 11 have minor rounding errors in this case,
          // so we assert with `closeTo` and a tight threshold:
          expect(dropdownRect.top, closeTo(parentRect.top, 0.1));
          expect(dropdownRect.right, closeTo(parentRect.right, 0.1));
        });
      });

      test('can be re-aligned to the bottom', () {
        var parentRect;
        var dropdownRect;
        dropdown.verticalAlign = 'bottom';
        dropdown.opened = true;
        return wait(1).then((_) {
          parentRect = parent.getBoundingClientRect();
          dropdownRect = dropdown.getBoundingClientRect();
          // NOTE(cdata): IE10 / 11 have minor rounding errors in this case,
          // so we assert with `closeTo` and a tight threshold:
          expect(dropdownRect.bottom, closeTo(parentRect.bottom, 0.1));
          expect(dropdownRect.right, closeTo(parentRect.right, 0.1));
        });
      });

      group('with an offset', () {
        test('is offset by the offset value when open', () {
          var dropdownRect;
          var offsetDropdownRect;
          dropdown.opened = true;
          return wait(1).then((_) {
            dropdownRect = dropdown.getBoundingClientRect();
            dropdown.verticalOffset = 10;
            dropdown.horizontalOffset = -10;

            offsetDropdownRect = dropdown.getBoundingClientRect();

            expect(dropdownRect.top, offsetDropdownRect.top - 10,
                reason: 'vertical offset should adjust');
            expect(dropdownRect.left, offsetDropdownRect.left - 10,
                reason: 'horizontal offset should adjust');
          });
        });
      });
    });
  });
}
