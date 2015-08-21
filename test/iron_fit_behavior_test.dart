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

main() async {
  await initWebComponents();

  group('manual positioning', () {
    test('css positioned element is not re-positioned', () {
      TestFit el = fixture('positioned-xy');
      var rect = el.getBoundingClientRect();
      expect(rect.top, 100, reason: 'top is unset');
      expect(rect.left, 100, reason: 'left is unset');
    });

    test('inline positioned element is not re-positioned', () {
      TestFit el = fixture('inline-positioned-xy');
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
      expect(el.getComputedStyle().position, 'absolute',
          reason: 'position:absolute is preserved');
    });
  });

  group('fit to window', () {
    test('sized element is centered in viewport', () {
      TestFit el = fixture('sized-xy');
      var rect = el.getBoundingClientRect();
      expect(rect.left - (window.innerWidth - rect.right), closeTo(0, 5),
          reason: 'centered horizontally');
      expect(rect.top - (window.innerHeight - rect.bottom), closeTo(0, 5),
          reason: 'centered vertically');
    });

    test('sized element with margin is centered in viewport', () {
      TestFit el = fixture('sized-xy');
      el.classes.add('with-margin');
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.left - (window.innerWidth - rect.right), closeTo(0, 5),
          reason: 'centered horizontally');
      expect(rect.top - (window.innerHeight - rect.bottom), closeTo(0, 5),
          reason: 'centered vertically');
    });

    test('scrolling element is centered in viewport', () {
      TestFit el = fixture('sized-x');
      makeScrolling(el);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.left - (window.innerWidth - rect.right), closeTo(0, 5),
          reason: 'centered horizontally');
      expect(rect.top - (window.innerHeight - rect.bottom), closeTo(0, 5),
          reason: 'centered vertically');
    });

    test('scrolling element is constrained to viewport height', () {
      TestFit el = fixture('sized-x');
      makeScrolling(el);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.height, lessThanOrEqualTo(window.innerHeight),
          reason: 'height is less than or equal to viewport height');
    });

    test('scrolling element with max-height is centered in viewport', () {
      TestFit el = fixture('sized-x');
      el.classes.add('with-max-height');
      makeScrolling(el);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.left - (window.innerWidth - rect.right), closeTo(0, 5),
          reason: 'centered horizontally');
      expect(rect.top - (window.innerHeight - rect.bottom), closeTo(0, 5),
          reason: 'centered vertically');
    });

    test('scrolling element with max-height respects max-height', () {
      TestFit el = fixture('sized-x');
      el.classes.add('with-max-height');
      makeScrolling(el);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.height, lessThanOrEqualTo(500),
          reason: 'height is less than or equal to max-height');
    });

    test(
        'css positioned, scrolling element is constrained to viewport height '
        '(top,left)', () {
      TestFit el = fixture('positioned-xy');
      makeScrolling(el);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.height, lessThanOrEqualTo(window.innerHeight - 100),
          reason: 'height is less than or equal to viewport height');
    });

    test(
        'css positioned, scrolling element is constrained to viewport height '
        '(bottom, right)', () {
      TestFit el = fixture('sized-x');
      el.classes.add('positioned-bottom');
      el.classes.add('positioned-right');
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.height, lessThanOrEqualTo(window.innerHeight - 100),
          reason: 'height is less than or equal to viewport height');
    });

    test('sized, scrolling element with margin is centered in viewport', () {
      TestFit el = fixture('sized-x');
      el.classes.add('with-margin');
      makeScrolling(el);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.left - (window.innerWidth - rect.right), closeTo(0, 5),
          reason: 'centered horizontally');
      expect(rect.top - (window.innerHeight - rect.bottom), closeTo(0, 5),
          reason: 'centered vertically');
    });

    test('sized, scrolling element is constrained to viewport height', () {
      TestFit el = fixture('sized-x');
      el.classes.add('with-margin');
      makeScrolling(el);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.height, lessThanOrEqualTo(window.innerHeight - 20 * 2),
          reason: 'height is less than or equal to viewport height');
    });

    test(
        'css positioned, scrolling element with margin is constrained to '
        'viewport height (top, left)', () {
      TestFit el = fixture('positioned-xy');
      el.classes.add('with-margin');
      makeScrolling(el);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.height, lessThanOrEqualTo(window.innerHeight - 100 - 20 * 2),
          reason: 'height is less than or equal to viewport height');
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
      expect(rect.height, lessThanOrEqualTo(window.innerHeight - 100 - 20 * 2),
          reason: 'height is less than or equal to viewport height');
    }, skip: 'https://github.com/dart-lang/polymer_elements/issues/53');

    test('scrolling sizingTarget is constrained to viewport height', () {
      TestFit el = fixture('sectioned');
      var internal = Polymer.dom(el).querySelector('.internal');
      el.sizingTarget = internal;
      makeScrolling(internal);
      el.refit();
      var rect = el.getBoundingClientRect();
      expect(rect.height, lessThanOrEqualTo(window.innerHeight),
          reason: 'height is less than or equal to viewport height');
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
      expect(rect.height, lessThanOrEqualTo(crect.height),
          reason: 'width is less than or equal to fitInto width');
      expect(rect.height, lessThanOrEqualTo(crect.height),
          reason: 'height is less than or equal to fitInto height');
    });

    test('element centers in another element', () {
      var constrain = fixture('constrain-target');
      TestFit el = Polymer.dom(constrain).querySelector('.el');
      makeScrolling(el);
      el.fitInto = constrain;
      el.refit();
      var rect = el.getBoundingClientRect();
      var crect = constrain.getBoundingClientRect();
      expect(rect.left - crect.left - (crect.right - rect.right), closeTo(0, 5),
          reason: 'centered horizontally in fitInto');
      expect(rect.top - crect.top - (crect.bottom - rect.bottom), closeTo(0, 5),
          reason: 'centered vertically in fitInto');
    });
  });
}
