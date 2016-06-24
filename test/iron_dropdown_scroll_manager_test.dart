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
  var done = overlay.on['iron-overlay-opened'].first;
  overlay.open();
  await done;
  await cb();
}

main() async {
  await initPolymer();

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
