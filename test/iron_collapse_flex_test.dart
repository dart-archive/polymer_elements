// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_collapse_test;

import 'dart:async';
import 'package:polymer_elements/iron_collapse.dart';
import 'package:polymer_elements/iron_flex_layout_classes.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'sinon/sinon.dart';
import 'package:polymer/polymer.dart';

main() async {
  await initPolymer();
  suite('flex', () {
    var container;
    IronCollapse collapse;
    var collapseHeight;

    setup(() {
      container = fixture('test');
      collapse = container.querySelector('iron-collapse');
      collapseHeight = collapse.getComputedStyle().height;
    });

    test('default opened height', () {
      $assert.equal(collapse.style.height, '');
    });

    test('set opened to false triggers animation', when((done) {
      collapse.opened = false;
      // Animation got enabled.
      $assert.notEqual(collapse.style.transitionDuration, '0s');
      collapse.on['transitionend'].take(1).listen((_) {
        // Animation disabled.
        $assert.equal(collapse.style.transitionDuration, '0s');
        done();
      });
    }),skip: 'https://github.com/dart-lang/polymer_elements/issues/116' );

    test('enableTransition(false) disables animations', () {
      collapse.noAnimation=true;
      $assert.isTrue(collapse.noAnimation, '`noAnimation` is true');
      // trying to animate the size update
      collapse.updateSize('0px', true);
      // Animation immediately disabled.
      $assert.equal(collapse.style.maxHeight, '0px');
    });

    test('set opened to false, then to true', when((done) {
      // this listener will be triggered twice (every time `opened` changes)
      collapse.on['transitionend'].take(1).listen((_) {
        if (collapse.opened) {
          // Check finalSize after animation is done.
          $assert.equal(collapse.style.maxHeight, '');
          done();
        } else {
          // Check if size is still 0px.
          $assert.equal(collapse.style.maxHeight, '0px');
          // Trigger 2nd toggle.
          collapse.opened = true;
          // Size should be immediately set.
          $assert.equal(collapse.style.maxHeight, collapseHeight);
        }
      });
      // Trigger 1st toggle.
      collapse.opened = false;
      // Size should be immediately set.
      $assert.equal(collapse.style.maxHeight, '0px');
    }),skip: 'https://github.com/dart-lang/polymer_elements/issues/116' );

    test('opened changes trigger iron-resize', () {
      Stub spy = new Stub();
      collapse.addEventListener('iron-resize', spy);
      // No animations for faster test.
      collapse.noAnimation = true;
      collapse.opened = false;
      $assert.isTrue(spy.calledOnce, 'iron-resize was fired');
    });

    test('overflow is hidden while animating', when((done) {
      collapse.on['transitionend'].take(1).listen((_) {
        // Should still be hidden.
        $assert.equal(collapse.getComputedStyle().overflow, 'hidden');
        done();
      });
      $assert.equal(collapse.getComputedStyle().overflow, 'visible');
      collapse.opened = false;
      // Immediately updated style.
      $assert.equal(collapse.getComputedStyle().overflow, 'hidden');
    }),skip: 'https://github.com/dart-lang/polymer_elements/issues/116' );

    test('toggle horizontal updates size', () {
      collapse.horizontal = false;
      $assert.equal(collapse.style.width, '');
      $assert.equal(collapse.style.maxHeight, '');
      $assert.equal(collapse.style.transitionProperty, 'max-height');

      collapse.horizontal = true;
      $assert.equal(collapse.style.maxWidth, '');
      $assert.equal(collapse.style.height, '');
      $assert.equal(collapse.style.transitionProperty, 'max-width');
    });
  });
}
