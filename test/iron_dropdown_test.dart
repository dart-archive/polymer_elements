// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_dropdown_test;

import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_dropdown.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'sinon/sinon.dart';
// ignore: UNUSED_IMPORT
import 'fixtures/x_scrollable_element.dart';
import 'package:polymer_elements/iron_dropdown_scroll_manager.dart';

bool elementIsVisible(element) {
  var contentRect = element.getBoundingClientRect();
  var computedStyle = element.getComputedStyle();
  return computedStyle.display != 'none' && contentRect.width > 0 && contentRect.height > 0;
}

Future runAfterOpen(IronDropdown overlay, Function cb) async {
  overlay.open();
  await overlay.on['iron-overlay-opened'].first;
  await new Future((){});
  await cb();
}

main() async {
  await initPolymer();

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

      test('shows dropdown content when opened', () async {
        await runAfterOpen(dropdown, () async {
          expect(elementIsVisible(content), isTrue);
        });
      });

      test('hides dropdown content when outside is clicked', () async {
        await runAfterOpen(dropdown, () async {
          expect(elementIsVisible(content), isTrue);
          tap(dropdown.parentNode);
          await new Future(() {});
          expect(elementIsVisible(content), isFalse);
        });
      });

      group('when content is focusable', () {
        setUp(() {
          dropdown = fixture('FocusableContentDropdown');
          content = Polymer.dom(dropdown).querySelector('.dropdown-content');
        });

        test('focuses the content when opened', () async {
          await runAfterOpen(dropdown, () async {
            expect(document.activeElement, content);
          });
        });

        test('focuses a configured focus target', () async {
          var focusableChild = Polymer.dom(content).querySelector('div[tabindex]');
          dropdown.focusTarget = focusableChild;

          await runAfterOpen(dropdown, () async {
            expect(document.activeElement, isNot(content));
            expect(document.activeElement, focusableChild);
          });
        });
      });
    });

    group('locking scroll', () {
      var dropdown;

      setUp(() {
        dropdown = fixture('TrivialDropdown');
      });

      test('should lock, only once', () async {
        for (int openCount = 0; openCount < 2; openCount++) {
          await runAfterOpen(dropdown, () async {
            expect(IronDropdownScrollManager.jsProxy['_lockingElements'].length, 1);
            expect(IronDropdownScrollManager.elementIsScrollLocked(document.body), isTrue);

            if (openCount == 0) {
              // This triggers a second `pushScrollLock` with the same element, however
              // that should not add the element to the `_lockingElements` stack twice
              dropdown.close();
              dropdown.open();
            }
          });
        }
      });
    });

    group('non locking scroll', () {
      var dropdown;

      setUp(() {
        dropdown = fixture('NonLockingDropdown');
      });

      test('can be disabled with `allowOutsideScroll`', () async {
        await runAfterOpen(dropdown, () async {
          expect(IronDropdownScrollManager.elementIsScrollLocked(document.body), isFalse);
        });
      });
    });

    group('aligned dropdown', () {
      var parent;
      setUp(() {
        parent = fixture('AlignedDropdown');
        dropdown = parent.querySelector('iron-dropdown');
      });

      test('can be re-aligned to the right and the top', () async {
        var parentRect;
        var dropdownRect;

        await runAfterOpen(dropdown, () async {
          dropdownRect = dropdown.getBoundingClientRect();
          parentRect = parent.getBoundingClientRect();
          expect(dropdownRect.top, parentRect.top, reason: 'top ok');
          expect(dropdownRect.left, 0, reason: 'left ok');
          expect(dropdownRect.bottom, document.documentElement.clientHeight, reason: 'bottom ok');
          expect(dropdownRect.right, parentRect.right, reason: 'right ok');
        });
      });

      test('can be re-aligned to the bottom', () async {
        var parentRect;
        var dropdownRect;

        dropdown.verticalAlign = 'bottom';
        await runAfterOpen(dropdown, () {
          parentRect = parent.getBoundingClientRect();
          dropdownRect = dropdown.getBoundingClientRect();
          expect(dropdownRect.top, 0, reason: 'top ok');
          expect(dropdownRect.left, 0, reason: 'left ok');
          expect(dropdownRect.bottom, parentRect.bottom, reason: 'bottom ok');
          expect(dropdownRect.right, parentRect.right, reason: 'right ok');
        });
      });

      test('handles parent\'s stacking context', () async {
        var parentRect;
        var dropdownRect;
        // This will create a new stacking context.
        parent.style.transform = 'translateZ(0)';
        await runAfterOpen(dropdown, () async {
          dropdownRect = dropdown.getBoundingClientRect();
          parentRect = parent.getBoundingClientRect();
          expect(dropdownRect.top, parentRect.top, reason: 'top ok');
          expect(dropdownRect.left, 0, reason: 'left ok');
          expect(dropdownRect.bottom, document.documentElement.clientHeight, reason: 'bottom ok');
          expect(dropdownRect.right, parentRect.right, reason: 'right ok');
        });
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
        await runAfterOpen(dropdown, () async {
          dropdownRect = dropdown.getBoundingClientRect();

          dropdown.verticalOffset = 10;
          dropdown.horizontalOffset = 10;
          await PolymerRenderStatus.afterNextRender(dropdown);
          offsetDropdownRect = dropdown.getBoundingClientRect();

          // verticalAlign is top, so a positive offset moves down.
          expect(dropdownRect.top + 10, offsetDropdownRect.top, reason: 'top ok');
          // horizontalAlign is left, so a positive offset moves to the right.
          expect(dropdownRect.left + 10, offsetDropdownRect.left, reason: 'left ok');
        });
      });

      test('can be offset towards the top left', () async {
        await runAfterOpen(dropdown, () async {
          dropdownRect = dropdown.getBoundingClientRect();

          dropdown.verticalOffset = -10;
          dropdown.horizontalOffset = -10;
          await PolymerRenderStatus.afterNextRender(dropdown);
          offsetDropdownRect = dropdown.getBoundingClientRect();

          // verticalAlign is top, so a negative offset moves up.
          expect(dropdownRect.top - 10, offsetDropdownRect.top, reason: 'top ok');
          // horizontalAlign is left, so a negative offset moves to the left.
          expect(dropdownRect.left - 10, offsetDropdownRect.left, reason: 'left ok');
        });
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
        await runAfterOpen(dropdown, () async {
          dropdownRect = dropdown.getBoundingClientRect();

          dropdown.verticalOffset = 10;
          dropdown.horizontalOffset = 10;
          await PolymerRenderStatus.afterNextRender(dropdown);
          offsetDropdownRect = dropdown.getBoundingClientRect();

          // verticalAlign is bottom, so a positive offset moves up.
          expect(dropdownRect.bottom - 10, offsetDropdownRect.bottom, reason: 'bottom ok');
          // horizontalAlign is right, so a positive offset moves to the left.
          expect(dropdownRect.right - 10, offsetDropdownRect.right, reason: 'right ok');
        });
      });

      test('can be offset towards the bottom right', () async {
        await runAfterOpen(dropdown, () async {
          dropdownRect = dropdown.getBoundingClientRect();

          dropdown.verticalOffset = -10;
          dropdown.horizontalOffset = -10;
          await PolymerRenderStatus.afterNextRender(dropdown);
          offsetDropdownRect = dropdown.getBoundingClientRect();

          // verticalAlign is bottom, so a negative offset moves down.
          expect(dropdownRect.bottom + 10, offsetDropdownRect.bottom, reason: 'bottom ok');
          // horizontalAlign is right, so a positive offset moves to the right.
          expect(dropdownRect.right + 10, offsetDropdownRect.right, reason: 'right ok');
        });
      });
    });

    group('RTL', () {
      var dropdown;
      var dropdownRect;

      test('with horizontalAlign=left', () async {
        var parent = fixture('RTLDropdownLeft');
        dropdown = parent.querySelector('iron-dropdown');
        await runAfterOpen(dropdown, () async {
          // In RTL, if `horizontalAlign` is "left", that's the same as
          // being right-aligned in LTR. So the dropdown should be in the top
          // right corner.
          dropdownRect = dropdown.getBoundingClientRect();
          expect(dropdownRect.top, 0);
          expect(dropdownRect.right, 100);
        });
      });

      test('with horizontalAlign=right', () async {
        var parent = fixture('RTLDropdownRight');
        dropdown = parent.querySelector('iron-dropdown');
        await runAfterOpen(dropdown, () async {
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

  group('IronDropdownScrollManager', () {
    var parent;
    var childOne;
    var childTwo;
    var grandChildOne;
    var grandChildTwo;
    var ancestor;

    setUp(() {
      parent = fixture('DOMSubtree');
      childOne = parent.$$('#ChildOne');
      childTwo = parent.$$('#ChildTwo');
      grandChildOne = parent.$$('#GrandchildOne');
      grandChildTwo = parent.$$('#GrandchildTwo');
      ancestor = document.body;
    });

    group('constraining scroll in the DOM', () {
      setUp(() {
        IronDropdownScrollManager.pushScrollLock(childOne);
      });

      tearDown(() {
        IronDropdownScrollManager.removeScrollLock(childOne);
      });

      test('recognizes sibling as locked', () {
        expect(IronDropdownScrollManager.elementIsScrollLocked(childTwo), true);
      });

      test('recognizes neice as locked', () {
        expect(IronDropdownScrollManager.elementIsScrollLocked(grandChildTwo), true);
      });

      test('recognizes parent as locked', () {
        expect(IronDropdownScrollManager.elementIsScrollLocked(parent), true);
      });

      test('recognizes ancestor as locked', () {
        expect(IronDropdownScrollManager.elementIsScrollLocked(ancestor), true);
      });

      test('recognizes locking child as unlocked', () {
        expect(IronDropdownScrollManager.elementIsScrollLocked(childOne), false);
      });

      test('recognizes descendant of locking child as unlocked', () {
        expect(IronDropdownScrollManager.elementIsScrollLocked(grandChildOne), false);
      });

      test('unlocks locked elements when there are no locking elements', () {
        IronDropdownScrollManager.removeScrollLock(childOne);

        expect(IronDropdownScrollManager.elementIsScrollLocked(parent), false);
      });

      test('does not check locked elements when there are no locking elements', () {
        Spy s = spy(IronDropdownScrollManager.jsProxy, 'elementIsScrollLocked');
        childOne.dispatchEvent(new CustomEvent('wheel', canBubble: true, cancelable: true));
        expect(s.callCount, 1);
        IronDropdownScrollManager.removeScrollLock(childOne);
        childOne.dispatchEvent(new CustomEvent('wheel', canBubble: true, cancelable: true));
        expect(s.callCount, 1);
      });

      group('various scroll events', () {
        var scrollEvents;
        var events;

        setUp(() {
          scrollEvents = ['wheel', 'mousewheel', 'DOMMouseScroll', 'touchmove'];

          events = scrollEvents.map((scrollEvent) {
            return new CustomEvent(scrollEvent, canBubble: true, cancelable: true);
          });
        });

        test('prevents wheel events from locked elements', () {
          events.forEach((event) {
            childTwo.dispatchEvent(event);
            expect(event.defaultPrevented, true);
          });
        });

        test('allows wheel events from unlocked elements', () {
          events.forEach((event) {
            childOne.dispatchEvent(event);
            expect(event.defaultPrevented, false);
          });
        });
      });
    });
  });
}
