@TestOn('browser')
library polymer_elements.test.iron_fit_behavior_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'fixtures/test_fit.dart';

makeScrolling(Element el) {
  el.classes.add('scrolling');
  var template = document.getElementById('ipsum') as TemplateElement;
  for (var i = 0; i < 20; i++) {
    el.append(template.content.clone(true));
  }
}

intersects(Rectangle r1, Rectangle r2) {
  return !(r2.left >= r1.right || r2.right <= r1.left || r2.top >= r1.bottom || r2.bottom <= r1.top);
}

main() async {
  await initPolymer();

  suite('basic', () {
    var el;
    setup(() {
      el = fixture('basic');
    });

    test('position() works without autoFitOnAttach', () {
      el.verticalAlign = 'top';
      el.horizontalAlign = 'left';
      el.position();
      var rect = el.getBoundingClientRect();
      $assert.equal(rect.top, 0, 'top ok');
      $assert.equal(rect.left, 0, 'left ok');
    });

    test('constrain() works without autoFitOnAttach', () {
      el.constrain();
      var style = el.getComputedStyle();
      $assert.equal(style.maxWidth, '${window.innerWidth}px', 'maxWidth ok');
      $assert.equal(style.maxHeight, '${window.innerHeight}px', 'maxHeight ok');
    });

    test('center() works without autoFitOnAttach', () {
      el.center();
      var rect = el.getBoundingClientRect();
      $assert.closeTo(rect.left - (window.innerWidth - rect.right), 0, 5, 'centered horizontally');
      $assert.closeTo(rect.top - (window.innerHeight - rect.bottom), 0, 5, 'centered vertically');
    });
  });

  group('manual positioning', () {
    test('css positioned element is not re-positioned', () {
      TestFit el = fixture('positioned-xy');
      var rect = el.getBoundingClientRect();
      expect(rect.top, 100, reason: 'top is unset');
      expect(rect.left, 100, reason: 'left is unset');
    });

    test('inline positioned element is not re-positioned', () async {
      TestFit el = fixture('inline-positioned-xy');
      await new Future(() {});
      var rect = el.getBoundingClientRect();
      // need to measure document.body here because mocha sets a min-width on
      // html,body, and the element is positioned wrt to that by css
      var bodyRect = document.body.getBoundingClientRect();
      expect(rect.top, 100, reason: 'top is unset');
      expect(rect.left, 100, reason: 'left is unset');

      el.refit();

      rect = el.getBoundingClientRect();
      expect(rect.top, 100, reason: 'top is unset after refit');
      expect(rect.left, 100, reason: 'left is unset after refit');
    });

    test('position property is preserved after', () {
      Element el = fixture('absolute');
      expect(el.getComputedStyle().position, 'absolute', reason: 'position:absolute is preserved');
    });
  });

  group('fit to window', () {
    test('sized element is centered in viewport', () async {
      TestFit el = fixture('sized-xy');
      await new Future(() {});
      var rect = el.getBoundingClientRect();
      expect(rect.left - (window.innerWidth - rect.right), closeTo(0, 5), reason: 'centered horizontally');
      expect(rect.top - (window.innerHeight - rect.bottom), closeTo(0, 5), reason: 'centered vertically');
    });

    test('sized element with margin is centered in viewport', () {
      TestFit el = fixture('sized-xy');
      el.classes.add('with-margin');
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.left - (window.innerWidth - rect.right), closeTo(0, 5), reason: 'centered horizontally');
      expect(rect.top - (window.innerHeight - rect.bottom), closeTo(0, 5), reason: 'centered vertically');
    });

    test('sized element with transformed parent is centered in viewport', () {
      var constrain = fixture('constrain-target');
      var el = Polymer.dom(constrain).querySelector('.el');
      var rectBefore = el.getBoundingClientRect();
      constrain.style.transform = 'translate3d(5px, 5px, 0)';
      el.center();
      var rectAfter = el.getBoundingClientRect();
      expect(rectBefore.top, rectAfter.top, reason: 'top ok');
      expect(rectBefore.bottom, rectAfter.bottom, reason: 'bottom ok');
      expect(rectBefore.left, rectAfter.left, reason: 'left ok');
      expect(rectBefore.right, rectAfter.right, reason: 'right ok');
    });

    test('scrolling element is centered in viewport', () {
      TestFit el = fixture('sized-x');
      makeScrolling(el);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.left - (window.innerWidth - rect.right), closeTo(0, 5), reason: 'centered horizontally');
      expect(rect.top - (window.innerHeight - rect.bottom), closeTo(0, 5), reason: 'centered vertically');
    });

    test('scrolling element is constrained to viewport height', () {
      TestFit el = fixture('sized-x');
      makeScrolling(el);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.height, lessThanOrEqualTo(window.innerHeight), reason: 'height is less than or equal to viewport height');
    });

    test('scrolling element with offscreen container is constrained to viewport height', () {
      var container = fixture('offscreen-container');
      var el = Polymer.dom(container).querySelector('.el');
      makeScrolling(el);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.height, lessThanOrEqualTo(window.innerHeight), reason: 'height is less than or equal to viewport height');
    });

    test('scrolling element with max-height is centered in viewport', () {
      TestFit el = fixture('sized-x');
      el.classes.add('with-max-height');
      makeScrolling(el);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.left - (window.innerWidth - rect.right), closeTo(0, 5), reason: 'centered horizontally');
      expect(rect.top - (window.innerHeight - rect.bottom), closeTo(0, 5), reason: 'centered vertically');
    });

    test('scrolling element with max-height respects max-height', () {
      TestFit el = fixture('sized-x');
      el.classes.add('with-max-height');
      makeScrolling(el);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.height, lessThanOrEqualTo(500), reason: 'height is less than or equal to max-height');
    });

    test(
        'css positioned, scrolling element is constrained to viewport height '
        '(top,left)', () {
      TestFit el = fixture('positioned-xy');
      makeScrolling(el);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.height, lessThanOrEqualTo(window.innerHeight - 100), reason: 'height is less than or equal to viewport height');
    });

    test(
        'css positioned, scrolling element is constrained to viewport height '
        '(bottom, right)', () {
      TestFit el = fixture('sized-x');
      el.classes.add('positioned-bottom');
      el.classes.add('positioned-right');
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.height, lessThanOrEqualTo(window.innerHeight - 100), reason: 'height is less than or equal to viewport height');
    });

    test('sized, scrolling element with margin is centered in viewport', () {
      TestFit el = fixture('sized-x');
      el.classes.add('with-margin');
      makeScrolling(el);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.left - (window.innerWidth - rect.right), closeTo(0, 5), reason: 'centered horizontally');
      expect(rect.top - (window.innerHeight - rect.bottom), closeTo(0, 5), reason: 'centered vertically');
    });

    test('sized, scrolling element is constrained to viewport height', () {
      TestFit el = fixture('sized-x');
      el.classes.add('with-margin');
      makeScrolling(el);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.height, lessThanOrEqualTo(window.innerHeight - 20 * 2), reason: 'height is less than or equal to viewport height');
    });

    test(
        'css positioned, scrolling element with margin is constrained to '
        'viewport height (top, left)', () {
      TestFit el = fixture('positioned-xy');
      el.classes.add('with-margin');
      makeScrolling(el);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.height, lessThanOrEqualTo(window.innerHeight - 100 - 20 * 2), reason: 'height is less than or equal to viewport height');
    }, skip: 'https://github.com/dart-lang/polymer_elements/issues/53');

    test(
        'css positioned, scrolling element with margin is constrained to '
        'viewport height (bottom, right)', () {
      TestFit el = fixture('sized-x');
      el.classes.add('positioned-bottom');
      el.classes.add('positioned-right');
      el.classes.add('with-margin');
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.height, lessThanOrEqualTo(window.innerHeight - 100 - 20 * 2), reason: 'height is less than or equal to viewport height');
    }, skip: 'https://github.com/dart-lang/polymer_elements/issues/53');

    test('scrolling sizingTarget is constrained to viewport height', () {
      TestFit el = fixture('sectioned');
      var internal = Polymer.dom(el).querySelector('.internal');
      el.sizingTarget = internal;
      makeScrolling(internal);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.height, lessThanOrEqualTo(window.innerHeight), reason: 'height is less than or equal to viewport height');
    });

    test('scrolling sizingTarget preserves scrolling position', () {
      TestFit el = fixture('scrollable');
      el.scrollTop = 20;
      el.scrollLeft = 20;
      el.refit();
      $assert.equal(el.scrollTop, 20, 'scrollTop ok');
      $assert.equal(el.scrollLeft, 20, 'scrollLeft ok');
    });
  });

  group('fit to element', () {
    test('element fits in another element', () {
      var constrain = fixture('constrain-target');
      TestFit el = Polymer.dom(constrain).querySelector('.el');
      makeScrolling(el);
      el.fitInto = constrain;
      el.refit();
      var rect = el.getBoundingClientRect();
      var crect = constrain.getBoundingClientRect();
      expect(rect.height, lessThanOrEqualTo(crect.height), reason: 'width is less than or equal to fitInto width');
      expect(rect.height, lessThanOrEqualTo(crect.height), reason: 'height is less than or equal to fitInto height');
    });

    test('element centers in another element', () {
      var constrain = fixture('constrain-target');
      TestFit el = Polymer.dom(constrain).querySelector('.el');
      makeScrolling(el);
      el.fitInto = constrain;
      el.refit();
      var rect = el.getBoundingClientRect();
      var crect = constrain.getBoundingClientRect();
      expect(rect.left - crect.left - (crect.right - rect.right), closeTo(0, 5), reason: 'centered horizontally in fitInto');
      expect(rect.top - crect.top - (crect.bottom - rect.bottom), closeTo(0, 5), reason: 'centered vertically in fitInto');
    });

    test('element with max-width centers in another element', () {
      var constrain = document.querySelector('.constrain');
      TestFit el = fixture('sized-xy');
      el.classes.add('with-max-width');
      el.fitInto = constrain;
      el.refit();
      var rect = el.getBoundingClientRect();
      var crect = constrain.getBoundingClientRect();
      expect(rect.left - crect.left - (crect.right - rect.right), closeTo(0, 5), reason: 'centered horizontally in fitInto');
      expect(rect.top - crect.top - (crect.bottom - rect.bottom), closeTo(0, 5), reason: 'centered vertically in fitInto');
    });
  });

  suite('horizontal/vertical align', () {
    DivElement parent;
    Rectangle parentRect;
    TestFit el;
    Rectangle elRect;
    Rectangle fitRect = new Rectangle(0, 0, window.innerWidth, window.innerHeight);

    setup(() {
      parent = fixture('constrain-target');
      parentRect = parent.getBoundingClientRect();
      el = Polymer.dom(parent).querySelector('.el');
      elRect = el.getBoundingClientRect();
    });

    test('intersects works', () {
      Rectangle base = new Rectangle(0, 0, 1, 1);
      $assert.isTrue(intersects(base, base), 'intersects itself');
      $assert.isFalse(intersects(base, new Rectangle(0, 1, 1, 1)), 'no intersect on edge');
      $assert.isFalse(intersects(base, new Rectangle(0, -2, 1, 1)), 'no intersect on edge (negative values)');
      $assert.isFalse(intersects(base, new Rectangle(0, 2, 1, 1)), 'no intersect');
    });

    suite('when verticalAlign is top', () {
      test('element is aligned to the positionTarget top', () {
        el.verticalAlign = 'top';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.top, parentRect.top, 'top ok');
        $assert.equal(rect.height, elRect.height, 'no cropping');
      });

      test('element is aligned to the positionTarget top without overlapping it', () {
        // Allow enough space on the parent's bottom & right.
        parent.style.width = '10px';
        parent.style.height = '10px';
        parentRect = parent.getBoundingClientRect();
        el.verticalAlign = 'top';
        el.noOverlap = true;
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.isFalse(intersects(rect, parentRect), 'no overlap');
        $assert.equal(rect.height, elRect.height, 'no cropping');
      });

      test('element margin is considered as offset', () {
        el.verticalAlign = 'top';
        el.style.marginTop = '10px';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.top, parentRect.top + 10, 'top ok');
        $assert.equal(rect.height, elRect.height, 'no cropping');

        el.style.marginTop = '-10px';
        el.refit();
        rect = el.getBoundingClientRect();
        $assert.equal(rect.top, parentRect.top - 10, 'top ok');
        $assert.equal(rect.height, elRect.height, 'no cropping');
      });

      test('verticalOffset is applied', () {
        el.verticalAlign = 'top';
        el.verticalOffset = 10;
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.top, parentRect.top + 10, 'top ok');
        $assert.equal(rect.height, elRect.height, 'no cropping');
      });

      test('max-height is updated', () {
        parent.style.top = '-10px';
        el.verticalAlign = 'top';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.top, 0, 'top ok');
        $assert.isBelow(rect.height, elRect.height, 'height ok');
      });

      test('min-height is preserved: element is displayed even if partially', () {
        parent.style.top = '-10px';
        el.verticalAlign = 'top';
        el.style.minHeight = '${elRect.height}px';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.height, elRect.height, 'min-height ok');
        $assert.isTrue(intersects(rect, fitRect), 'partially visible');
      });

      test('dynamicAlign will prefer bottom align if it minimizes the cropping', () {
        parent.style.top = '-10px';
        parentRect = parent.getBoundingClientRect();
        el.verticalAlign = 'top';
        el.dynamicAlign = true;
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.bottom, parentRect.bottom, 'bottom ok');
        $assert.equal(rect.height, elRect.height, 'no cropping');
      });
    });

    suite('when verticalAlign is bottom', () {
      test('element is aligned to the positionTarget bottom', () {
        el.verticalAlign = 'bottom';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.bottom, parentRect.bottom, 'bottom ok');
        $assert.equal(rect.height, elRect.height, 'no cropping');
      }, skip: 'https://github.com/dart-lang/polymer_elements/issues/53');

      test('element is aligned to the positionTarget bottom without overlapping it', () {
        el.verticalAlign = 'bottom';
        el.noOverlap = true;
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.isFalse(intersects(rect, parentRect), 'no overlap');
        $assert.equal(rect.height, elRect.height, 'no cropping');
      }, skip: 'https://github.com/dart-lang/polymer_elements/issues/53');

      test('element margin is considered as offset', () {
        el.verticalAlign = 'bottom';
        el.style.marginBottom = '10px';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.bottom, parentRect.bottom - 10, 'bottom ok');
        $assert.equal(rect.height, elRect.height, 'no cropping');

        el.style.marginBottom = '-10px';
        el.refit();
        rect = el.getBoundingClientRect();
        $assert.equal(rect.bottom, parentRect.bottom + 10, 'bottom ok');
        $assert.equal(rect.height, elRect.height, 'no cropping');
      }, skip: 'https://github.com/dart-lang/polymer_elements/issues/53');

      test('verticalOffset is applied', () {
        el.verticalAlign = 'bottom';
        el.verticalOffset = 10;
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.bottom, parentRect.bottom - 10, 'bottom ok');
        $assert.equal(rect.height, elRect.height, 'no cropping');
      }, skip: 'https://github.com/dart-lang/polymer_elements/issues/53');

      test('element max-height is updated', () {
        parent.style.top = '${(100 - parentRect.height)}px';
        el.verticalAlign = 'bottom';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.bottom, 100, 'bottom ok');
        $assert.equal(rect.height, 100, 'height ok');
      });

      test('min-height is preserved: element is displayed even if partially', () {
        parent.style.top = '${(elRect.height - 10 - parentRect.height)}px';
        el.verticalAlign = 'bottom';
        el.style.minHeight = '${elRect.height}px';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.height, elRect.height, 'min-height ok');
        $assert.isTrue(intersects(rect, fitRect), 'partially visible');
      });

      test('dynamicAlign will prefer top align if it minimizes the cropping', () {
        parent.style.top = '${(window.innerHeight - elRect.height)}px';
        parentRect = parent.getBoundingClientRect();
        el.verticalAlign = 'bottom';
        el.dynamicAlign = true;
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.top, parentRect.top, 'top ok');
        $assert.equal(rect.height, elRect.height, 'no cropping');
      });
    });

    suite('when verticalAlign is auto', () {
      test('element is aligned to the positionTarget top', () {
        el.verticalAlign = 'auto';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.top, parentRect.top, 'auto aligned to top');
        $assert.equal(rect.height, elRect.height, 'no cropping');
      });

      test('element is aligned to the positionTarget top without overlapping it', () {
        // Allow enough space on the parent's bottom & right.
        parent.style.width = '10px';
        parent.style.height = '10px';
        parentRect = parent.getBoundingClientRect();
        el.verticalAlign = 'auto';
        el.noOverlap = true;
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.height, elRect.height, 'no cropping');
        $assert.isFalse(intersects(rect, parentRect), 'no overlap');
      });

      test('bottom is preferred to top if it diminishes the cropped area', () {
        // This would cause a cropping of the element, so it should automatically
        // align to the bottom to avoid it.
        parent.style.top = '-10px';
        parentRect = parent.getBoundingClientRect();
        el.verticalAlign = 'auto';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.bottom, parentRect.bottom, 'auto aligned to bottom');
        $assert.equal(rect.height, elRect.height, 'no cropping');
      });

      test('bottom is preferred to top if it diminishes the cropped area, without overlapping positionTarget', () {
        // This would cause a cropping of the element, so it should automatically
        // align to the bottom to avoid it.
        parent.style.top = '-10px';
        parentRect = parent.getBoundingClientRect();
        el.verticalAlign = 'auto';
        el.noOverlap = true;
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.height, elRect.height, 'no cropping');
        $assert.isFalse(intersects(rect, parentRect), 'no overlap');
      });
    });

    suite('when horizontalAlign is left', () {
      test('element is aligned to the positionTarget left', () {
        el.horizontalAlign = 'left';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.left, parentRect.left, 'left ok');
        $assert.equal(rect.width, elRect.width, 'no cropping');
      });

      test('element is aligned to the positionTarget left without overlapping it', () {
        // Make space at the parent's right.
        parent.style.width = '10px';
        parentRect = parent.getBoundingClientRect();
        el.horizontalAlign = 'left';
        el.noOverlap = true;
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.isFalse(intersects(rect, parentRect), 'no overlap');
        $assert.equal(rect.width, elRect.width, 'no cropping');
      });

      test('element margin is considered as offset', () {
        el.horizontalAlign = 'left';
        el.style.marginLeft = '10px';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.left, parentRect.left + 10, 'left ok');
        $assert.equal(rect.width, elRect.width, 'no cropping');

        el.style.marginLeft = '-10px';
        el.refit();
        rect = el.getBoundingClientRect();
        $assert.equal(rect.left, parentRect.left - 10, 'left ok');
        $assert.equal(rect.width, elRect.width, 'no cropping');
      });

      test('horizontalOffset is applied', () {
        el.horizontalAlign = 'left';
        el.horizontalOffset = 10;
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.left, parentRect.left + 10, 'left ok');
        $assert.equal(rect.width, elRect.width, 'no cropping');
      });

      test('element max-width is updated', () {
        parent.style.left = '-10px';
        el.horizontalAlign = 'left';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.left, 0, 'left ok');
        $assert.isBelow(rect.width, elRect.width, 'width ok');
      });

      test('min-width is preserved: element is displayed even if partially', () {
        parent.style.left = '-10px';
        el.style.minWidth = '${elRect.width}px';
        el.horizontalAlign = 'left';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.width, elRect.width, 'min-width ok');
        $assert.isTrue(intersects(rect, fitRect), 'partially visible');
      });

      test('dynamicAlign will prefer right align if it minimizes the cropping', () {
        parent.style.left = '-10px';
        parentRect = parent.getBoundingClientRect();
        el.horizontalAlign = 'left';
        el.dynamicAlign = true;
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.right, parentRect.right, 'right ok');
        $assert.equal(rect.height, elRect.height, 'no cropping');
      });
    });

    suite('when horizontalAlign is right', () {
      test('element is aligned to the positionTarget right', () {
        el.horizontalAlign = 'right';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.right, parentRect.right, 'right ok');
        $assert.equal(rect.width, elRect.width, 'no cropping');
      });

      test('element is aligned to the positionTarget right without overlapping it', () {
        // Make space at the parent's left.
        parent.style.left = '${elRect.width}px';
        parentRect = parent.getBoundingClientRect();
        el.horizontalAlign = 'right';
        el.noOverlap = true;
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.isFalse(intersects(rect, parentRect), 'no overlap');
        $assert.equal(rect.width, elRect.width, 'no cropping');
      });

      test('element margin is considered as offset', () {
        el.horizontalAlign = 'right';
        el.style.marginRight = '10px';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.right, parentRect.right - 10, 'right ok');
        $assert.equal(rect.width, elRect.width, 'no cropping');

        el.style.marginRight = '-10px';
        el.refit();
        rect = el.getBoundingClientRect();
        $assert.equal(rect.right, parentRect.right + 10, 'right ok');
        $assert.equal(rect.width, elRect.width, 'no cropping');
      });

      test('horizontalOffset is applied', () {
        el.horizontalAlign = 'right';
        el.horizontalOffset = 10;
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.right, parentRect.right - 10, 'right ok');
        $assert.equal(rect.width, elRect.width, 'no cropping');
      });

      test('element max-width is updated', () {
        parent.style.left = '${(100 - parentRect.width)}px';
        el.horizontalAlign = 'right';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.right, 100, 'right ok');
        $assert.equal(rect.width, 100, 'width ok');
      });

      test('min-width is preserved: element is displayed even if partially', () {
        parent.style.left = '${(elRect.width - 10 - parentRect.width)}px';
        el.horizontalAlign = 'right';
        el.style.minWidth = '${elRect.width}px';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.width, elRect.width, 'min-width ok');
        $assert.isTrue(intersects(rect, fitRect), 'partially visible');
      });

      test('dynamicAlign will prefer left align if it minimizes the cropping', () {
        parent.style.left = '${(window.innerWidth - elRect.width)}px';
        parentRect = parent.getBoundingClientRect();
        el.horizontalAlign = 'right';
        el.dynamicAlign = true;
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.left, parentRect.left, 'left ok');
        $assert.equal(rect.height, elRect.height, 'no cropping');
      });
    });

    suite('when horizontalAlign is auto', () {
      test('element is aligned to the positionTarget left', () {
        el.horizontalAlign = 'auto';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.left, parentRect.left, 'auto aligned to left');
        $assert.equal(rect.width, elRect.width, 'no cropping');
      });

      test('element is aligned to the positionTarget left without overlapping positionTarget', () {
        // Make space at the parent's left.
        parent.style.left = '${elRect.width}px';
        parentRect = parent.getBoundingClientRect();
        el.horizontalAlign = 'auto';
        el.noOverlap = true;
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.width, elRect.width, 'no cropping');
        $assert.isFalse(intersects(rect, parentRect), 'no overlap');
      });

      test('right is preferred to left if it diminishes the cropped area', () {
        // This would cause a cropping of the element, so it should automatically
        // align to the right to avoid it.
        parent.style.left = '-10px';
        parentRect = parent.getBoundingClientRect();
        el.horizontalAlign = 'auto';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.right, parentRect.right, 'auto aligned to right');
        $assert.equal(rect.width, elRect.width, 'no cropping');
      });

      test('right is preferred to left if it diminishes the cropped area, without overlapping positionTarget', () {
        // Make space at the parent's right.
        parent.style.width = '10px';
        parentRect = parent.getBoundingClientRect();
        el.horizontalAlign = 'auto';
        el.noOverlap = true;
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.width, elRect.width, 'no cropping');
        $assert.isFalse(intersects(rect, parentRect), 'no overlap');
      });
    });

    suite('prefer horizontal overlap to vertical overlap', () {
      setup(() {
        el.noOverlap = true;
        el.dynamicAlign = true;
        // Make space around the positionTarget.
        parent.style.top = '${elRect.height}px';
        parent.style.left = '${elRect.width}px';
        parent.style.width = '10px';
        parent.style.height = '10px';
        parentRect = parent.getBoundingClientRect();
      });

      test('top-left aligns to target bottom-left', () {
        el.verticalAlign = 'top';
        el.horizontalAlign = 'left';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.left, parentRect.left, 'left ok');
        $assert.equal(rect.top, parentRect.bottom, 'top ok');
      }, skip: 'https://github.com/dart-lang/polymer_elements/issues/53');

      test('top-right aligns to target bottom-right', () {
        el.verticalAlign = 'top';
        el.horizontalAlign = 'right';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.right, parentRect.right, 'right ok');
        $assert.equal(rect.top, parentRect.bottom, 'top ok');
      }, skip: 'https://github.com/dart-lang/polymer_elements/issues/53');

      test('bottom-left aligns to target top-left', () {
        el.verticalAlign = 'bottom';
        el.horizontalAlign = 'left';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.left, parentRect.left, 'left ok');
        $assert.equal(rect.bottom, parentRect.top, 'bottom ok');
      });

      test('bottom-right aligns to target top-right', () {
        el.verticalAlign = 'bottom';
        el.horizontalAlign = 'right';
        el.refit();
        var rect = el.getBoundingClientRect();
        $assert.equal(rect.right, parentRect.right, 'right ok');
        $assert.equal(rect.bottom, parentRect.top, 'bottom ok');
      });
    });
  });
}
