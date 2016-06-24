// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_list_different_heights_test;

import 'dart:async';
import 'dart:js';
import 'package:polymer_elements/iron_list.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'iron_list_test_helpers.dart';
import 'fixtures/x_list.dart';

/// Uses [XList].
main() async {
  await initPolymer();

  group('Different heights', () {
    IronList list;
    XList container;

    setUp(() {
      container = fixture('trivialList');
      list = container.list;
    });

    test('render without gaps 1', () async {
      list.items = [
        {'index': 0, 'height': 791},
        {'index': 1, 'height': 671}
      ];

      await wait(1);
      list.addAll('items', [
        {'index': 2, 'height': 251},
        {'index': 3, 'height': 191},
        {'index': 4, 'height': 151},
        {'index': 5, 'height': 191},
        {'index': 6, 'height': 51},
        {'index': 7, 'height': 51},
        {'index': 8, 'height': 51},
      ]);

      list.on['scroll'].first.then((_) {
        list.debounce('scroll', () {
          expect(isFullOfItems(list), isTrue);
        });
      });

      var done = new Completer();
      simulateScroll({'list': list, 'contribution': 20, 'target': 100000, "onScroll":() {
        expect(isFullOfItems(list),isTrue);
      },"onScrollEnd": () {
        done.complete();
      }});

      return done.future;
    },skip:'test runner window is too small');

    test('render without gaps 2', () async {
      var height = 2, items = [];

      while (items.length < 15) {
        items.add({'height': height});
        height *= 1.5;
      }
      list.items = items;

      await wait(1);
      list.on['scroll'].first.then((_) {
        list.debounce('scroll', () {
          expect(isFullOfItems(list), isTrue);
        });
      });

      var done = new Completer();
      simulateScroll({'list': list, 'contribution': 20, 'target': 100000,"onScroll":(){
        list.debounce("scroll",() {
          expect(isFullOfItems(list),isTrue);
        });
      },"onScrollEnd": () {
        done.complete();
      }});

      return done.future;
    },skip:'test runner window is too small');

    test('render without gaps 3', () async {
      var heights = [
        20,
        100,
        140,
        117,
        800,
        50,
        15,
        80,
        90,
        255,
        20,
        15,
        19,
        250,
        314
      ];

      list.items = heights.map((height) {
        return {'height': height};
      }).toList();

      await wait(1);
      list.on['scroll'].first.then((_) {
        list.debounce('scroll', () {
          expect(isFullOfItems(list), isTrue);
        });
      });

      var done = new Completer();
      simulateScroll({'list': list, 'contribution': 20, 'target': 100000,"onScroll":(){
        list.debounce("scroll",(){
          expect(isFullOfItems(list),isTrue);
        });
      }, "onScrollEnd": () {
        done.complete();
      }});

      return done.future;
    },skip:'test runner window is too small');
  });
}
