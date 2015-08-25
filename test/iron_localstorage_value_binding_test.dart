// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_localstorage_value_binding_test;

import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_localstorage.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();
  IronLocalstorage storage;

  window.localStorage['iron-localstorage-test'] = '{"foo":"bar"}';
  JsObject xtest;

  group('basic', () {

    setUp(() {
      window.localStorage['iron-localstorage-test'] = '{"foo":"bar"}';
      xtest = new JsObject.fromBrowserObject(fixture('fixture'));
      xtest[r'$']['localstorage'].reload();
    });

    tearDown(() {
      window.localStorage.remove('iron-localstorage-test');
    });

    test('initial value', () {
      expect(xtest['value'], isNotNull);
      expect(xtest['value']['foo'], 'bar');
    });

    test('set value', () {
      var newValue = new JsObject.jsify({'foo': 'zot'});
      xtest['value'] = newValue;
      xtest[r'$']['localstorage'].jsElement
          .callMethod('flushDebouncer', ['save']);
      var v = window.localStorage[xtest[r'$']['localstorage'].name];
      v = JSON.decode(v);
      expect(v['foo'], newValue['foo']);
    });

    test('save', () {
      xtest['value']['foo'] = 'quux';
      xtest[r'$']['localstorage'].save();
      var v = window.localStorage[xtest[r'$']['localstorage'].name];
      v = JSON.decode(v);
      expect(v['foo'], 'quux');
    });

  });

}
