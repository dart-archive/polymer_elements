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

approximatelyEquals(value) {
  return closeTo(value, .1);
}

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
    test('tooltip is shown when target is focused', () async {
      DivElement f = fixture('no-text');
      await new Future(() {});
      DivElement target = f.querySelector('#target');
      PaperTooltip tooltip = f.querySelector('paper-tooltip');

      var actualTooltip = Polymer.dom(tooltip.root).querySelector('#tooltip');
      expect(isHidden(actualTooltip), isTrue);

      focus(target);
      expect(isHidden(actualTooltip), isTrue);
    });

    test('tooltip is not shown if empty', () async {
      HtmlElement f = fixture('basic');
      await new Future(() {});
      DivElement target = f.querySelector('#target');
      PaperTooltip tooltip = f.querySelector('paper-tooltip');

      HtmlElement actualTooltip = tooltip.querySelector('#tooltip');
      expect(isHidden(actualTooltip), isTrue);

      focus(target);
      expect(isHidden(actualTooltip), isFalse);
    });

    test('tooltip doesn\'t throw an exception if it has no offsetParent', () {
      var f = fixture('no-offset-parent');
      var target = f.querySelector('#target');
      var tooltip = f.querySelector('paper-tooltip');

      var actualTooltip = Polymer.dom(tooltip.root).querySelector('#tooltip');
      $assert.isTrue(isHidden(actualTooltip));
      tooltip.updatePosition();
      tooltip.show();

      // Doesn't get shown since there's no position computed.
      $assert.isTrue(isHidden(actualTooltip));
    });

    test('tooltip is positioned correctly (bottom)', () async {
      HtmlElement f = fixture('basic');
      await new Future(() {});
      DivElement target = f.querySelector('#target');
      PaperTooltip tooltip = f.querySelector('paper-tooltip');

      HtmlElement actualTooltip = tooltip.querySelector('#tooltip');
      expect(isHidden(actualTooltip), isTrue);

      focus(target);
      expect(isHidden(actualTooltip), isFalse);

      Rectangle divRect = target.getBoundingClientRect();
      expect(divRect.width, approximatelyEquals(100));
      expect(divRect.height, approximatelyEquals(20));

      Rectangle contentRect = tooltip.getBoundingClientRect();
      expect(contentRect.width, approximatelyEquals(70));
      expect(contentRect.height, approximatelyEquals(30));

      // The target div width is 100, and the tooltip width is 70, and
      // it's centered. The height of the target div is 20, and the
      // tooltip is 14px below.

      expect(contentRect.left, approximatelyEquals((100 - 70) / 2));
      expect(contentRect.top, approximatelyEquals(20 + 14));

      // Also check the math, just in case.
      expect(contentRect.left, approximatelyEquals((divRect.width - contentRect.width) / 2));
      expect(contentRect.top, approximatelyEquals(divRect.height + tooltip.offset));
    });

    test('tooltip is positioned correctly (top)', () async {
      DivElement f = fixture('basic');
      await new Future(() {});
      DivElement target = f.querySelector('#target');
      PaperTooltip tooltip = f.querySelector('paper-tooltip');
      tooltip.position = 'top';

      var actualTooltip = Polymer.dom(tooltip.root).querySelector('#tooltip');
      expect(isHidden(actualTooltip), isTrue);

      focus(target);
      expect(isHidden(actualTooltip), isFalse);

      var divRect = target.getBoundingClientRect();
      expect(divRect.width, approximatelyEquals(100));
      expect(divRect.height, approximatelyEquals(20));

      var contentRect = tooltip.getBoundingClientRect();
      expect(contentRect.width, approximatelyEquals(70));
      expect(contentRect.height, approximatelyEquals(30));

      // The target div width is 100, and the tooltip width is 70, and
      // it's centered. The height of the tooltip is 30, and the
      // tooltip is 14px above the target.
      expect(contentRect.left, approximatelyEquals((100 - 70) / 2));
      expect(contentRect.top, approximatelyEquals(0 - 30 - 14));

      // Also check the math, just in case.
      expect(contentRect.left, approximatelyEquals((divRect.width - contentRect.width) / 2));
      expect(contentRect.top, approximatelyEquals(0 - contentRect.height - tooltip.tooltipOffset));
    });

    test('tooltip is positioned correctly (right)', () async {
      DivElement f = fixture('basic');
      await new Future(() {});
      DivElement target = f.querySelector('#target');
      PaperTooltip tooltip = f.querySelector('paper-tooltip');
      tooltip.position = 'right';

      var actualTooltip = Polymer.dom(tooltip.root).querySelector('#tooltip');
      expect(isHidden(actualTooltip), isTrue);

      focus(target);
      expect(isHidden(actualTooltip), isFalse);

      var divRect = target.getBoundingClientRect();
      expect(divRect.width, approximatelyEquals(100));
      expect(divRect.height, approximatelyEquals(20));

      var contentRect = tooltip.getBoundingClientRect();
      expect(contentRect.width, approximatelyEquals(70));
      expect(contentRect.height, approximatelyEquals(30));

      // The target div width is 100, and the tooltip is 14px to the right.
      // The target div height is 20, the height of the tooltip is 20px, and
      // the tooltip is centered.
      expect(contentRect.left, approximatelyEquals(100 + 14));
      expect(contentRect.top, approximatelyEquals((20 - 30) / 2));

      // Also check the math, just in case.
      expect(contentRect.left, approximatelyEquals(divRect.width + tooltip.offset));
      expect(contentRect.top, approximatelyEquals((divRect.height - contentRect.height) / 2));
    });

    test('tooltip is positioned correctly (left)', () async {
      DivElement f = fixture('basic');
      await new Future(() {});
      DivElement target = f.querySelector('#target');
      PaperTooltip tooltip = f.querySelector('paper-tooltip');
      tooltip.position = 'left';

      var actualTooltip = Polymer.dom(tooltip.root).querySelector('#tooltip');
      expect(isHidden(actualTooltip), isTrue);

      focus(target);
      expect(isHidden(actualTooltip), isFalse);

      var divRect = target.getBoundingClientRect();
      expect(divRect.width, approximatelyEquals(100));
      expect(divRect.height, approximatelyEquals(20));

      var contentRect = tooltip.getBoundingClientRect();
      expect(contentRect.width, approximatelyEquals(70));
      expect(contentRect.height, approximatelyEquals(30));

      // The tooltip width is 70px, and the tooltip is 14px to the left of the target.
      // The target div height is 20, the height of the tooltip is 20px, and
      // the tooltip is centered.
      expect(contentRect.left, approximatelyEquals(0 - 70 - 14));
      expect(contentRect.top, approximatelyEquals((20 - 30) / 2));

      // Also check the math, just in case.
      expect(contentRect.left, approximatelyEquals(0 - contentRect.width - tooltip.tooltipOffset));
      expect(contentRect.top, approximatelyEquals((divRect.height - contentRect.height) / 2));
    });

    test('tooltip is fitted correctly if out of bounds', () async {
      DivElement f = fixture('fitted');
      await new Future(() {});
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
      expect(contentRect.left, approximatelyEquals(0));
      expect(contentRect.top, approximatelyEquals(divRect.height + tooltip.offset));
    });

    test('tooltip is positioned correctly after being dynamically set', () async {
      HtmlElement f = fixture('dynamic');
      await new Future(() {});
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
      expect(contentRect.left, isNot(approximatelyEquals((100 - 70) / 2)));

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
      expect(contentRect.left, approximatelyEquals((100 - 70) / 2));
      expect(contentRect.top, approximatelyEquals(20 + 14));
    });

    test('tooltip is hidden after target is blurred', () async {
      HtmlElement f = fixture('basic');
      await wait(1);
      DivElement target = f.querySelector('#target');
      PaperTooltip tooltip = f.querySelector('paper-tooltip');

      HtmlElement actualTooltip = tooltip.querySelector('#tooltip');
      expect(isHidden(actualTooltip), isTrue);
      focus(target);
      expect(isHidden(actualTooltip), isFalse);

      blur(target);

      // Dart Note: `neon-animation-finished` event wasn't consistently firing
      // so we are just using a delay instead.
      await wait(100);
      expect(isHidden(actualTooltip), isTrue);
    });

    test('tooltip unlistens to target on detach', () async {
      HtmlElement f = fixture('basic');
      await new Future(() {});
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

    setUp(() async {
      f = fixture('custom');
      target = f.$['button'];
      tooltip = f.$['buttonTooltip'];
      await new Future(() {});
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
      expect(divRect.width, approximatelyEquals(100));
      expect(divRect.height, approximatelyEquals(20));

      Rectangle contentRect = tooltip.getBoundingClientRect();
      expect(contentRect.width, approximatelyEquals(30));
      expect(contentRect.height, approximatelyEquals(30));

      // The target div width is 100, and the tooltip width is 70, and
      // it's centered. The height of the target div is 20, and the
      // tooltip is 14px below.
      expect(contentRect.left, approximatelyEquals((100 - 30) / 2));
      expect(contentRect.top, approximatelyEquals(20 + 14));

      // Also check the math, just in case.
      expect(contentRect.left, approximatelyEquals((divRect.width - contentRect.width) / 2));
      expect(contentRect.top, approximatelyEquals(divRect.height + tooltip.offset));
    });
  });

  group('a11y', () {
    test('has aria role "tooltip"', () async {
      HtmlElement f = fixture('basic');
      await new Future(() {});
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
