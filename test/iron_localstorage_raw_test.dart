@TestOn('browser')
library polymer_elements.test.iron_localstorage_basic_test;

import 'dart:async';
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

  group('raw', () {
    setUp(() {
      window.localStorage['iron-localstorage-test'] = 'hello world';
      storage = fixture('fixture');
      storage.jsElement.callMethod('flushDebouncer', ['reload']);
    });
    
    tearDown(() {
      window.localStorage.remove('iron-localstorage-test');
    });
    
    test('load', () {
      expect(storage.value, 'hello world');
    });
    
    test('save', () {
      var m = 'goodbye';
      storage.value = m;
      storage.jsElement.callMethod('save');
      var v = window.localStorage[storage.name];
      expect(v, m);
    });
  });

}
