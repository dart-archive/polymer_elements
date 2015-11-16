// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_tooltip_test;

import 'dart:async';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_tooltip.dart';
import 'package:test/test.dart';
import 'common.dart';
import 'sinon/sinon.dart' as sinon;
import 'fixtures/tooltip_button.dart';

/**
 * Original tests:
 * https://github.com/PolymerElements/paper-tooltip/tree/master/test
 */
/// Uses [TestButton]
main() async {
  await initPolymer();

  bool isHidden(element) {
    var rect = element.getBoundingClientRect();
    return (rect.width == 0 && rect.height == 0);
  }

  group('basic', () {
    test('tooltip is shown when target is focused', () {
      DivElement f = fixture('no-text');
      DivElement target = f.querySelector('#target');
      PaperTooltip tooltip = f.querySelector('paper-tooltip');

      var actualTooltip = Polymer.dom(tooltip.root).querySelector('#tooltip');
      expect(isHidden(actualTooltip), isTrue);

      focus(target);
      expect(isHidden(actualTooltip), isTrue);
    });

    test('tooltip is not shown if empty', () {
      HtmlElement f = fixture('basic');
      DivElement target = f.querySelector('#target');
      PaperTooltip tooltip = f.querySelector('paper-tooltip');

      HtmlElement actualTooltip = tooltip.querySelector('#tooltip');
      expect(isHidden(actualTooltip), isTrue);

      focus(target);
      expect(isHidden(actualTooltip), isFalse);
    });

    test('tooltip is positioned correctly (bottom)', () {
      HtmlElement f = fixture('basic');
      DivElement target = f.querySelector('#target');
      PaperTooltip tooltip = f.querySelector('paper-tooltip');

      HtmlElement actualTooltip = tooltip.querySelector('#tooltip');
      expect(isHidden(actualTooltip), isTrue);

      focus(target);
      expect(isHidden(actualTooltip), isFalse);

      Rectangle divRect = target.getBoundingClientRect();
      expect(divRect.width, equals(100));
      expect(divRect.height, equals(20));

      Rectangle contentRect = tooltip.getBoundingClientRect();
      expect(contentRect.width, equals(70));
      expect(contentRect.height, equals(30));

      // The target div width is 100, and the tooltip width is 70, and
      // it's centered. The height of the target div is 20, and the
      // tooltip is 14px below.

      expect(contentRect.left, equals((100 - 70) / 2));
      expect(contentRect.top, equals(20 + 14));

      // Also check the math, just in case.
      expect(contentRect.left, equals((divRect.width - contentRect.width) / 2));
      expect(contentRect.top, equals(divRect.height + tooltip.offset));
    });

    test('tooltip is positioned correctly (top)', () {
      DivElement f = fixture('basic');
      DivElement target = f.querySelector('#target');
      PaperTooltip tooltip = f.querySelector('paper-tooltip');
      tooltip.position = 'top';

      var actualTooltip = Polymer.dom(tooltip.root).querySelector('#tooltip');
      expect(isHidden(actualTooltip), isTrue);

      focus(target);
      expect(isHidden(actualTooltip), isFalse);

      var divRect = target.getBoundingClientRect();
      expect(divRect.width, 100);
      expect(divRect.height, 20);

      var contentRect = tooltip.getBoundingClientRect();
      expect(contentRect.width, 70);
      expect(contentRect.height, 30);

      // The target div width is 100, and the tooltip width is 70, and
      // it's centered. The height of the tooltip is 30, and the
      // tooltip is 14px above the target.
      expect(contentRect.left, (100 - 70) / 2);
      expect(contentRect.top, 0 - 30 - 14);

      // Also check the math, just in case.
      expect(contentRect.left, (divRect.width - contentRect.width) / 2);
      expect(contentRect.top, 0 - contentRect.height - tooltip.offset);
    });

    test('tooltip is positioned correctly (right)', () {
      DivElement f = fixture('basic');
      DivElement target = f.querySelector('#target');
      PaperTooltip tooltip = f.querySelector('paper-tooltip');
      tooltip.position = 'right';

      var actualTooltip = Polymer.dom(tooltip.root).querySelector('#tooltip');
      expect(isHidden(actualTooltip), isTrue);

      focus(target);
      expect(isHidden(actualTooltip), isFalse);

      var divRect = target.getBoundingClientRect();
      expect(divRect.width, 100);
      expect(divRect.height, 20);

      var contentRect = tooltip.getBoundingClientRect();
      expect(contentRect.width, 70);
      expect(contentRect.height, 30);

      // The target div width is 100, and the tooltip is 14px to the right.
      // The target div height is 20, the height of the tooltip is 20px, and
      // the tooltip is centered.
      expect(contentRect.left, 100 + 14);
      expect(contentRect.top, (20 - 30) / 2);

      // Also check the math, just in case.
      expect(contentRect.left, divRect.width + tooltip.offset);
      expect(contentRect.top, (divRect.height - contentRect.height) / 2);
    });

    test('tooltip is positioned correctly (left)', () {
      DivElement f = fixture('basic');
      DivElement target = f.querySelector('#target');
      PaperTooltip tooltip = f.querySelector('paper-tooltip');
      tooltip.position = 'left';

      var actualTooltip = Polymer.dom(tooltip.root).querySelector('#tooltip');
      expect(isHidden(actualTooltip), isTrue);

      focus(target);
      expect(isHidden(actualTooltip), isFalse);

      var divRect = target.getBoundingClientRect();
      expect(divRect.width, 100);
      expect(divRect.height, 20);

      var contentRect = tooltip.getBoundingClientRect();
      expect(contentRect.width, 70);
      expect(contentRect.height, 30);

      // The tooltip width is 70px, and the tooltip is 14px to the left of the target.
      // The target div height is 20, the height of the tooltip is 20px, and
      // the tooltip is centered.
      expect(contentRect.left, 0 - 70 - 14);
      expect(contentRect.top, (20 - 30) / 2);

      // Also check the math, just in case.
      expect(contentRect.left, 0 - contentRect.width - tooltip.offset);
      expect(contentRect.top, (divRect.height - contentRect.height) / 2);
    });

    test('tooltip is fitted correctly if out of bounds', () {
      DivElement f = fixture('fitted');
      DivElement target = f.querySelector('#target');
      PaperTooltip tooltip = f.querySelector('paper-tooltip');
      target.style.top = '0px';
      target.style.left = '0px';

      var actualTooltip = Polymer.dom(tooltip.root).querySelector('#tooltip');
      expect(isHidden(actualTooltip), isTrue);

      focus(target);
      expect(isHidden(actualTooltip), isFalse);

      var contentRect = tooltip.getBoundingClientRect();
      var divRect = target.getBoundingClientRect();

      // Should be fitted on the left side.
      expect(contentRect.left, 0);
      expect(contentRect.top, divRect.height + tooltip.offset);
    });

    test('tooltip is positioned correctly after being dynamically set', () {
      HtmlElement f = fixture('dynamic');
      DivElement target = f.querySelector('#target');
      PaperTooltip tooltip = f.querySelector('paper-tooltip');

      HtmlElement actualTooltip = tooltip.querySelector('#tooltip');
      expect(isHidden(actualTooltip), isTrue);

      // Skip animations in this test, which means we'll show and hide
      // the tooltip manually, instead of calling focus and blur.

      // The tooltip is shown because it's a sibling of the target,
      // but it's positioned incorrectly
      tooltip.toggleClass('hidden', false, actualTooltip);
      expect(isHidden(actualTooltip), isFalse);

      Rectangle contentRect = tooltip.getBoundingClientRect();
      expect(contentRect.left, isNot((100 - 70) / 2));

      tooltip.forId = 'target';

      // The tooltip needs to hide before it gets repositioned.
      tooltip.toggleClass('hidden', true, actualTooltip);
      tooltip.updatePosition();
      tooltip.toggleClass('hidden', false, actualTooltip);
      expect(isHidden(actualTooltip), isFalse);

      // The target div width is 100, and the tooltip width is 70, and
      // it's centered. The height of the target div is 20, and the
      // tooltip is 14px below.
      contentRect = tooltip.getBoundingClientRect();
      expect(contentRect.left, equals((100 - 70) / 2));
      expect(contentRect.top, equals(20 + 14));
    });

    test('tooltip is hidden after target is blurred', () {
      Completer done = new Completer();

      HtmlElement f = fixture('basic');
      DivElement target = f.querySelector('#target');
      PaperTooltip tooltip = f.querySelector('paper-tooltip');

      HtmlElement actualTooltip = tooltip.querySelector('#tooltip');
      expect(isHidden(actualTooltip), isTrue);
      focus(target);
      expect(isHidden(actualTooltip), isFalse);

      tooltip.on['neon-animation-finish'].take(1).listen((_) {
        expect(isHidden(actualTooltip), isTrue);
        done.complete();
      });
      blur(target);

      return done.future;
    });

    test('tooltip unlistens to target on detach', () {
      HtmlElement f = fixture('basic');
      DivElement target = f.querySelector('#target');
      PaperTooltip tooltip = f.querySelector('paper-tooltip');

      sinon.spy(tooltip.jsElement, 'show');

      focus(target);
      expect(tooltip.jsElement['show']['callCount'], equals(1));

      focus(target);
      expect(tooltip.jsElement['show']['callCount'], equals(2));

      tooltip.remove();

      return wait(200).then((_) {
        // No more listener means no more calling show.
        focus(target);
        expect(tooltip.jsElement['show']['callCount'], equals(2));
      });
    });
  });
  group('tooltip is inside a custom element', () {
    TestButton f;
    PaperTooltip tooltip;
    HtmlElement target;

    setUp(() {
      f = fixture('custom');
      target = f.$['button'];
      tooltip = f.$['buttonTooltip'];
    });

    test('tooltip is shown when target is focused', () {
      HtmlElement actualTooltip = tooltip.querySelector('#tooltip');
      expect(isHidden(actualTooltip), isTrue);

      focus(target);
      expect(isHidden(actualTooltip), isFalse);
    });

    test('tooltip is positioned correctly', () {
      HtmlElement actualTooltip = tooltip.querySelector('#tooltip');
      expect(isHidden(actualTooltip), isTrue);

      focus(target);
      expect(isHidden(actualTooltip), isFalse);

      Rectangle divRect = target.getBoundingClientRect();
      expect(divRect.width, equals(100));
      expect(divRect.height, equals(20));

      Rectangle contentRect = tooltip.getBoundingClientRect();
      expect(contentRect.width, equals(30));
      expect(contentRect.height, equals(30));

      // The target div width is 100, and the tooltip width is 70, and
      // it's centered. The height of the target div is 20, and the
      // tooltip is 14px below.
      expect(contentRect.left, equals((100 - 30) / 2));
      expect(contentRect.top, equals(20 + 14));

      // Also check the math, just in case.
      expect(contentRect.left, equals((divRect.width - contentRect.width) / 2));
      expect(contentRect.top, equals(divRect.height + tooltip.offset));
    });
  });

  group('a11y', () {
    test('has aria role "tooltip"', () {
      HtmlElement f = fixture('basic');
      PaperTooltip tooltip = f.querySelector('paper-tooltip');

      expect(tooltip.getAttribute('role'), equals('tooltip'));
    });
  });

  // TODO(jakemac): investigate these
  //
  // a11ySuite('basic');
  // a11ySuite('fitted');
  // a11ySuite('no-text');
  // a11ySuite('dynamic');
  // a11ySuite('custom');
}
