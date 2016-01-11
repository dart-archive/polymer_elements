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

      test('hides dropdown content when outside is clicked', () async {
        var done = new Completer();
        dropdown.open();
        await wait(1);
        expect(elementIsVisible(content), isTrue);
        await wait(1);
        downAndUp(document.body, () async {
          await wait(100);
          expect(elementIsVisible(content), isFalse);
          done.complete();
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

      test('can be disabled with `allowOutsideScroll`', () async {
        dropdown.open();
        await wait(1);
        expect(
            context['Polymer']['IronDropdownScrollManager']
                .callMethod('elementIsScrollLocked', [document.body]),
            false);
      });
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

      group('when align is left/top, with an offset', () {
        var dropdownRect;
        var offsetDropdownRect;
        var dropdown;

        setUp(() {
          var parent = fixture('OffsetDropdownTopLeft');
          dropdown = parent.querySelector('iron-dropdown');
        });

        test('can be offset towards the bottom right', () async {
          dropdown.opened = true;
          await wait(1);
          dropdownRect = dropdown.getBoundingClientRect();
          dropdown.verticalOffset = 10;
          dropdown.horizontalOffset = 10;
          offsetDropdownRect = dropdown.getBoundingClientRect();
          // verticalAlign is top, so a positive offset moves down.
          expect(dropdownRect.top + 10, closeTo(offsetDropdownRect.top, 0.1));
          // horizontalAlign is left, so a positive offset moves to the right.
          expect(dropdownRect.left + 10, closeTo(offsetDropdownRect.left, 0.1));
        });

        test('can be offset towards the top left', () async {
          dropdown.opened = true;

          await wait(1);
          dropdownRect = dropdown.getBoundingClientRect();

          dropdown.verticalOffset = -10;
          dropdown.horizontalOffset = -10;
          offsetDropdownRect = dropdown.getBoundingClientRect();

          // verticalAlign is top, so a negative offset moves up.
          expect(dropdownRect.top - 10, closeTo(offsetDropdownRect.top, 0.1));
          // horizontalAlign is left, so a negative offset moves to the left.
          expect(dropdownRect.left - 10, closeTo(offsetDropdownRect.left, 0.1));
        });

      });

      group('when align is right/bottom, with an offset', () {
        var dropdownRect;
        var offsetDropdownRect;
        var dropdown;

        setUp(() {
          var parent = fixture('OffsetDropdownBottomRight');
          dropdown = parent.querySelector('iron-dropdown');
        });

        test('can be offset towards the top left', () async {
          dropdown.opened = true;

          await wait(1);
          dropdownRect = dropdown.getBoundingClientRect();

          dropdown.verticalOffset = 10;
          dropdown.horizontalOffset = 10;
          offsetDropdownRect = dropdown.getBoundingClientRect();

          // verticalAlign is bottom, so a positive offset moves up.
          expect(dropdownRect.bottom - 10, closeTo(offsetDropdownRect.bottom, 0.1));
          // horizontalAlign is right, so a positive offset moves to the left.
          expect(dropdownRect.right - 10, closeTo(offsetDropdownRect.right, 0.1));
        });

        test('can be offset towards the bottom right', () async {
          dropdown.opened = true;

          await wait(1);
          dropdownRect = dropdown.getBoundingClientRect();

          dropdown.verticalOffset = -10;
          dropdown.horizontalOffset = -10;
          offsetDropdownRect = dropdown.getBoundingClientRect();

          // verticalAlign is bottom, so a negative offset moves down.
          expect(dropdownRect.bottom + 10, closeTo(offsetDropdownRect.bottom, 0.1));
          // horizontalAlign is right, so a positive offset moves to the right.
          expect(dropdownRect.right + 10, closeTo(offsetDropdownRect.right, 0.1));
        });
      });

      group('RTL', () {
        var dropdown;
        var dropdownRect;

        test('with horizontalAlign=left', () async {
          var parent = fixture('RTLDropdownLeft');
          dropdown = parent.querySelector('iron-dropdown');
          dropdown.open();

          await wait(1);
          // In RTL, if `horizontalAlign` is "left", that's the same as
          // being right-aligned in LTR. So the dropdown should be in the top
          // right corner.
          dropdownRect = dropdown.getBoundingClientRect();
          expect(dropdownRect.top, 0);
          expect(dropdownRect.right, 100);
        });

        test('with horizontalAlign=right', () async {
          var parent = fixture('RTLDropdownRight');
          dropdown = parent.querySelector('iron-dropdown');
          dropdown.open();

          await wait(1);
          // In RTL, if `horizontalAlign` is "right", that's the same as
          // being left-aligned in LTR. So the dropdown should be in the top
          // left corner.
          dropdownRect = dropdown.getBoundingClientRect();
          expect(dropdownRect.top, 0);
          expect(dropdownRect.left, 0);
        });
      });
    });
  });
}
