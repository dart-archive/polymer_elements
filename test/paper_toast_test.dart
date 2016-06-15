// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_toast_test;

import 'dart:async';
import 'dart:html';

import 'package:polymer_elements/paper_toast.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';

import 'common.dart';
import 'sinon/sinon.dart' as sinon;

main() async {
  await initWebComponents();

  group('basic', () {
    PaperToast toast;

    test('is hidden', () {
      toast = fixture('basic');
      expect(toast.opened, isFalse, reason: '`opened` is false');
    });

    test('is visible', () {
      toast = fixture('show');
      expect(toast.opened, isTrue, reason: '`opened` is true');
    });

    test('show() will open toast', () {
      toast = fixture('basic');
      toast.show({});
      expect(toast.opened, isTrue, reason: '`opened` is true');
    });

    test('hide() will close toast', () {
      toast = fixture('show');
      toast.hide();
      $assert.isFalse(toast.opened, '`opened` is false');
    });

    test('toast auto-close after 10ms', when((done) async {
      toast = fixture('basic');
      toast.duration = 10;
      toast.show({});
      await wait(12);
      $assert.isFalse(toast.opened, '`opened` is false');
      done();
    }));

    test('toast fires opened event', when((done) async {
      toast = fixture('show');
      toast.on['iron-overlay-opened'].take(1).listen((_) {
        done();
      });
    }),skip:"WHY?");

    test('toast does not get focused', when((done) {
      toast = fixture('show');
      sinon.Spy spy = sinon.spy(toast.jsElement, 'focus');
      $assert.isTrue(toast.noAutoFocus, 'no-auto-focus is true');
      toast.on['iron-overlay-opened'].take(1).listen((_) {
        $assert.isFalse(spy.called, 'toast is not focused');
        done();
      });
    }),skip:"WHY?");

    test('toast fires closed event', when((done) {
      toast = fixture('basic');
      toast.show({"duration": 350});
      toast.on['iron-overlay-closed'].take(1).listen((_) {
        done();
      });
    }),skip:"WHY?");

    test('show() accepts valid properties', () {
      toast = fixture('basic');
      toast.show({"text": 'hello world', "duration": 20});
      $assert.isTrue(toast.opened, '`opened` is true');
      $assert.equal(toast.text, 'hello world', '`text` is correct');
      $assert.equal(toast.duration, 20, '`duration` is correct');
    });

    test('show() does not accept invalid properties', () {
      toast = fixture('basic');
      toast.show({"foo": 'bar'});
      $assert.isUndefined(toast.jsElement['foo'], '`foo` is not a valid property and will not be set');
      $assert.isTrue(toast.opened, '`opened` is true');
    });

    test('show() does not accept private properties', () {
      toast = fixture('basic');
      var temp = toast.jsElement['_manager'];
      toast.show({"_manager": 'bar'});
      $assert.equal(toast.jsElement['_manager'], temp, '`_manager` is a private property and will not be set');
      $assert.isTrue(toast.opened, '`opened` is true');
    });

    test('show() accepts a string argument as the text parameter', () {
      toast = fixture('basic');
      toast.show('hello world 2');
      $assert.equal(toast.text, 'hello world 2', '`text is correct`');
    });

    group('disable auto-close', () {
      sinon.Spy spy;
      setUp(() {
        toast = fixture('basic');
        spy = sinon.spy(toast.jsElement, 'async');
      });
      test('duration = Infinity', () async {
        toast.duration = 999999;
        toast.show({});
        $assert.isFalse(spy.calledWith([toast.jsElement['close']]), '`async` was not called with `close()`');
        $assert.isFalse(spy.calledWith([toast.jsElement['hide']]), '`async` was not called with `hide()`');
      });

      test('duration = 0', () {
        toast.duration = 0;
        toast.show({});
        $assert.isFalse(spy.calledWith([toast.jsElement['close']]), '`async` was not called with `close()`');
        $assert.isFalse(spy.calledWith([toast.jsElement['hide']]), '`async` was not called with `hide()`');
      });

      test('duration = -10', () {
        toast.duration = -10;
        toast.show({});
        $assert.isFalse(spy.calledWith([toast.jsElement['close']]), '`async` was not called with `close()`');
        $assert.isFalse(spy.calledWith([toast.jsElement['hide']]), '`async` was not called with `hide()`');
      });
    });

    test('there is only 1 toast opened', () {
      PaperToast toast1 = fixture('basic');
      PaperToast toast2 = fixture('show');
      toast2.open();
      toast1.open();
      expect(toast1.opened, isTrue, reason: 'toast1 is opened');
      expect(toast2.opened, isFalse, reason: 'toast2 is not opened');
      toast2.open();
      expect(toast1.opened, isFalse, reason: 'toast1 is now not opened');
      expect(toast2.opened, isTrue, reason: 'toast2 is now opened');
    });

    test('auto-close is correctly reset', when((done) async {
      toast = fixture('basic');
      toast.duration = 10;
      toast.show({});
      // a bit later (before the auto-close), toast is reset
      await wait(5);
      toast.hide();
      // keep toast opened
      toast.duration = 0;
      toast.show({});
      await wait(10);
      $assert.isTrue(toast.opened, 'toast is still open');
      done();
    }));

    test('toast is positioned according at the bottom left of its fitInto', () {
      var f = fixture('contained');
      PaperToast toast = f[0];
      var container = f[1];
      toast.fitInto = container;
      toast.center();
      var style = toast.getComputedStyle();
      $assert.equal(style.left, '50px', 'left');
      // Should be 150px from top, (100px of height + 50px of margin-top)
      // aka window height - 150 from bottom.
      $assert.equal(style.bottom, "${(window.innerHeight - 150)}px", 'bottom');
    });

    suite('a11y', () {
      test('show() will announce text', () {
        toast = fixture('basic');
        sinon.Spy spy = sinon.spy(toast.jsElement, 'fire');
        toast.text = 'announce!';
        toast.show({});
        $assert.isTrue(
            spy.calledWith([
              'iron-announce',
              {"text": 'announce!'}
            ]),
            'text announced');
      });

      test('hide() will not announce text', () {
        toast = fixture('show');
        sinon.Spy spy = sinon.spy(toast.jsElement, 'fire');
        toast.hide();
        $assert.isFalse(spy.calledWith(['iron-announce']), 'text not announced');
      });
    });
  });
}
