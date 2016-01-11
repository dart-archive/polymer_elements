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

    test('show() will update `opened`', () {
      toast = fixture('basic');
      toast.show();
      expect(toast.opened, isTrue, reason: '`opened` is true');
    });

    test('show() will auto-close toast after `duration` milliseconds', () async {
      toast = fixture('basic');
      toast.duration = 10;
      var debounceSpy = sinon.spy(toast.jsElement, 'debounce');
      toast.show();
      expect(debounceSpy.called, isTrue, reason: '`debounce` was called');
      await wait(12);
      expect(toast.opened, isFalse, reason: '`opened` is false');
    });

    group('disable auto-close', (){
      sinon.Spy spy;
      setUp((){
        toast = fixture('basic');
        spy = sinon.spy(toast.jsElement, 'debounce');
      });
      test('duration = Infinity', () {
        toast.duration = 999999;
        toast.show();
        expect(spy.called, isTrue, reason: '`debounce` was not called');
      });

      test('duration = 0', () {
        toast.duration = 0;
        toast.show();
        expect(spy.called, isFalse, reason: '`debounce` was not called');
      });

      test('duration = -10', () {
        toast.duration = -10;
        toast.show();
        expect(spy.called, isFalse, reason: '`debounce` was not called');
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

  });
}
