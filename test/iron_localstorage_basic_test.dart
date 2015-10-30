// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_localstorage_basic_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_localstorage.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initPolymer();
  IronLocalstorage storage;

  group('basic', () {
    setUp(() {
      window.localStorage['iron-localstorage-test'] = '{"foo":"bar"}';
      storage = fixture('fixture');
      storage.jsElement.callMethod('flushDebouncer', ['reload']);
    });

    tearDown(() {
      window.localStorage.remove('iron-localstorage-test');
    });

    test('load', () {
      expect(storage.value, isNotNull);
      expect(storage.value['foo'], 'bar');
    });

    test('save', () {
      var newValue = {'foo': 'zot'};
      storage.value = newValue;
      storage.flushDebouncer('save');
      var v = window.localStorage[storage.name];
      v = JSON.decode(v);
      expect(v['foo'], newValue['foo']);
    });

    test('delete', () {
      storage.value = null;
      storage.flushDebouncer('save');
      var v = window.localStorage[storage.name];
      expect(v, isNull);
    });

    test('event iron-localstorage-load', () {
      var done = new Completer();
      var ls = document.createElement('iron-localstorage');
      ls.on['iron-localstorage-load'].take(1).listen((_) {
        done.complete();
      });
      ls.name = 'iron-localstorage-test';
      return done.future;
    });

    test('event iron-localstorage-load-empty', () {
      var done = new Completer();
      window.localStorage.remove('iron-localstorage-test');
      IronLocalstorage ls = document.createElement('iron-localstorage');
      ls.on['iron-localstorage-load-empty'].take(1).listen((_) {
        // testing recommended way to initialize localstorage
        ls.value = "Yo";
        ls.flushDebouncer('save');
        expect(
            "Yo", JSON.decode(window.localStorage['iron-localstorage-test']));
        done.complete();
      });
      ls.name = 'iron-localstorage-test';
      return done.future;
    });

    test('auto-save sub-properties', () {
      DomBind t = document.querySelector('#boundTemplate');
      var ls = document.querySelector('#boundLocal') as IronLocalstorage;
      var value = new JsObject.jsify({'foo': 'FOO', 'bar': 'BAR'});
      t['value'] = value;
      expect('FOO',
          ls.value['foo']); // value has propagated from template to storage
      ls.flushDebouncer('save');
      t['value']['foo'] = "Yo";
      ls.flushDebouncer('save');
      var item = JSON.decode(window.localStorage['iron-localstorage-test']);
      expect('Yo',
          isNot(item['foo'])); // did not propagate because did not use setters
      t.set('value.foo', 'BAZ!');
      ls.flushDebouncer('save');
      item = JSON.decode(window.localStorage['iron-localstorage-test']);
      expect('BAZ!', item['foo']); // did propagate
      ls.value = null;
    });
  });
}
